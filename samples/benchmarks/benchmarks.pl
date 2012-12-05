#!usr/bin/perl

chomp($proj_home = `echo \$M2S_PROJ_HOME`);
$m2s = $proj_home . "src/m2s";
$cfg_path = $proj_home . 'samples/projectconfig/';
$cpu_path = $cfg_path . 'cfg_cpu';
$mem_path = $cfg_path . 'cfg_mem';
$ctx_path = $cfg_path . 'cfg_ctx';

@tests = ("specrand","gromacs","hmmer","bzip2","gcc","bwaves"); 

@configs = (
  {"cpu" => "cfg-cpu-t2-RR",      "mem" => "cfg-mem"}, 
  {"cpu" => "cfg-cpu-t2-WRR-2",   "mem" => "cfg-mem"}, 
  {"cpu" => "cfg-cpu-t2-WRR-4",   "mem" => "cfg-mem"}, 
  {"cpu" => "cfg-cpu-t2-NBN-2",   "mem" => "cfg-mem"}, 
  {"cpu" => "cfg-cpu-t2-NBN-3",   "mem" => "cfg-mem"}, 
  {"cpu" => "cfg-cpu-t2-NBN-4",   "mem" => "cfg-mem"},
  {"cpu" => "cfg-cpu-t2-RR",      "mem" => "cfg-mem-50"}, 
  {"cpu" => "cfg-cpu-t2-WRR-2", 	"mem" => "cfg-mem-66"}, 
  {"cpu" => "cfg-cpu-t2-WRR-4", 	"mem" => "cfg-mem-80"}, 
  {"cpu" => "cfg-cpu-t2-NBN-2", 	"mem" => "cfg-mem-50"}, 
  {"cpu" => "cfg-cpu-t2-NBN-3", 	"mem" => "cfg-mem-75"}, 
  {"cpu" => "cfg-cpu-t2-NBN-4", 	"mem" => "cfg-mem-80"} 
); 
  
foreach $test (@tests)
{
# single thread test
  print "$m2s --x86-config cfg-cpu-t1 --ctx-config cfg-ctx-$test --mem-config cfg-mem --sim-detailed --max-inst 20000000 --x86-report $test.t1.log\n";

# smt tests
  for $i (0 .. $#configs)
  {
    my $cpu = $configs[$i]{"cpu"};
    my $mem = $configs[$i]{"mem"};
    print "\n<<Beginning Test>> :: $m2s --x86-config $cpu_path/$cpu --ctx-config $ctx_path/cfg-context-$test-$test --mem-config $mem_path/$mem --x86-sim detailed --x86-max-inst 20000000 --x86-report $test.$cpu.$mem.log\n";
    print `$m2s --x86-config $cpu_path/$cpu --ctx-config $ctx_path/cfg-context-$test-$test --mem-config $mem_path/$mem --x86-sim detailed --x86-max-inst 20000000 --x86-report $test.$cpu.$mem.log`;
  }

}
