fun main(args: Array<String>) {
    val input = readInput("input/day8")
    val day8 = Day8()
    day8.part2(input).println()
}

class Day8 {

    fun part2(input: String): Int {
        val p = input.split("\n\n");
        val instructions = p[0].trim().split("").drop(1).dropLast(1);
        val map = p[1].split("\n");

        val rows = HashMap<String, Lookup>();

        for (instruction in map) {
            val parts = instruction.split(" = ");
            println(parts[0] + " " + parts[1])
            val key = parts[0];
            val look = parts[1].replace("(", "").replace(")", "").split(", ");
            rows[key] = Lookup(look[0], look[1])
        }

        var iterations = 0;
        var found = false;
        var currentKey = map.first().split(" = ")[0]
        var turns = 0;

        while (!found) {
            val lookup = rows[currentKey]
            val instruction = instructions[iterations];
            val next = if(instruction == "L") lookup!!.left else lookup!!.right;
            if (next == "ZZZ") {
                found = true;
            }
            currentKey = next;
            iterations++;
            if (iterations == instructions.size) {
                turns++
                iterations = 0;
            }
        }

        return turns * instructions.size + iterations;
    }


}

data class Lookup(val left: String, val right: String)
