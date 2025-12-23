# Yogstation AI System Port - Action Plan

**Project Goal:** Port Yogstation's decentralized AI network system to Monkestation while maintaining compatibility with existing systems.

**Status:** Planning Phase
**Branch:** AI
**Estimated Complexity:** High - Major Systems Overhaul

---

## Phase 1: Core Infrastructure Setup (Foundation)

### 1.1 Create AI Network Directory Structure
- [ ] Create `code/modules/mob/living/silicon/ai/ai_network/` directory
- [ ] Create subdirectories:
  - `ai_network/` - Core network datum and ethernet cables
  - `decentralized/` - AI data cores and hardware
  - `decentralized/systech/` - CPU, RAM, and rack creation
  - `decentralized/management/` - Dashboards and monitoring
  - `decentralized/projects/` - AI project system

### 1.2 Define Core Constants and Globals
**File:** `code/__DEFINES/ai.dm`

Add these constants:
```dm
// AI Network Temperature Limits
#define AI_TEMP_LIMIT 250 // Default temperature limit in Kelvin
#define AI_HEATSINK_CAPACITY 3000 // Heat capacity for cooling calculations
#define AI_TEMPERATURE_MULTIPLIER 1 // Temperature increase multiplier

// AI Hardware Power Usage
#define AI_CPU_BASE_POWER_USAGE 1000 // Base watts per CPU
#define AI_RAM_POWER_USAGE 50 // Watts per TB of RAM
#define AI_DATA_CORE_POWER_USAGE 7500 // Watts for active data core

// AI Server Cabinet
#define MAX_AI_SERVER_CABINET_TICKS (15 * (20 / SSair.wait)) // Ticks before shutdown
#define AI_MAX_CPUS_PER_RACK 4
#define AI_MAX_RAM_PER_RACK 4

// AI Project Categories
#define AI_PROJECT_HUDS "Sensor HUDs"
#define AI_PROJECT_CAMERAS "Visibility Upgrades"
#define AI_PROJECT_INDUCTION "Induction"
#define AI_PROJECT_SURVEILLANCE "Surveillance"
#define AI_PROJECT_EFFICIENCY "Efficiency"
#define AI_PROJECT_CROWD_CONTROL "Crowd Control"
#define AI_PROJECT_CYBORG "Cyborg Management"
#define AI_PROJECT_MISC "Misc."

// AI Research
#define AI_RESEARCH_PER_CPU 0.5 // Research points per CPU percentage per process tick
#define AI_FLOPPY_DECRYPTION_COST 1000 // CPU cycles to decrypt puzzle disk
#define AI_FLOPPY_EXPONENT 2 // Exponential scaling for decryption
#define AI_BLACKBOX_PROCESSING_REQUIREMENT 10000 // CPU cycles to revive AI

// Local Network CPU Usage Types
#define SYNTH_RESEARCH "Research"
#define CRYPTO_MINING "Cryptocurrency Mining"
```

**File:** `code/_globalvars/lists/ai_networks.dm` (NEW)
```dm
GLOBAL_LIST_INIT(ai_project_categories, list(
	AI_PROJECT_HUDS,
	AI_PROJECT_CAMERAS,
	AI_PROJECT_SURVEILLANCE,
	AI_PROJECT_EFFICIENCY,
	AI_PROJECT_CROWD_CONTROL,
	AI_PROJECT_CYBORG,
	AI_PROJECT_MISC
))

GLOBAL_LIST_INIT(possible_ainet_activities, list(
	SYNTH_RESEARCH,
	CRYPTO_MINING
))

GLOBAL_LIST_INIT(ainet_activity_tagline, list(
	SYNTH_RESEARCH = "Generate research points",
	CRYPTO_MINING = "Mine cryptocurrency"
))

GLOBAL_LIST_INIT(ainet_activity_description, list(
	SYNTH_RESEARCH = "Unused CPU cycles will generate research points for the station",
	CRYPTO_MINING = "Unused CPU cycles will mine cryptocurrency that can be withdrawn"
))

GLOB AL_LIST_EMPTY(server_cabinets) // All server cabinets on station
GLOBAL_LIST_EMPTY(data_cores) // All AI data cores
GLOBAL_LIST_EMPTY(ai_networking_machines) // Networking machines for remote connections
GLOBAL_LIST_EMPTY(ethernet_cable_list) // All ethernet cables

GLOBAL_VAR(primary_data_core) // Reference to primary AI data core
```

---

## Phase 2: AI Network Infrastructure (Core Systems)

### 2.1 Ethernet Cable System
**File:** `code/modules/mob/living/silicon/ai/ai_network/ethernet_cable.dm` (NEW)

**Sprites Needed:**
```dm
// PLACEHOLDER: Use 'icons/obj/power_cond/cable.dmi' "0-1" state until proper sprites available
// TODO: Need dedicated ethernet cable sprites (blue tint, thinner than power cables)
icon = 'icons/obj/power_cond/cable.dmi' // PLACEHOLDER - needs proper ethernet cable sprites
icon_state = "0-1" // PLACEHOLDER
```

