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
        # opens 'synsets_file' in "r"-ead mode
        File.open(synsets_file, "r") { |file|
            # iterates through each line in 'file'
            file.each_line { |line|
                # creates an array of strings using String class's split function
                arr = line.split(' ')
                # creates an array of strings delimited by spaces
                arr2 = line.split(/ /)
                # initial check if line is valid
                if arr2[0] == "id:" && arr2[2] == "synset:" then
                    # checks if id in each line is a valid id (i.e. a non-negative integer)
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
        # returns false if there are any invalid parameters
        return false if synset_id < 0 || nouns.empty? == true || @s.has_key?(synset_id) == true
        @s.store(synset_id, nouns)
        return true
    end

    # Returns an Array
    def lookup(synset_id)
        # returns nil if the Synset doesn't have 'synset_id'
        return nil if @s.has_key?(synset_id) == false
        return @s.values_at(synset_id).shift
    end

    # Returns an Array, a Hash, or nil
    def findSynsets(to_find)
        # return an Array if 'to_find' is a String
        return Array[@s.key(Array[to_find])] if to_find.is_a?(String) == true
        # return nil if 'to_find' is neither an Array nor a String
        return nil if to_find.is_a?(String) == false && to_find.is_a?(Array) == false
        # creates a new Hash using invert to give the original Hash's keys as values and values as keys
        nhash = @s.invert
        # creates an Array using Hash's keys function
        words = nhash.keys
        # creates an Array using Hash's values function
        ids = nhash.values
        # Array variable to keep track of the found words with their keys
        found = Array.new
        i = 0
        # iterates through words Array
        while i < words.length
            # checks if there are multiple words at any index
            if words[i].length > 1 then
                j = 0
                # iterates through each word at index 'i'
                while j < words[i].length
                    # stores each word at index 'j' with its corresponding key (as an Array) separately
                    found << [words[i][j], nhash.values_at(words[i])]
                    j += 1
                end
            else
                # stores the word at index 'i' with its corresponding key (as an Array)
                found << [words[i][0], Array[ids[i]]]
            end
            i += 1
        end
        # Hash variable to store each index of 'found' to return at end
        fhash = Hash.new
        i = 0
        # iterates through 'to_find'
        while i < to_find.length
            j = 0
            # iterates through 'found' Array
            while j < found.length
                # stores word => key in 'found' at index 'j' if the word at
                # index 'i' in 'to_find' is the same as the word at index 'j' in 'found'
                fhash[found[j][0]] = found[j][1] if to_find[i] == found[j][0]
                j += 1
            end
            i += 1
        end
        # returns a Hash if 'to_find' is an Array
        return fhash
    end
end

class Hypernyms
    def initialize
        @h = Graph.new
    end

    # returns an Array or nil
    def load(hypernyms_file)
        # Opens 'hypernyms_file' in "r"-ead mode
        File.open(hypernyms_file, "r") { |file|
            # iterates through each line in 'file'
            file.each_line { |line|
                arr = line.split(' ')
                arr2 = line.split(/ /)
                print arr, "\n", arr2, "\n"
                if arr2[0] == "from:" && arr2[2] == "to:" then
                    if arr[1].to_i >= 0 && arr[1].length == arr[1].to_i.to_s.length then

                end
            }
        }
    end

    # returns a Bool(ean)
    def addHypernym(source, destination)
        # returns false in the case of invalid or similar parameters (i.e. negative numbers or the same number)
        return false if source < 0 || destination < 0 || source == destination
        # adds 'source' to the Hypernym if 'source' is not a vertex in the Hypernym
        @h.addVertex(source) if @h.hasVertex?(source) == false
        # adds 'destination' to the Hypernym if 'destination' is not a vertex in the Hypernym
        @h.addVertex(destination) if @h.hasVertex?(destination) == false
        # creates an Edge, connecting 'source' and 'destination' together if there doesn't exist
        # an Edge between 'source' and 'destination'
        @h.addEdge(source, destination) if @h.hasEdge?(source, destination) == false
        return true
    end

    # returns an Array or nil
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
