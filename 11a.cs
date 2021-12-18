using System;
using System.Linq;

namespace Aoc2021 {

    public class Octo {
        private int value;
        private bool flashed = false;
        public int flashes {get; private set;} = 0;
        public List<Octo> neighboring = new();

        public Octo(int value) {
            this.value = value;
        }

        public void Reset() {
            if(this.flashed) {
                this.value = 0;
                this.flashed = false;
            }
        }

        public void Update() {
            this.value++;
        }

        public void TryFlash() {
            if(!this.flashed && this.value > 9) {
                this.flashed = true;
                this.flashes++;
                foreach(var octo in this.neighboring) octo.Update();
                foreach(var octo in this.neighboring) octo.TryFlash();
            }
        }
    }

    public static class Day11A {
        public static IEnumerable<(T item, int index)> WithIndex<T>(this IEnumerable<T> source) { // Thank you stack overflow
            return source.Select((item, index) => (item, index));
        }

        public const int STEPS = 100;
        static Dictionary<(int x, int y), Octo> octos = new();

        static void Load() {
            foreach(var (line, y) in System.IO.File.ReadLines("./input/11.txt").WithIndex()) {
                foreach(var (value, x) in line.ToCharArray().WithIndex()) {
                    octos.Add((x, y), new Octo(value - '0'));
                }
            }

            foreach(var (coord, octo) in octos) AddNeighboring(coord, octo);
        }

        static void AddNeighboring((int x, int y) coord, Octo octo) {
            for(int i = -1; i <= 1; i++) {
                for(int j = -1; j <= 1; j++) {
                    if(i == 0 && j == 0) continue;
                    var pos = (coord.x + i, coord.y + j);
                    var neighbor = octos.ContainsKey(pos) ? octos[pos] : null;
                    if(neighbor != null) octo.neighboring.Add(neighbor);
                }
            }
        }

        public static void Main(string[] args) {
            Load();

            for(int i = 0; i < STEPS; i++) {
                foreach(var octo in octos.Values) octo.Reset();
                foreach(var octo in octos.Values) octo.Update();
                foreach(var octo in octos.Values) octo.TryFlash();
            }

            Console.WriteLine(octos.Values.Sum(octo => octo.flashes));
        }
    }

}