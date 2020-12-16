

class Edge{
  
   Point p0,p1;
      
   Edge( Point _p0, Point _p1 ){
     p0 = _p0; p1 = _p1;
   }
      
   void draw(){
     line( p0.p.x, p0.p.y, 
           p1.p.x, p1.p.y );
   }
   
   void drawDotted(){
     float steps = p0.distance(p1)/6;
     for(int i=0; i<=steps; i++) {
       float x = lerp(p0.p.x, p1.p.x, i/steps);
       float y = lerp(p0.p.y, p1.p.y, i/steps);
       //noStroke();
       ellipse(x,y,3,3);
     }
  }
   
  public String toString(){
    return "<" + p0 + "" + p1 + ">";
  }
     
  Point midpoint( ){
    return new Point( PVector.lerp( p0.p, p1.p, 0.5f ) );     
  }
     
  boolean intersectionTest( Edge other ){
    PVector v1 = PVector.sub( other.p0.p, p0.p );
    PVector v2 = PVector.sub( p1.p, p0.p );
    PVector v3 = PVector.sub( other.p1.p, p0.p );
     
    float z1 = v1.cross(v2).z;
    float z2 = v2.cross(v3).z;
     
    if( (z1*z2)<0 ) return false;  

    PVector v4 = PVector.sub( p0.p, other.p0.p );
    PVector v5 = PVector.sub( other.p1.p, other.p0.p );
    PVector v6 = PVector.sub( p1.p, other.p0.p );

    float z3 = v4.cross(v5).z;
    float z4 = v5.cross(v6).z;
     
    if( (z3*z4<0) ) return false;  
     
    return true;  
  }
  
  Point optimizedIntersectionPoint( Edge other )
   {
     

     //// TODO: Implement A Faster Method To Find The Edge Intersection Point.
     //// Should return the intersection point or null, if no intersection exists.
     //// The result should be correct, but SPEED MATTERS.
     
     
     ////if( intersectionTest(other) ){
     //if( aabb.intersectionTest(aabb) ){
             
     float x1 = p0.p.x;
     float x2  = p1.p.x;
     float x3 = other.p0.p.x;
     float x4  = other.p1.p.x;
     //float x1 = p0.p.x;
     //float x2  = p1.p.x;
     //float x3 = other.p0.p.x;
     //float x4  = other.p1.p.x;
     
     //float y1 = p0.p.y;
     //float y2  = p1.p.y;
     //float y3 = other.p0.p.y;
     //float y4  = other.p1.p.y;
          
     float y1 = p0.p.y;
     float y2  = p1.p.y;
     float y3 = other.p0.p.y;
     float y4  = other.p1.p.y;
     
     //float calc1 = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
     //float calc2 = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
           float calc1 = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

      float calc2 = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
     // float intersectionX = x1 + (calc1 * (x2-x1));
     // float intersectionY = y1 + (calc1 * (y2-y1));
     
     //if (calc1 >= 0 && calc1 <= 1 && calc2 >= 0 && calc2 <= 1) {
     //  return new Point(intersectionX,intersectionY);
     //}
     //return null;
     //}
          float intersectionX = x1 + (calc1 * (x2-x1));
      float intersectionY = y1 + (calc1 * (y2-y1));
     Point intercetpPoint = new Point(intersectionX,intersectionY);
     if (calc1 >= 0 && calc1 <= 1 && calc2 >= 0 && calc2 <= 1) {
       return intercetpPoint;}
     
     return null;

     //else {return null;}
   }
   
  
}
