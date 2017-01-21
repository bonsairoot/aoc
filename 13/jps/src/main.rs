pub mod graph;
use graph::Graph;

const SIZE: usize = 30;

#[cfg(test)]
mod tests {
    #[test]
    fn part_one() {
        assert_eq!(11, ::get_min_path((7, 4), 10));
    }
}

fn fill_grid(fav: i32) -> [[u8; SIZE]; SIZE] {
    let mut grid = [[0u8; SIZE]; SIZE];
    let loop_size: i32 = (SIZE - 1) as i32;
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
        for column in row {
            print!("{}", column);
        }
        println!();
    }
}

fn get_min_path(goal: (u8, u8), fav: i32) -> u8 {
    let grid = fill_grid(fav);
    print_grid(&grid);
    let graph = create_graph_no_diagonal(&grid);
    let successors: Vec<usize> = graph.successors(30).collect();
    println!("{:?}", successors);
    11
}

fn create_graph_no_diagonal(grid: &[[u8; SIZE]]) -> Graph {
    let mut graph = Graph::new();

    for node in 1..(SIZE * SIZE) {
        graph.add_node();
    }

    for row in 0..(SIZE - 1) {
        for column in 0..(SIZE - 1) {
            if grid[row][column] == 1 {
                continue;
            }
            let current = row * SIZE + column;
            if row != 0 && grid[row - 1][column] == 0 {
                graph.add_edge(current - SIZE, current);
            }
            if column != 0 && grid[row][column - 1] == 0 {
                graph.add_edge(current - 1, current);
            }
        }
    }
    graph
}

fn main() {
    get_min_path((7, 4), 10);
}