**Implementation:**
- [ ] Create `/obj/structure/ethernet_cable` base type
- [ ] Implement network connection system (similar to power cables)
- [ ] Add cable layer mechanics
- [ ] Create cable coil item `/obj/item/stack/cable_coil/ethernet`
- [ ] PLACEHOLDER: Use existing cable sprites with blue overlay

### 2.2 AI Network Datum
**File:** `code/modules/mob/living/silicon/ai/ai_network/ai_network.dm` (NEW)

**Implementation:**
- [ ] Create `/datum/ai_network` base
- [ ] Implement cable tracking lists
- [ ] Implement node (machine) tracking
- [ ] Add AI list management
- [ ] Create resource calculation procs
- [ ] Add network merging/splitting logic
- [ ] Implement temperature limit tracking
- [ ] Add Bitcoin payout system
- [ ] Create local CPU usage management

**Key Procs:**
```dm
/datum/ai_network/proc/add_cable(obj/structure/ethernet_cable/C)
/datum/ai_network/proc/remove_cable(obj/structure/ethernet_cable/C)
/datum/ai_network/proc/add_machine(obj/machinery/ai/M)
/datum/ai_network/proc/remove_machine(obj/machinery/ai/M)
/datum/ai_network/proc/add_ai(mob/living/silicon/ai/AI)
/datum/ai_network/proc/remove_ai(mob/living/silicon/ai/AI)
/datum/ai_network/proc/update_resources()
/datum/ai_network/proc/total_cpu()
/datum/ai_network/proc/total_ram()
```

### 2.3 Shared Resources Datum
**File:** `code/modules/mob/living/silicon/ai/ai_network/shared_resources.dm` (NEW)

**Implementation:**
- [ ] Create `/datum/ai_shared_resources`
- [ ] Implement CPU allocation system (percentage-based)
- [ ] Implement RAM allocation system (TB-based)
- [ ] Add resource source tracking
- [ ] Create resource assignment lists
- [ ] Add human_lock toggle for crew control
- [ ] Implement resource update calculations
- [ ] Add resource splitting for network separation
- [ ] Create resource merging for network connection

**Key Procs:**
```dm
/datum/ai_shared_resources/proc/set_cpu(target, amount)
/datum/ai_shared_resources/proc/add_ram(target, amount)
/datum/ai_shared_resources/proc/remove_ram(target, amount)
/datum/ai_shared_resources/proc/total_cpu()
/datum/ai_shared_resources/proc/total_ram()
/datum/ai_shared_resources/proc/total_cpu_assigned()
/datum/ai_shared_resources/proc/total_ram_assigned()
/datum/ai_shared_resources/proc/split_resources(datum/ai_network/split_network)
/datum/ai_shared_resources/proc/merge_resources(datum/ai_shared_resources/new_resources)
```

---

## Phase 3: AI Hardware Components

### 3.1 Base AI Machinery
**File:** `code/modules/mob/living/silicon/ai/ai_network/_ai_machinery.dm` (NEW)

**Sprites Needed:**
```dm
// PLACEHOLDER: Use 'icons/obj/machines/research.dmi' "RD-server-on" until proper sprites
// TODO: Need dedicated AI machinery sprites
```

**Implementation:**
- [ ] Create `/obj/machinery/ai` base type
- [ ] Add `core_temp` variable for temperature tracking
- [ ] Implement `connect_to_ai_network()` proc
- [ ] Implement `disconnect_from_ai_network()` proc
- [ ] Add atmospheric processing for cooling
- [ ] Create `valid_holder()` status checking
- [ ] Add network reference variable

### 3.2 AI Data Core
**File:** `code/modules/mob/living/silicon/ai/decentralized/ai_data_core.dm` (NEW)

**Sprites Needed:**
```dm
// PLACEHOLDER: Use 'icons/obj/machines/research.dmi' states until proper sprites
// TODO: Need AI data core sprites (different states for online/offline/smoking)
icon = 'icons/obj/machines/research.dmi' // PLACEHOLDER
icon_state = "RD-server-on" // PLACEHOLDER - core-online
// icon_state = "RD-server-off" // PLACEHOLDER - core-offline
// icon_state = "RD-server-halt" // PLACEHOLDER - core-overheating
```

**Implementation:**
- [ ] Create `/obj/machinery/ai/data_core`
- [ ] Add AI storage capability (AIs physically reside here)
- [ ] Implement temperature management
- [ ] Add heat generation based on CPU load
- [ ] Create cooling mechanics with environment
- [ ] Add smoke effects for overheating
- [ ] Implement AI relocation when core fails
- [ ] Add examine text with AI laws display
- [ ] Create valid_ticks system for stability
- [ ] Add integrated_battery for backup power

