
#include <sys/resource.h>

#include <ros/ros.h>

int main(int argc, char ** argv) {

  struct rlimit limit = { .rlim_cur = 0, .rlim_max = 0 };
	getrlimit(RLIMIT_NOFILE, &limit);
  
  printf("limit.rlim_cur: %ld    limit.rlim_max: %ld\n", limit.rlim_cur, limit.rlim_max);

  ros::init(argc, argv, "loop");

  ros::spin();

  return 0;
}
