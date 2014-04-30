cat << CTAG
{
	name:I/O,
		elements:[
			{ STitleBar:{
				title:"I/O Control"
			}},
				{ SSeekBar:{
					title:"Read-ahead Size",
					description:"Set the read-ahead size for the internal SD card.",
					unit:" KB",
					step:128,
					min:128,
					max:4096,
					default:`cat /sys/block/mmcblk0/queue/read_ahead_kb`,
					action:"generic /sys/block/mmcblk0/queue/read_ahead_kb"
				}},
				{ SOptionList:{
					title:"I/O Scheduler",
					description:"The I/O Scheduler decides how to prioritize and handle I/O requests. More info: <a href='http://timos.me/tm/wiki/ioscheduler'>HERE</a>",
					default:`echo $(/data/N4UKM/actions/bracket-option /sys/block/mmcblk0/queue/scheduler)`,
					action:"bracket-option /sys/block/mmcblk0/queue/scheduler",
					values:[
						`for IOSCHED in \`cat /sys/block/mmcblk0/queue/scheduler | sed -e 's/\]//;s/\[//'\`; do
							echo "\"$IOSCHED\","
						done`
					],
					notify:[
						{
							on:APPLY,
							do:[ REFRESH, CANCEL ],
							to:"/sys/block/mmcblk0/queue/iosched"
						},
						{
							on:REFRESH,
							do:REFRESH,
							to:"/sys/block/mmcblk0/queue/iosched"
						}
					]
				}}
			{ SPane:{
				title:"General I/O Tunables",
				description:"Set the internal storage general tunables"
			}},
				{ SCheckBox:{
					description:"Draw entropy from spinning (rotational) storage.",
					label:"Add Random",
					default:`cat /sys/block/mmcblk0/queue/add_random`,
					action:"generic /sys/block/mmcblk0/queue/add_random"
				}},
				{ SCheckBox:{
					description:"Maintain I/O statistics for this storage device. Disabling will break I/O monitoring apps.",
					label:"I/O Stats",
					default:`cat /sys/block/mmcblk0/queue/iostats`,
					action:"generic /sys/block/mmcblk0/queue/iostats"
				}},
				{ SCheckBox:{
					description:"Treat device as rotational storage.",
					label:"Rotational",
					default:`cat /sys/block/mmcblk0/queue/rotational`,
					action:"generic /sys/block/mmcblk0/queue/rotational"
				}},				
				{ SSeekBar:{
					title:"No Merges",
					description:"Types of merges (prioritization) the scheduler queue for this storage device allows.",
					default:`cat /sys/block/mmcblk0/queue/nomerges`,
					action:"generic /sys/block/mmcblk0/queue/nomerges",
					values:{
						`NM='0:"0: All", 1:"1: Simple Only", 2:"2: None",'
						echo $NM`
					}
				}},
				{ SSeekBar:{
					title:"RQ Affinity",
					description:"Try to have scheduler requests complete on the CPU core they were made from. Higher is more aggressive. Some kernels only support 0-1.",
					default:`cat /sys/block/mmcblk0/queue/rq_affinity`,
					action:"generic /sys/block/mmcblk0/queue/rq_affinity",
					values:{
						`RQA='0:"0: Disabled", 1:"1", 2:"2"'
						echo $RQA`
					}
				}},
			{ SPane:{
				title:"I/O Scheduler Tunables"
			}},
				{ STreeDescriptor:{
					path:"/sys/block/mmcblk0/queue/iosched",
					generic: {
						directory: {},
						element: {
							SGeneric: { title:"@NAME" }
						}
					},
				}},
		]
}
CTAG