**Key Features:**
- AIs can transfer between data cores
- Overheating causes AI to relocate
- Battery backup when unpowered
- Shows connected AI laws on examine

### 3.3 Server Cabinet
**File:** `code/modules/mob/living/silicon/ai/decentralized/server_cabinet.dm` (NEW)

**Sprites Needed:**
```dm
// PLACEHOLDER: Use 'icons/obj/machines/telecomms.dmi' "expansion_bus" variants
// TODO: May need dedicated server cabinet sprites
icon = 'icons/obj/machines/telecomms.dmi' // PLACEHOLDER - actually works well
icon_state = "expansion_bus"
```

**Implementation:**
- [ ] Create `/obj/machinery/ai/server_cabinet`
- [ ] Add rack installation system (accepts `/obj/item/server_rack`)
- [ ] Implement CPU/RAM totaling from installed racks
- [ ] Add power consumption calculation
- [ ] Create temperature monitoring
- [ ] Add valid_holder() checking (power, temp, network)
- [ ] Implement puzzle disk slot for decryption
- [ ] Add crowbar removal of racks
- [ ] Create overlays for rack count

**Specs:**
- Default: 2 rack slots (can be upgraded with parts)
- Each rack contains CPUs and RAM
- Generates heat proportional to CPU usage
- Must be cooled or shuts down

### 3.4 Server Rack Item
**File:** `code/modules/mob/living/silicon/ai/decentralized/systech/rack.dm` (NEW)

**Sprites Needed:**
```dm
// PLACEHOLDER: Use 'icons/obj/module.dmi' "circuitboard" until proper sprites
// TODO: Need server rack item sprite
icon = 'icons/obj/module.dmi' // PLACEHOLDER
icon_state = "circuitboard" // PLACEHOLDER - should be "server_rack"
```

**Implementation:**
- [ ] Create `/obj/item/server_rack`
- [ ] Add `contained_cpus` list
- [ ] Add `contained_ram` variable (in TB)
- [ ] Create `get_cpu()` proc (sums all CPU speeds)
- [ ] Create `get_ram()` proc
- [ ] Create `get_power_usage()` proc
- [ ] Add examine text showing contents

### 3.5 CPU Items
**File:** `code/modules/mob/living/silicon/ai/decentralized/systech/cpu.dm` (NEW)

**Sprites Needed:**
```dm
// PLACEHOLDER: Use 'icons/obj/module.dmi' "aimodule" until proper sprites
// TODO: Need CPU sprites (basic, advanced, bluespace variants)
icon = 'icons/obj/module.dmi' // PLACEHOLDER
icon_state = "aimodule" // PLACEHOLDER - should be "cpuboard", "cpuboard_adv", "cpuboard_super"
```

**Implementation:**
- [ ] Create `/obj/item/ai_cpu` base
- [ ] Add `speed` variable (in THz)
- [ ] Add `base_power_usage` variable
- [ ] Add `power_multiplier` for overclocking
- [ ] Create CPU variants:
  - `/obj/item/ai_cpu` - 1 THz base
  - `/obj/item/ai_cpu/advanced` - 2 THz
  - `/obj/item/ai_cpu/bluespace` - 3 THz
  - `/obj/item/ai_cpu/experimental` - 2 THz with better OC
- [ ] Implement `get_power_usage()` proc
- [ ] Add overclocking system (future feature)

### 3.6 RAM Items
**File:** `code/modules/mob/living/silicon/ai/decentralized/systech/ram.dm` (NEW)

**Sprites Needed:**
```dm
// PLACEHOLDER: Use 'icons/obj/module.dmi' "circuitboard" with overlay
// TODO: Need RAM stick sprites (1TB, 2TB, 4TB, 8TB variants)
icon = 'icons/obj/module.dmi' // PLACEHOLDER
icon_state = "circuitboard" // PLACEHOLDER - should be "ram_1tb", "ram_2tb", etc.
```

**Implementation:**
- [ ] Create `/obj/item/ai_ram` with capacity variants
- [ ] Add capacity variable (1, 2, 4, 8 TB)
- [ ] Create research designs for each tier
- [ ] Add to rack creator menu

### 3.7 Rack Creator Machine
**File:** `code/modules/mob/living/silicon/ai/decentralized/systech/rack_creator.dm` (NEW)

**Sprites Needed:**
```dm
// PLACEHOLDER: Use 'icons/obj/machines/research.dmi' "protolathe" or similar
// TODO: May want dedicated rack creator sprite
icon = 'icons/obj/machines/research.dmi' // PLACEHOLDER
icon_state = "protolathe" // PLACEHOLDER - should be "rack_creator"
```

**Implementation:**
- [ ] Create `/obj/machinery/rack_creator`
- [ ] Add CPU insertion system (up to 4 CPUs per rack)
- [ ] Add RAM insertion system (up to 4 RAM sticks per rack)
- [ ] Implement material requirements
- [ ] Add TGUI interface for assembly
- [ ] Create "Finalize Rack" button
- [ ] Check for research unlocks (additional slots)
- [ ] Connect to materials silo system

