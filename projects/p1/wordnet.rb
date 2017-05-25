require_relative "graph.rb"

class Synsets
    def initialize
        @s = Hash.new
    end

    def load(synsets_file)
        to_ent = Array.new
        to_out = Array.new
        File.open(synsets_file, "r") do |f|
            f.each_line do |line|
                arr = line.split(' ')
                arr2 = line.split(/ /)
                if arr2[0] == "id:" && arr2[2] == "synset:" then
                    if arr[1].to_i >= 0 && arr[1].to_i.to_s.length == arr[1].length then
                        if @s.has_key?(arr[1].to_i) == false then
                            bar = arr[3].to_s.split(',')
                            to_ent << Array[arr[1],bar]
                        end
                    end
                else
                    to_out << arr[1].to_i+1
                end
            end
        end

        if to_out.empty? == true then
            to_ent.each_index { |x| self.addSet(to_ent[x][0].to_i, to_ent[x][1])}
            return nil
        else
            return to_out.to_a
        end
    end

    def addSet(synset_id, nouns)
        if synset_id < 0 || nouns == nil || @s.has_key?(synset_id) == true then
            return false
        else
            @s[synset_id] = nouns
            return true
        end
    end

    def lookup(synset_id)
        if @s.has_key?(synset_id) == false then
            return nil
        else
            return @s.values_at(synset_id).shift
        end
    end

    def findSynsets(to_find)
        if to_find.is_a?(String) == true then
            return Array[@s.key(Array[to_find])]
        elsif to_find.is_a?(Array) == true then
            nh = @s.invert
            ks = nh.keys
            vs = nh.values
            kscpy = ks.flatten
            found = Array.new
            i = 0
            while i < ks.length
                if ks[i].length > 1 then
                    j = 0
                    while j < ks[i].length
                        found << [ks[i][j],nh.values_at(ks[i])]
                        j += 1
                    end
                else
                    found << [ks[i][0],Array[vs[i]]]
                end
                i += 1
            end
            fhsh = Hash.new
            i = 0
            while i < to_find.length
                j = 0
                while j < found.length
                    if to_find[i] == found[j][0] then
                        fhsh[found[j][0]] = found[j][1]
                    else
                    end
                    j += 1
                end
                i += 1
            end
            return fhsh
        else
            return nil
        end
    end
end

class Hypernyms
    def initialize
        @h = Graph.new
    end

    def load(hypernyms_file)
        to_ent = Array.new
        to_out = Array.new
        File.open(hypernyms_file, "r") do |f|
            f.each_line do |line|
                arr = line.split(' ')
                arr2 = line.chomp.split(/ /)
                print "#{arr}\n#{arr2}\n"
            end
        end
        return nil
    end

    def addHypernym(source, destination)
        if source < 0 || destination < 0 || source == destination then
            return false
        else
            if @h.hasVertex?(source) == false then
                @h.addVertex(source)
            else
            end

            if @h.hasVertex?(destination) == false then
                @h.addVertex(destination)
            else
            end

            if @h.hasEdge?(source, destination) == false then
                @h.addEdge(source, destination)
            else
            end
            return true
        end
    end

    def lca(id1, id2)
        raise Exception, "Not implemented"
    end
end

class CommandParser
    def initialize
        @synsets = Synsets.new
        @hypernyms = Hypernyms.new
    end

    def parse(command)
        raise Exception, "Not implemented"
    end
end
