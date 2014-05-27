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
					default:`$BB cat \`sh $DEVICE DirIOReadAheadSize\``,
					action:"generic `sh $DEVICE DirIOReadAheadSize`"
				}},
				{ SOptionList:{
					title:"I/O Scheduler",
					description:"The I/O Scheduler decides how to prioritize and handle I/O requests. More info: <a href='http://timos.me/tm/wiki/ioscheduler'>HERE</a>",
					default:`$BB echo $($UKM/actions/bracket-option \`sh $DEVICE DirIOScheduler\`)`,
					action:"bracket-option `sh $DEVICE DirIOScheduler`",
					values:[
						`sh $DEVICE IOSchedulerList`
					],
					notify:[
						{
							on:APPLY,
							do:[ REFRESH, CANCEL ],
							to:"`sh $DEVICE DirIOSchedulerTree`"
						},
						{
							on:REFRESH,
							do:REFRESH,
							to:"`sh $DEVICE DirIOSchedulerTree`"
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
					default:`$BB cat /sys/block/mmcblk0/queue/add_random`,
					action:"generic /sys/block/mmcblk0/queue/add_random"
				}},
				{ SCheckBox:{
					description:"Maintain I/O statistics for this storage device. Disabling will break I/O monitoring apps.",
					label:"I/O Stats",
					default:`$BB cat /sys/block/mmcblk0/queue/iostats`,
					action:"generic /sys/block/mmcblk0/queue/iostats"
				}},
				{ SCheckBox:{
					description:"Treat device as rotational storage.",
					label:"Rotational",
					default:`$BB cat /sys/block/mmcblk0/queue/rotational`,
					action:"generic /sys/block/mmcblk0/queue/rotational"
				}},				
				{ SSeekBar:{
					title:"No Merges",
					description:"Types of merges (prioritization) the scheduler queue for this storage device allows.",
					default:`$BB cat /sys/block/mmcblk0/queue/nomerges`,
					action:"generic /sys/block/mmcblk0/queue/nomerges",
					values:{
						`NM='0:"0: All", 1:"1: Simple Only", 2:"2: None",'
						echo $NM`
					}
				}},
				{ SSeekBar:{
					title:"RQ Affinity",
					description:"Try to have scheduler requests complete on the CPU core they were made from. Higher is more aggressive. Some kernels only support 0-1.",
					default:`$BB cat /sys/block/mmcblk0/queue/rq_affinity`,
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
					path:"`sh $DEVICE DirIOSchedulerTree`",
					generic: {
						directory: {},
						element: {
							SGeneric: { title:"@BASENAME" }
						}
					},
				}},
		]
}
CTAG