### 3.8 Networking Machine
**File:** `code/modules/mob/living/silicon/ai/ai_network/networking_machines.dm` (NEW)

**Sprites Needed:**
```dm
// PLACEHOLDER: Use 'icons/obj/machines/telecomms.dmi' "hub" or "relay"
// TODO: May want networking machine sprite with dish overlay
icon = 'icons/obj/machines/telecomms.dmi' // PLACEHOLDER
icon_state = "hub" // PLACEHOLDER - should be "networking_base"
// Add dish_overlay for directional connection
```

**Implementation:**
- [ ] Create `/obj/machinery/ai/networking`
- [ ] Add partner connection system
- [ ] Implement rotation_to_partner for visual
- [ ] Add manual multitool connection
- [ ] Create roundstart_connection mapping support
- [ ] Add locked toggle to prevent changes
- [ ] Implement network resource sharing

### 3.9 Master Subcontroller
**File:** `code/modules/mob/living/silicon/ai/ai_network/master_subcontroller.dm` (NEW)

**Sprites Needed:**
```dm
// PLACEHOLDER: Use 'icons/obj/machines/telecomms.dmi' "hub" is actually good
icon = 'icons/obj/machines/telecomms.dmi' // Works fine
icon_state = "hub"
```

**Implementation:**
- [ ] Create `/obj/machinery/ai/master_subcontroller`
- [ ] Add on/off toggle
- [ ] Implement area type enable/disable lists
- [ ] Add to AI network as `cached_subcontroller`
- [ ] Create `has_subcontroller_connection()` AI proc
- [ ] Reduce delays when subcontroller available:
  - Instant APC access instead of 1s delay
  - Instant door access
  - Instant air alarm access

---

## Phase 4: AI Dashboard and Projects

### 4.1 AI Dashboard Datum
**File:** `code/modules/mob/living/silicon/ai/decentralized/management/ai_dashboard.dm` (NEW)

**Implementation:**
- [ ] Create `/datum/ai_dashboard`
- [ ] Add owner reference (AI or synth)
- [ ] Track available_projects list
- [ ] Track completed_projects list
- [ ] Track running_projects list
- [ ] Add cpu_usage associative list (project name = usage)
- [ ] Add ram_usage associative list
- [ ] Add free_ram variable
- [ ] Create TGUI interface
- [ ] Implement resource allocation UI
- [ ] Add project start/stop controls
- [ ] Create tick() proc for processing

### 4.2 AI Project Base
**File:** `code/modules/mob/living/silicon/ai/decentralized/projects/_ai_project.dm` (NEW)

**Implementation:**
- [ ] Create `/datum/ai_project` base
- [ ] Add name, description, category
- [ ] Add research_cost variable
- [ ] Add research_progress tracking
- [ ] Add ram_required variable
- [ ] Add can_be_run toggle
- [ ] Add for_synths toggle
- [ ] Create canResearch() proc
- [ ] Create canRun() proc
- [ ] Create run_project() proc
- [ ] Create stop() proc
- [ ] Create finish() proc
- [ ] Add switch_network() for network changes

### 4.3 Example AI Projects
**Files:** Create in `code/modules/mob/living/silicon/ai/decentralized/projects/`

**Memory Compressor** - `memory_compressor.dm`
- [ ] Increases available RAM by 3TB
- [ ] Requires 15% CPU to run
- [ ] Research cost: 2250 points

**Enhanced Coolant Management** - `coolant_manager.dm`
- [ ] Increases temperature limit by 10K
- [ ] Passive effect, no runtime cost
- [ ] Research cost: 2250 points

**Camera Upgrades** - `camera_upgrades.dm`
- [ ] Various camera range/quality improvements
- [ ] PLACEHOLDER: Effects to be determined

**HUD Upgrades** - `hud_upgrades.dm`
- [ ] Medical/Security HUD improvements
- [ ] PLACEHOLDER: Effects to be determined

### 4.4 Server Overview Console
**File:** `code/modules/mob/living/silicon/ai/decentralized/management/ai_server_overview.dm` (NEW)

**Sprites Needed:**
```dm
// PLACEHOLDER: Use standard computer console sprites
// TODO: Custom console screen for AI server monitoring
icon = 'icons/obj/machines/computer.dmi' // PLACEHOLDER
icon_keyboard = "generic_key"
icon_screen = "security" // PLACEHOLDER - should be "ai_server"
```

**Implementation:**
- [ ] Create `/obj/machinery/computer/ai_server_console`
- [ ] Display all server cabinets on station
- [ ] Show temperature, CPU, RAM for each
- [ ] Show working/offline status
- [ ] Add TGUI interface
- [ ] Read-only monitoring (no control)

---

## Phase 5: AI Modifications

