extern crate petgraph;

use petgraph::Graph;
use petgraph::prelude::NodeIndex;
use petgraph::algo::dijkstra;

const SIZE: usize = 50;

#[cfg(test)]
mod tests {
    #[test]
    fn part_one() {
        assert_eq!(11, ::get_min_path((7, 4), 10));
    }
}

fn fill_grid(fav: i32) -> [[u8; SIZE]; SIZE] {
    let mut grid = [[0u8; SIZE]; SIZE];
    let loop_size: i32 = SIZE as i32;
    for x_coord in 0..loop_size {
        for y_coord in 0..loop_size {
            let tile_value = x_coord * x_coord + 3 * x_coord + 2 * x_coord * y_coord + y_coord +
                             y_coord * y_coord + fav;
            let binary_tile = format!("{:b}", tile_value);
            let mut sum: u32 = 0;
            for c in binary_tile.chars() {
                sum = sum + c.to_digit(10).unwrap();
            }
            grid[y_coord as usize][x_coord as usize] = (sum & 1) as u8;
        }
    }
    grid
}

fn print_grid(grid: &[[u8; SIZE]]) {
    for row in grid {
        for column in row.iter() {
            print!("{}", column);
        }
        println!();
    }
}

fn get_min_path(goal: (usize, usize), fav: i32) -> u8 {
    let grid = fill_grid(fav);
    print_grid(&grid);
    let graph = create_graph_no_diagonal(&grid);
    let start = NodeIndex::new(51);
    let scores = dijkstra(&graph, start, None, |e| *e.weight());
    let first_task = scores.get(&NodeIndex::new(goal.1 * SIZE + goal.0)).unwrap();
    let second_task: Vec<_> =
        scores.clone().into_iter().map(|(n, s)| (graph[n], s)).filter(|x| x.1 < 51).collect();
    println!("First task: {}", first_task);
    println!("Second task: {}", second_task.len());
    *first_task
}

fn create_graph_no_diagonal(grid: &[[u8; SIZE]])
                            -> Graph<(usize, usize), u8, petgraph::Undirected> {
    let mut graph: Graph<(usize, usize), u8, petgraph::Undirected> = Graph::new_undirected();
    for row in 0..SIZE {
        for column in 0..SIZE {
            graph.add_node((column, row));
            if grid[row][column] == 1 {
                continue;
            }
            let current = row * SIZE + column;
            if row != 0 && grid[row - 1][column] == 0 {
                graph.add_edge(NodeIndex::new(current - SIZE), NodeIndex::new(current), 1);
            }
            if column != 0 && grid[row][column - 1] == 0 {
                graph.add_edge(NodeIndex::new(current - 1), NodeIndex::new(current), 1);
            }
        }
    }
    graph
}

fn main() {
    get_min_path((31, 39), 1352);
}
