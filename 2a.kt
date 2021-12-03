import java.io.File

enum class DirType {
    Forward,
    Down,
    Up;

    companion object {
        fun from(str: String): DirType {
            return when (str.get(0)) {
                'f' ->  DirType.Forward
                'd' ->  DirType.Down
                'u' ->  DirType.Up
                else -> DirType.Forward
            }
        }
    }
}

fun main() {
    var commands = ArrayList<Pair<DirType, Int>>()
    var horiz = 0
    var depth = 0

    File("./input/2.txt").forEachLine { line: String ->
        commands.add(Pair(DirType.from(line), line.substringAfter(' ').trim().toInt()))
    }

    for((type, units) in commands) {
        when (type) {
            DirType.Forward -> horiz += units
            DirType.Down -> depth += units
            DirType.Up -> depth -= units
        }
    }

    println(horiz * depth)
}