### 5.1 AI Core Changes
**File:** `code/modules/mob/living/silicon/ai/ai.dm`

**Changes Needed:**
- [ ] Add `var/datum/ai_network/ai_network` reference
- [ ] Add `var/datum/ai_dashboard/dashboard` reference
- [ ] Add `var/is_dying` flag for death/revival states
- [ ] Modify Initialize() to:
  - Create dashboard datum
  - Call `relocate()` if not in data core
  - Connect to AI network
- [ ] Add `relocate()` proc:
  - Finds available AI data core
  - Moves AI to that core
  - Updates network connections
- [ ] Add `has_subcontroller_connection(area/A)` proc
- [ ] Modify APC interaction to check subcontroller
- [ ] Modify door interaction to check subcontroller
- [ ] Modify air alarm interaction to check subcontroller

### 5.2 AI Life Cycle
**File:** `code/modules/mob/living/silicon/ai/life.dm`

**Changes Needed:**
- [ ] Modify power loss handling to use data cores
- [ ] Add network resource checking
- [ ] Update battery usage for network-less AIs
- [ ] Add dashboard tick processing
- [ ] Maintain compatibility with existing power restoration

### 5.3 AI Death and Revival
**File:** `code/modules/mob/living/silicon/ai/death.dm`

**New Features:**
- [ ] Create `/obj/item/dead_ai` - Dead AI blackbox
  - Contains consciousness of dead AI
  - Has battery that drains over time
  - Can be inserted into data core
  - Requires CPU allocation to revive
  - Track processing_progress
- [ ] Modify death() to create blackbox item
- [ ] Add revival system through CPU allocation
- [ ] PLACEHOLDER: Use intellicard sprites initially

**Sprites Needed:**
```dm
// PLACEHOLDER: Use 'icons/obj/devices/syndi_gadgets.dmi' "ai" (intellicard)
// TODO: Need dedicated dead AI blackbox sprite
```

---

## Phase 6: Jobs and Access

### 6.1 Network Admin Job
**File:** `code/modules/jobs/job_types/network_admin.dm` (NEW)

**Implementation:**
- [ ] Create `/datum/job/network_admin`
- [ ] Set access: AI Sat, Science, Engineering, TComms
- [ ] Set spawn: 1 position
- [ ] Set supervisors: CE and RD
- [ ] Create outfit `/datum/outfit/job/network_admin`
- [ ] PLACEHOLDER: Use existing engineer/scientist outfit mix
- [ ] Add to job controller
- [ ] Add spawn point landmark
- [ ] Update access lists

**Outfit Needed:**
```dm
// PLACEHOLDER: Mix of engineering and science items
// TODO: Custom Network Admin outfit
/datum/outfit/job/network_admin
	name = "Network Admin"
	jobtype = /datum/job/network_admin
	// Use standard engineering/science gear
	// TODO: Add custom items when sprites available
```

---

## Phase 7: Research Integration

### 7.1 Research Nodes
**File:** `code/modules/research/techweb/all_nodes.dm`

**Add These Nodes:**
```dm
/datum/techweb_node/ai
	id = "ai"
	display_name = "Artificial Intelligence"
	description = "Basic AI network components"
	design_ids = list(
		"server_cabinet",
		"networking_machine",
		"ai_cpu_basic",
		"ai_ram_1tb"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)

/datum/techweb_node/ai_cpu_2
	id = "ai_cpu_2"
	display_name = "Improved CPU Sockets"
	description = "Allows 2 CPUs per rack"
	prereq_ids = list("ai")
	research_costs = list(TECHWEB_POINT_TYPE_AI = 5000)

/datum/techweb_node/ai_cpu_3, ai_cpu_4 (etc.)
	// Additional CPU slot unlocks

/datum/techweb_node/ai_ram_2, ai_ram_3, ai_ram_4
	// Additional RAM slot unlocks

/datum/techweb_node/ai_advanced_cpu
	// Advanced CPU designs

/datum/techweb_node/ai_bluespace_cpu
	// Bluespace CPU designs
```

### 7.2 Research Designs
**File:** `code/modules/research/designs/ai_designs.dm` (NEW)

**Create Designs For:**
- [ ] Server Cabinet board
- [ ] Networking Machine board
- [ ] Master Subcontroller board
- [ ] AI Data Core board
- [ ] Rack Creator board
- [ ] Basic CPU (1 THz)
- [ ] Advanced CPU (2 THz)
- [ ] Bluespace CPU (3 THz)
- [ ] Experimental CPU
- [ ] RAM modules (1TB, 2TB, 4TB, 8TB)
- [ ] Ethernet cable coil

### 7.3 AI Research Point Generation
**File:** `code/modules/mob/living/silicon/ai/ai_network/ai_network.dm`

**Implementation:**
- [ ] Add `process()` to AI network datum
- [ ] Calculate unused CPU percentage
- [ ] Generate research points from unused CPU
- [ ] Add to science techweb
- [ ] Formula: `AI_RESEARCH_PER_CPU * unused_cpu * total_cpu`
- [ ] Add to subsystem processing

