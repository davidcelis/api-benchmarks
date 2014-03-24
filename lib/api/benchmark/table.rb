module API
  class Benchmark
    class Table < Terminal::Table
      def initialize
        super({
          headings: ['Framework', 'Requests', 'Response Time', 'Requests/sec'],
          style: { border_i: '|' }
        })
      end

      def add_row(framework, results)
        results = parse_results(results)

        self << [
          "[#{framework.pretty}][#{framework}]",
          { value: results[:requests],   alignment: :right },
          { value: results[:avg_ms],     alignment: :right },
          { value: results[:per_second], alignment: :right }
        ]
      end

      def sort
        sorted = self.rows.map { |r| r.cells.map(&:value) }
        self.rows = sorted.sort_by { |r| r[3].to_f }.reverse
        self
      end

      private

      def parse_results(results)
        {
          requests:   results.match(/(\d+) requests in/)[1],
          avg_ms:     results.match(/Latency\s+([\d.]+ms)/)[1],
          per_second: results.match(/Requests\/sec:\s+([\d.]+)/)[1]
        }
      end
    end
  end
end
