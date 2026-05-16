# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  den.hosts.x86_64-linux = {
    robin-pc = {
      rootDrive = "/dev/nvme1n1";

      users.robin = { };
    };

    robin-thinkpad = {
      rootDrive = "/dev/nvme0n1";

      users.robin = { };
    };
  };
}