---

## Phase 8: Circuit Boards

### 8.1 Machine Boards
**File:** `code/game/objects/items/circuitboards/machine_circuitboards.dm`

**Add These Boards:**
```dm
/obj/item/circuitboard/machine/ai/data_core
	name = "AI Data Core"
	build_path = /obj/machinery/ai/data_core
	req_components = list(
		/obj/item/stock_parts/capacitor = 2,
		/obj/item/stock_parts/scanning_module = 2,
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/cell = 1
	)

/obj/item/circuitboard/machine/server_cabinet
	name = "Server Cabinet"
	build_path = /obj/machinery/ai/server_cabinet
	req_components = list(
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/stock_parts/capacitor = 2
	)

/obj/item/circuitboard/machine/networking_machine
	name = "Networking Machine"
	build_path = /obj/machinery/ai/networking
	req_components = list(
		/obj/item/stock_parts/matter_bin = 4,
		/obj/item/stock_parts/capacitor = 2,
		/obj/item/stock_parts/scanning_module = 4,
		/obj/item/stack/cable_coil = 5
	)

/obj/item/circuitboard/machine/rack_creator
	name = "Rack Creator"
	build_path = /obj/machinery/rack_creator
	req_components = list(
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stack/cable_coil = 5
	)

/obj/item/circuitboard/machine/subcontroller
	name = "Master Subcontroller"
	build_path = /obj/machinery/ai/master_subcontroller
	req_components = list(
		/obj/item/stock_parts/capacitor = 4,
		/obj/item/stock_parts/scanning_module = 4,
		/obj/item/stack/cable_coil = 5
	)
```

---

## Phase 9: TGUI Interfaces

### 9.1 AI Dashboard Interface
**File:** `tgui/packages/tgui/interfaces/AiDashboard.tsx` (NEW)

**Implementation:**
- [ ] Create React component
- [ ] Display current CPU/RAM allocation
- [ ] Show available vs total resources
- [ ] List available projects with research costs
- [ ] List running projects with resource usage
- [ ] Add start/stop project buttons
- [ ] Show temperature and location info
- [ ] Add resource allocation sliders
- [ ] Display project categories as tabs

### 9.2 AI Network Interface
**File:** `tgui/packages/tgui/interfaces/AiNetworkInterface.tsx` (NEW)

**Implementation:**
- [ ] Create React component for network console
- [ ] Show total network CPU/RAM
- [ ] Display all connected AIs
- [ ] Show resource allocation per AI
- [ ] Allow crew to allocate resources
- [ ] Display local network activities
- [ ] Show Bitcoin balance
- [ ] Add human_lock toggle
- [ ] List all connected networks

### 9.3 AI Server Console Interface
**File:** `tgui/packages/tgui/interfaces/AiServerConsole.tsx` (NEW)

**Implementation:**
- [ ] Create React component
- [ ] Display grid of all server cabinets
- [ ] Show temperature bars (color-coded)
- [ ] Show CPU/RAM totals
- [ ] Show working/offline status
- [ ] Display rack counts
- [ ] Read-only interface

### 9.4 Rack Creator Interface
**File:** `tgui/packages/tgui/interfaces/RackCreator.tsx` (NEW)

**Implementation:**
- [ ] Create React component
- [ ] Show CPU insertion slots (max 4)
- [ ] Show RAM insertion slots (max 4)
- [ ] Display total capacity when finalized
- [ ] Show material requirements
- [ ] Add finalize button
- [ ] Show research requirements for slots

---

## Phase 10: Subsystem Integration

### 10.1 Machines Subsystem
**File:** `code/controllers/subsystem/machines.dm`

**Changes:**
```dm
/datum/controller/subsystem/machines
	var/list/ainets = list() // List of all AI networks

/datum/controller/subsystem/machines/proc/makeainets()
	for(var/datum/ai_network/AN in ainets)
		qdel(AN)
	ainets.Cut()

	for(var/obj/structure/ethernet_cable/EC in GLOB.ethernet_cable_list)
		if(!EC.network)
			var/datum/ai_network/NewAN = new()
			NewAN.add_cable(EC)
			propagate_ai_network(EC, EC.network)

	for(var/obj/machinery/ai/networking/N in GLOB.ai_networking_machines)
		N.roundstart_connect()

/datum/controller/subsystem/machines/stat_entry(msg)
	msg = "M:[machines.len]|PN:[powernets.len]|AN:[ainets.len]"
	return ..()
```

### 10.2 Network Propagation
**File:** `code/modules/mob/living/silicon/ai/ai_network/ai_network.dm`

**Add Global Procs:**
```dm
/proc/propagate_ai_network(obj/O, datum/ai_network/AN)
	// Similar to power network propagation
	// Traces ethernet cables and machines
	// Assigns network to all connected objects

/proc/merge_ai_networks(datum/ai_network/net1, datum/ai_network/net2)
	// Merge two networks when connected
	// Combine resources
	// Update all connected machines
```

