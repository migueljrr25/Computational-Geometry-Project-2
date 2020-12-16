

class Polygon {
  
   ArrayList<Point> p     = new ArrayList<Point>();
   ArrayList<Edge>  bdry = new ArrayList<Edge>();
   ArrayList<Triangle>  Tarea = new ArrayList<Triangle>(); 
 
   
   
   Polygon( ){  }
   
   
   boolean isClosed(){ return p.size()>=3; }
   
   
   //cheking if the poligon is simple 
   boolean isSimple(){
     ArrayList<Edge> bdry = getBoundary();
     int iterator = 0;
     while( iterator < bdry.size())
     {
       int i=0;
       while(i < bdry.size())
       {
         
         if(iterator==i)
           {
           i++;
           continue;
         }
         //if the edge is adjacent ignore, jump until last inst of the loop
          if(adjacentComparison(bdry.get(iterator), bdry.get(i)) == true)
                {
                  i++;
                  continue;
              }
                //using the interception  test to tse ig conection is made
          if(bdry.get(iterator).intersectionTest(bdry.get(i)) == true) 
              {return false;}
         
         i++;
       }    
       iterator++;
     }
     
     return true;
   }
   //helper to find if itge edges are adgecent 
     boolean adjacentComparison(Edge num1, Edge num2)
   {
   PVector v1 , v2 , v3, v4;
//po
   v1 = new PVector(num1.p0.p.x,num1.p0.p.y);
   //p1
   v2 = new PVector(num1.p1.p.x,num1.p1.p.y);
   //p0
   v3 = new PVector(num2.p0.p.x,num2.p0.p.y);
   //p2
   v4 = new PVector(num2.p1.p.x,num2.p1.p.y);
   //cross
   if(  (v1.x ==v3.x && v1.y ==v3.y) ||  (v1.x ==v4.x && v1.y ==v4.y) || (v2.x ==v3.x && v2.y ==v3.y) || (v2.x ==v4.x && v2.y ==v4.y) )  
        { return true;}
   else
       {return false;}
   //return true;
   }
   
   
   
   // detecting if the point is inside to be a helper for diagonals 
   boolean pointInPolygon( Point point ){
     int counter = 0;
     ArrayList<Edge> bdry = getBoundary();
     // creating randon point to compare with actual edges.
       Point RandonPoint = new Point(point.p.x * 1000, point.p.y);
      // edge to test how many times intercepfrom the gicem point to a random point to depermin e if even or odd
      Edge TestEdge = new Edge(point, RandonPoint);
      
      for(int i = 0; i < bdry.size(); i++)
     {
   if(TestEdge.intersectionTest(bdry.get(i)) == true  && (TestEdge.optimizedIntersectionPoint(bdry.get(i)) != bdry.get(i).p0 || TestEdge.optimizedIntersectionPoint(bdry.get(i)) != bdry.get(i).p1))
       {
         counter = counter + 1;
       }
     }
      if(counter%4==1)
      {
       return true;
      }
     
     return false;
   }
   
   // using the get potential diagonal and as long as it is not adjacent we will add to the diagonals
   ArrayList<Edge> getDiagonals(){
     // TODO: Determine which of the potential diagonals are actually diagonals
     
   ArrayList<Edge> bdry = getBoundary();
   
     ArrayList<Edge> diag = getPotentialDiagonals();
     ArrayList<Edge> ret  = new ArrayList<Edge>();

      for(int i=0; i< diag.size(); i++)
     {  
       int counter = 0;
      for(int j = 0;j<bdry.size();j++)
      {
         if(!adjacentComparison(diag.get(i),bdry.get(j)) )
         {
           if(diag.get(i).intersectionTest(bdry.get(j))==true) 
                 counter++;
         }
      }
      if(counter>0)
        continue;
      else if (pointInPolygon(diag.get(i).midpoint())==false)
                 continue;
      else ret.add(diag.get(i));
     }

     return ret;
   }
   
   
   boolean ccw(){
     // TODO: Determine if the polygon is oriented in a counterclockwise fashion
     float acumulator = 0;
     float total = 0;
     if( !isClosed() ) return false;
     if( !isSimple() ) return false;
     int i = 0;
     ArrayList<Edge> bdry = getBoundary();
     while(i<bdry.size())
     {
       total = (bdry.get(i).p1.p.x - bdry.get(i).p0.p.x) * (bdry.get(i).p1.p.y + bdry.get(i).p0.p.y);
       acumulator = acumulator + total;
       i++;
  }
     if(acumulator < 0)
       return true;
       
     else
       return false;
   }
   
   
   boolean cw(){
     // TODO: Determine if the polygon is oriented in a clockwise fashion
//opposite if 0 special conditio n trigeted

     if( !isClosed() ) return false;
     if( !isSimple() ) return false;

     if(!ccw())
       return true;
       
     else
       return false;
   }
   
   
   //shoelace algorith 
   
   float area(){
     int sizeOfArray= 0 ; 
     float totalArea = 0;
     float areaAdder = 0;
     int upperBount = p.size();
     sizeOfArray  = p.size();
     sizeOfArray--;
     for( int i = 0; i< upperBount;i++)
     {
       PVector v1 , v2;
       v1 = new PVector(p.get(i).x(),p.get(i).y());
       v2 = new PVector(p.get(sizeOfArray).x(),p.get(sizeOfArray).y());
      // reading the values to the total value 
       areaAdder = areaAdder + ((v1.x +v2.x) * (v2.y - v1.y));
       sizeOfArray = i;
     }
     
     totalArea = areaAdder / 2 ;
    if (totalArea < 0)
          {
          totalArea = totalArea * -1;
          }
     
     return totalArea; 
     
   }
      //for(int i = 0; i< bdry.size()-2;i++)
   //{
   //   Tarea.add(p.get(0),p.get(j), p.get(j+1);
   //   print("number of triangles");
   //   j++;
   //}
   
   
   
   
   ArrayList<Edge> getBoundary(){
     return bdry;
   }


   ArrayList<Edge> getPotentialDiagonals(){
     ArrayList<Edge> ret = new ArrayList<Edge>();
     int N = p.size();
     for(int i = 0; i < N; i++ ){
       int M = (i==0)?(N-1):(N);
       for(int j = i+2; j < M; j++ ){
         ret.add( new Edge( p.get(i), p.get(j) ) );
       }
     }
     return ret;
   }
   

   void draw(){
     println( bdry.size() );
     for( Edge e : bdry ){
       e.draw();
     }
   }
   
   
   void addPoint( Point _p ){ 
     p.add( _p );
     if( p.size() == 2 ){
       bdry.add( new Edge( p.get(0), p.get(1) ) );
       bdry.add( new Edge( p.get(1), p.get(0) ) );
     }
     if( p.size() > 2 ){
       bdry.set( bdry.size()-1, new Edge( p.get(p.size()-2), p.get(p.size()-1) ) );
       bdry.add( new Edge( p.get(p.size()-1), p.get(0) ) );
     }
   }

}
