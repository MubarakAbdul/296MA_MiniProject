import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;


public class AStarSearch {
        private static class Node {
        int r;
        int c;
        double f;
        double g;
        double h;
        Node parent;

        Node (int r, int c, double g, double h, Node parent) {
            this.r = r;
            this.c = c;
            this.f = g+h;
            this.g = g;
            this.h = h;
            this.parent = parent;
        }
      }
      // Does !visited make sure that the nodes already visited is not taken into consideration?
      private static List <Node> getNeighbors (int r, int c, int target_r, int target_c, Node curr, String []grid, boolean [][]visited){
          List <Node> list = new ArrayList<Node> ();

          if(curr.r+1<r && curr.c+1<c && !visited[curr.r+1][curr.c+1] && grid[curr.r+1].charAt(curr.c+1) !='1'){
              Node newNode = new Node(curr.r+1, curr.c+1, 0, 0, curr);
              list.add(newNode);
          }
          if(curr.r+1<r && curr.c-1>=0 && !visited[curr.r+1][curr.c-1] && grid[curr.r+1].charAt(curr.c-1) !='1'){
              Node newNode = new Node(curr.r+1, curr.c-1, 0, 0, curr);
              list.add(newNode);
          }
          if(curr.r-1>=0 && curr.c-1>=0 && !visited[curr.r-1][curr.c-1] && grid[curr.r-1].charAt(curr.c-1) !='1'){
              Node newNode = new Node(curr.r-1, curr.c-1, 0, 0, curr);
              list.add(newNode);
          }
          if(curr.r-1>=0 && curr.c+1<c && !visited[curr.r-1][curr.c+1] && grid[curr.r-1].charAt(curr.c+1) !='1'){
              Node newNode = new Node(curr.r-1, curr.c+1, 0, 0, curr);
              list.add(newNode);
          }
          if(curr.r-1>=0 && !visited[curr.r-1][curr.c] && grid[curr.r-1].charAt(curr.c) !='1'){
              Node newNode = new Node(curr.r-1, curr.c, 0, 0, curr);
              list.add(newNode);
          }
          if(curr.c-1>=0 && !visited[curr.r][curr.c-1]&& grid[curr.r].charAt(curr.c-1) !='1'){
              Node newNode = new Node(curr.r, curr.c-1, 0, 0, curr);
              list.add(newNode);
          }
          if(curr.c+1<c && !visited[curr.r][curr.c+1] && grid[curr.r].charAt(curr.c+1) !='1'){
              Node newNode = new Node(curr.r, curr.c+1, 0, 0, curr);
              list.add(newNode);
          }
          if(curr.r+1<r && !visited[curr.r+1][curr.c]&& grid[curr.r+1].charAt(curr.c) !='1'){
              Node newNode = new Node(curr.r+1, curr.c, 0, 0, curr);
              list.add(newNode);
          }
          return list;
        }


private static void AStar(int r, int c, int start_r, int start_c, int target_r, int target_c, String [] grid){
        //Your logic here
        Stack <Node> path = new Stack<Node>();
        Stack <Node> expanded = new Stack<Node>();
        boolean [][] visited = new boolean [r][c];
        PriorityQueue <Node> queue = new PriorityQueue<Node>(r*c, new Comparator<Node>(){
            @Override
            public int compare(Node o1, Node o2){
                if (o1.f < o2.f){
                  return -1;
                }
                else if (o1.f > o2.f){
                  return 1;
                }
                else{
                  return 0;
                }
            }
        });
        Node start = new Node(start_r, start_c, 0, Math.abs(start_r-target_r)+Math.abs(start_c-target_c), null);
        queue.add(start);
        Node goal = null;

        while(!queue.isEmpty()){
        Node curr = queue.poll();
        visited[curr.r][curr.c] = true;

        if(grid[curr.r].charAt(curr.c)=='T'){
            goal = curr;
            break;
        }

        List <Node> neighbors = getNeighbors(r, c, target_r, target_c, curr, grid, visited);

        for (int i = 0; i<neighbors.size(); i++){
          Node curr2 = neighbors.get(i);

          double temp_g = curr.g + Math.pow(Math.pow(curr2.r-curr.r,2)+Math.pow(curr2.c-curr.c,2), 0.5);
          double temp_h = Math.abs(curr2.r-target_r)+Math.abs(curr2.c-target_c);
          double temp_f = temp_g + temp_h;

          if(!queue.contains(curr2) && !expanded.contains(curr2)){
              curr2.g = temp_g;
              curr2.h = temp_h;
              curr2.f = temp_f;
              queue.add(curr2);
          }
          if(expanded.contains(curr2) || queue.contains(curr2) ){
              if (curr2.f < temp_f){
                  continue;
              }
              else{
              curr2.g = temp_g;
              curr2.h = temp_h;
              curr2.f = temp_f;
                  if (expanded.contains(curr2)){
                      expanded.remove(curr2);
                  }
                  if (!queue.contains(curr2)){
                      queue.add(curr2);
                  }
              }
          }
        }
        expanded.push(curr);
    }
    Node curr2 = goal;
    if (curr2 == null){
      System.out.println("no solution");
    }
    else{
      double finalCost = curr2.f;
      while(curr2!=null){
          path.push(curr2);
          curr2 = curr2.parent;
      }
      //System.out.println(expanded.size());
      //for(Node curr3 : expanded){
      //    System.out.println(curr3.r + " " + curr3.c);
      //}
      System.out.println("final cost is " + finalCost);
      while(!path.isEmpty()){
          Node curr3 = path.pop();
          System.out.println(curr3.r + " " + curr3.c);
      }
    }
}

public static void main(String[] args) throws FileNotFoundException{
        String filename = args[0];
        Scanner in = new Scanner(new File(filename));

        int r = in.nextInt();
        int c = in.nextInt();

        int start_r = in.nextInt();
        int start_c = in.nextInt();

        int target_r = in.nextInt();
        int target_c = in.nextInt();

        String grid[] = new String[r];

        for(int i = 0; i < r; i++) {
            grid[i] = in.next();
        }
        AStar(r, c, start_r, start_c, target_r, target_c, grid);
        in.close();
    }
}