---

## Phase 11: Mapping and Spawning

### 11.1 Default AI Satellite Setup
**Map Changes Needed:**
- [ ] Add primary AI data core to AI satellite
- [ ] Add 2-3 server cabinets with default racks
- [ ] Add ethernet cabling throughout AI sat
- [ ] Add networking machine (if multiple networks)
- [ ] Add master subcontroller
- [ ] Add AI server console in AI upload or RD office
- [ ] Add rack creator in Science

### 11.2 Job Spawning
**File:** `code/modules/jobs/job_types/ai.dm`

**Modify `/datum/job/ai/after_spawn()`:**
```dm
/datum/job/ai/after_spawn(mob/living/spawned, mob/M, latejoin)
	. = ..()
	var/mob/living/silicon/ai/AI = spawned

	AI.relocate(TRUE, TRUE) // Find and move to data core

	// Allocate all available resources to spawned AI
	var/total_available_cpu = 1 - AI.ai_network.resources.total_cpu_assigned()
	var/total_available_ram = AI.ai_network.resources.total_ram() - AI.ai_network.resources.total_ram_assigned()

	AI.ai_network.resources.set_cpu(AI, total_available_cpu)
	AI.ai_network.resources.add_ram(AI, total_available_ram)
```

---

## Phase 12: Testing and Balancing

### 12.1 Testing Checklist
- [ ] AI can spawn and connect to network
- [ ] Server cabinets provide correct CPU/RAM
- [ ] Temperature increases with CPU load
- [ ] Overheating causes shutdown
- [ ] Cooling reduces temperature
- [ ] AI can allocate resources in dashboard
- [ ] Projects can be researched and activated
- [ ] Network Admin can access consoles
- [ ] Ethernet cables connect properly
- [ ] Networks merge when connected
- [ ] Networks split when disconnected
- [ ] Networking machines work
- [ ] Master subcontroller reduces delays
- [ ] Research points generate from unused CPU
- [ ] Bitcoin mining works
- [ ] AI can relocate between data cores
- [ ] AI death creates blackbox
- [ ] AI revival works with CPU allocation
- [ ] Rack creator builds racks
- [ ] All TGUI interfaces functional

### 12.2 Balance Values
**To Tune:**
- [ ] Base temperature limits
- [ ] Heat generation per CPU usage
- [ ] Cooling rates
- [ ] Research costs for projects
- [ ] CPU requirements for projects
- [ ] RAM requirements for projects
- [ ] Power usage values
- [ ] Research point generation rates
- [ ] Bitcoin generation rates
- [ ] Default hardware on spawn

---

## Phase 13: Documentation

### 13.1 Code Documentation
- [ ] Add doc comments to all new datums
- [ ] Document proc parameters
- [ ] Add usage examples
- [ ] Document sprite placeholders

### 13.2 Player Documentation
- [ ] Create AI guide for network system
- [ ] Create Network Admin guide
- [ ] Update Science guide for AI research
- [ ] Update Engineering guide for cooling
- [ ] Create troubleshooting section

### 13.3 Admin Documentation
- [ ] Document debug commands
- [ ] Create network visualization tools
- [ ] Add var editing guidelines
- [ ] Document balance values

---

## Phase 14: Future Features (Post-MVP)

### 14.1 Advanced Features
- [ ] CPU overclocking system
- [ ] Custom AI projects
- [ ] Multi-Z level networking
- [ ] Portable server racks
- [ ] AI personality modules (hardware-based)
- [ ] Network hacking antagonist abilities
- [ ] AI upgrade chips
- [ ] Distributed AI consciousness

### 14.2 Sprite Creation Needs
- [ ] Custom ethernet cable sprites
- [ ] AI data core sprites (online/offline/smoking)
- [ ] Server cabinet with rack overlays
- [ ] Server rack item sprite
- [ ] CPU sprites (basic/advanced/bluespace)
- [ ] RAM stick sprites (1/2/4/8 TB)
- [ ] Rack creator machine sprite
- [ ] Networking machine with dish
- [ ] Dead AI blackbox sprite
- [ ] Network Admin outfit
- [ ] Console screens for AI systems

### 14.3 Quality of Life
- [ ] Hotkeys for project management
- [ ] Dashboard notifications
- [ ] Auto-reallocation on network changes
- [ ] Temperature warnings
- [ ] Resource shortage alerts
- [ ] Project completion notifications
- [ ] Network topology viewer

---

## Implementation Priority

### HIGH PRIORITY (Core Functionality)
1. AI Network datum and ethernet cables
2. AI Data Core
3. Server Cabinet and Racks
4. Basic CPU/RAM items
5. AI modifications (relocate, network connection)
6. Shared Resources system
7. Basic TGUI interfaces

