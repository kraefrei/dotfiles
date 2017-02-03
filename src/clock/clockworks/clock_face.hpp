#ifndef CLOCKWORKS_DRIVER_H
#define CLOCKWORKS_DRIVER_H

#include <iostream>
#include <chrono>

namespace clockworks {
  class Clock_Face {
  public:
    Clock_Face();
    Clock_Face( const Clock_Face& other );
    virtual ~Clock_Face();
    Clock_Face& operator=( const Clock_Face& other );
    
    void check_face( void );
  protected:
  
  private:
    int display_time;
    int system_time;
    int pid; //Process ID for Fork Process updating clock face
    int attempt //Missed Step Counter?
  }

  std::ostream& operator<<( std::ostream& out, const Clock_Face& other );
}
