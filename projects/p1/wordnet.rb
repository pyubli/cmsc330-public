require_relative "graph.rb"

class Synsets
    def initialize
        @s = Hash.new
    end

    # Returns an Array or nil
    def load(synsets_file)
        # Array variable to keep track of valid lines
        to_ent = Array.new
        # Array variable to keep track of invalid line numbers
        to_out = Array.new
        # int variable to keep track of line numbers
        tracker = 1
        # opens synsets_file in "r"-ead mode
        File.open(synsets_file, "r") { |file|
            # iterates through each line in 'file'
            file.each_line { |line|
                # creates an array of strings using String class's split function
                arr = line.split(' ')
                # creates an array of strings delimited by spaces
                arr2 = line.split(/ /)
                # initial check if line is valid
                if arr2[0] == "id:" && arr2[2] == "synset:" then
                    # checks if id in each line is a valid id (e.g. a non-negative integer)
                    if arr[1].length.eql?(arr[1].to_i.to_s.length) then
                        # checks if the synset has the current key
                        if @s.has_key?(arr[1].to_i) == false then
                            # splits the synset into an array delimited by commas (if any)
                            bar = arr[3].to_s.split(',')
                            to_ent << Array[arr[1], bar]
                        end
                    end
                else
                    to_out << tracker
                end

                tracker = tracker.next

            }
        }

        return to_out.to_a if to_out.empty? == false
        to_ent.each_index { |x| self.addSet(to_ent[x][0].to_i, to_ent[x][1])}
        return nil
    end

    # Returns a Bool(ean)
    def addSet(synset_id, nouns)
        # checks for invalid parameters
        return false if synset_id < 0 || nouns.empty? == true || @s.has_key?(synset_id) == true
        @s.store(synset_id, nouns)
        return true
    end

    # Returns an Array
    def lookup(synset_id)
        return nil if @s.has_key?(synset_id) == false
        return @s.values_at(synset_id).shift
    end

    # Returns an Array, a Hash, or nil
    def findSynsets(to_find)
        return Array[@s.key(Array[to_find])] if to_find.is_a?(String) == true
        return nil if to_find.is_a?(String) == false && to_find.is_a?(Array) == false
        nhash = @s.invert
        ids = nhash.keys
        words = nhash.values
        found = Array.new
        i = 0
        while i < ids.length
            if ids[i].length > 1 then
                j = 0
                while j < ids[i].length
                    found << [ids[i][j], nhash.values_at(ids[i])]
                    j += 1
                end
            else
                found << [ids[i][0], Array[words[i]]]
            end
            i += 1
        end
        fhash = Hash.new
        i = 0
        while i < to_find.length
            j = 0
            while j < found.length
                fhash[found[j][0]] = found[j][1] if to_find[i] == found[j][0]
                j += 1
            end
            i += 1
        end
        return fhash
    end
end

class Hypernyms
    def initialize
        @h = Graph.new
    end

    def load(hypernyms_file)
        raise Exception, "Not implemented"
    end

    def addHypernym(source, destination)
        raise Exception, "Not implemented"
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