### MEDIUM PRIORITY (Enhanced Features)
1. AI Dashboard and Projects
2. Master Subcontroller
3. Network Admin job
4. Rack Creator machine
5. Research integration
6. Networking machines

### LOW PRIORITY (Polish)
1. Bitcoin mining
2. Advanced projects
3. Server overview console
4. Custom sprites (replace placeholders)
5. Advanced debugging tools

---

## Sprite Placeholder Summary

### Using Existing Sprites (Good Fit)
- Master Subcontroller: `telecomms.dmi` "hub" ✓
- Server Cabinet base: `telecomms.dmi` "expansion_bus" ✓
- Computer consoles: Standard computer sprites ✓

### Using Placeholders (Need Replacement)
- Ethernet cables: `cable.dmi` with blue tint (TODO)
- AI Data Core: `research.dmi` "RD-server-on" (TODO)
- Server Rack: `module.dmi` "circuitboard" (TODO)
- CPUs: `module.dmi` "aimodule" (TODO)
- RAM: `module.dmi` "circuitboard" (TODO)
- Rack Creator: `research.dmi` "protolathe" (TODO)
- Dead AI Blackbox: `syndi_gadgets.dmi` "ai" (TODO)
- Networking Machine: `telecomms.dmi` "hub" (Could use custom dish)

### All Placeholders Marked in Code
Every placeholder will have comment above it:
```dm
// PLACEHOLDER: Using [sprite_file] "[state]" until proper sprites available
// TODO: Need dedicated [description] sprite
icon = 'placeholder.dmi'
icon_state = "placeholder"
```

---

## Success Criteria

### Minimum Viable Product (MVP)
- ✓ AI can spawn in data core
- ✓ Server cabinets provide resources
- ✓ AI can allocate CPU/RAM
- ✓ Basic projects work
- ✓ Temperature management works
- ✓ Network Admin job functional
- ✓ Research integration complete
- ✓ All core TGUI interfaces work

### Full Feature Set
- ✓ All Yogstation AI features ported
- ✓ Network propagation works perfectly
- ✓ Multi-AI support functional
- ✓ All projects implemented
- ✓ Networking machines work
- ✓ Bitcoin mining functional
- ✓ AI revival system works
- ✓ Full testing coverage

---

## Notes

- Maintain backward compatibility where possible
- Keep existing AI functionality intact during development
- Test with multiple AIs on network
- Test network merging/splitting edge cases
- Verify performance with multiple networks
- Check for memory leaks in resource datums
- Test AI death/revival thoroughly
- Ensure all numeric values are balanced

**Estimated Implementation Time:** 40-60 hours of development
**Complexity Level:** Expert (8/10)
**Risk Level:** High (major systems change)

---

## Quick Reference: Key Files to Create

```
code/
├── __DEFINES/
│   └── ai.dm (add constants)
├── _globalvars/
│   └── lists/
│       └── ai_networks.dm (NEW)
├── controllers/
│   └── subsystem/
│       └── machines.dm (modify)
├── modules/
│   ├── mob/living/silicon/ai/
│   │   ├── ai.dm (modify)
│   │   ├── life.dm (modify)
│   │   ├── death.dm (modify)
│   │   └── ai_network/ (NEW FOLDER)
│   │       ├── ai_network.dm
│   │       ├── shared_resources.dm
│   │       ├── ethernet_cable.dm
│   │       ├── networking_machines.dm
│   │       ├── master_subcontroller.dm
│   │       └── decentralized/ (NEW FOLDER)
│   │           ├── _ai_machinery.dm
│   │           ├── ai_data_core.dm
│   │           ├── server_cabinet.dm
│   │           ├── systech/ (NEW FOLDER)
│   │           │   ├── cpu.dm
│   │           │   ├── ram.dm
│   │           │   ├── rack.dm
│   │           │   └── rack_creator.dm
│   │           ├── management/ (NEW FOLDER)
│   │           │   ├── ai_dashboard.dm
│   │           │   └── ai_server_overview.dm
│   │           └── projects/ (NEW FOLDER)
│   │               ├── _ai_project.dm
│   │               ├── memory_compressor.dm
│   │               └── coolant_manager.dm
│   ├── jobs/
│   │   └── job_types/
│   │       ├── ai.dm (modify)
│   │       └── network_admin.dm (NEW)
│   └── research/
│       ├── techweb/
│       │   └── all_nodes.dm (modify)
│       └── designs/
│           └── ai_designs.dm (NEW)
└── game/
    └── objects/
        └── items/
            └── circuitboards/
                └── machine_circuitboards.dm (modify)

tgui/packages/tgui/interfaces/
├── AiDashboard.tsx (NEW)
├── AiNetworkInterface.tsx (NEW)
├── AiServerConsole.tsx (NEW)
└── RackCreator.tsx (NEW)
```

---

**REMEMBER:** Mark every placeholder sprite with TODO comments!

**END OF ACTION PLAN**
