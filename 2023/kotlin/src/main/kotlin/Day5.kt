fun main(args: Array<String>) {
    val input = readInput("input/day5")
    val day5 = Day5()
    day5.part2(input).println()
}

class Day5 {
    fun part2(input: String): Long {
        val parts = input.split("\n\n")
        val seeds = parts[0].replace("seeds: ", "").split(" ").map{it.toLong()}
        val converters = parts.drop(1).map { parseConverter(it) }
        var min = Long.MAX_VALUE

        for (i in 0..<(seeds.size) step 2) {
            val time = System.currentTimeMillis()
            println(
                "Next seed iteration... ${seeds[i]} + ${seeds[i + 1]} - time: $time");
            for (j in seeds[i] ..< seeds[i] + seeds[i + 1] step 1) {
                val l = seedToLocation(j, converters)
                if (l < min) {
                    min = l;
                }
            }
        }
        return min;
    }

    private fun seedToLocation(seed: Long, converters: Iterable<Converter>): Long {
        var v = seed
        for (c in converters) {
            v = c.convert(v);
        }
        return v;
    }

    private fun parseConverter(input: String): Converter {
        val rows = input.split("\n").drop(1);
        val rs = rows.filter { it.isNotEmpty() }.map {
            val values = it.split(" ")
            Range(values[1].toLong(), values[0].toLong(), values[2].toLong())
        }
        return Converter(rs);
    }
}

data class Range(val sourceStart: Long, val destinationStart: Long, val range: Long)

class Converter(private val ranges: List<Range>) {

    fun convert(value: Long): Long {
        for (r in ranges) {
            if (value >= r.sourceStart && value < r.sourceStart + r.range) {
                val dist = value - r.sourceStart;
                return r.destinationStart + dist;
            }
        }
        return value;
    }
}
