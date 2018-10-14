module Exercise
  class PacketProcessor
    def initialize(buffer_size, packets)
      @buffer_size = buffer_size
      @packets = packets.map { |arrived_at, size| Packet.new(arrived_at, size) }
    end

    def process # rubocop:disable Metrics/PerceivedComplexity
      @process ||=
        begin
          buffer = []
          processed = []
          all_packets = []
          @packets.each do |packet|
            while buffer.any? && buffer.first.finished_at <= packet.arrived_at
              processed << buffer.shift
            end
            if buffer.size < @buffer_size
              idle_at =
                if buffer.any?
                  buffer.last.finished_at
                elsif processed.any?
                  processed.last.finished_at
                else
                  0
                end
              started_at = [idle_at, packet.arrived_at].max
              processed_packet = ProcessedPacket.new(packet, started_at)
              buffer << processed_packet
              all_packets << processed_packet
            else
              all_packets << UnprocessedPacket.new(packet)
            end
          end
          all_packets
        end
    end

    class Packet
      attr_reader :arrived_at, :size

      def initialize(arrived_at, size)
        @arrived_at = arrived_at
        @size = size
      end
    end

    class ProcessedPacket
      attr_reader :started_at

      def initialize(packet, started_at)
        @packet = packet
        @started_at = started_at
      end

      def finished_at
        @finished_at ||= @started_at + @packet.size
      end
    end

    class UnprocessedPacket
      def initialize(packet)
        @packet = packet
      end

      def started_at
        -1
      end
    end
  end
end
