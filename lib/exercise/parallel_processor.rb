module Exercise
  class ParallelProcessor
    def initialize(worker_count, jobs = [])
      @worker_count = worker_count
      @jobs = jobs
    end

    def run
      workers = Array.new(@worker_count) { |i| Worker.new(i, 0) }
      heap = Heap.new(workers)
      @jobs.map do |j|
        worker = heap.first
        heap.replace_first(worker.work(j))
        worker
      end
    end

    class Worker
      include Comparable

      attr_reader :id, :available_at

      def initialize(id, available_at = id)
        @id = id
        @available_at = available_at
      end

      def <=>(other)
        if available_at != other.available_at
          available_at <=> other.available_at
        else
          id <=> other.id
        end
      end

      def work(time)
        Worker.new(id, available_at + time)
      end
    end
  end
end
