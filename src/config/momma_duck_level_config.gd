tool
class_name MommaDuckLevelConfig
extends SurfacerLevelConfig


const ARE_LEVELS_SCENE_BASED := true

const LEVELS_PATH_PREFIX := "res://src/levels/"

var level_manifest := {
    "1000": {
        name = "Test",
        version = "0.0.1",
        is_test_level = true,
        sort_priority = -100,
        unlock_conditions = "unlocked",
        scene_path = LEVELS_PATH_PREFIX + "level0.tscn",
        platform_graph_player_names = [
            "momma",
            "duckling",
            "run_away_duckling",
        ],
        intro_choreography = [
            {
                is_user_interaction_enabled = false,
                zoom = 0.5,
            },
            {
                duration = 0.3,
            },
            {
                destination = SurfacerLevelConfig \
                        .INTRO_CHOREOGRAPHY_DESTINATION_GROUP_NAME,
            },
            {
                duration = 0.4,
                zoom = INF,
            },
            {
                is_user_interaction_enabled = true,
            },
        ],
    },
    "1": {
        name = "Search",
        version = "0.0.1",
        is_test_level = false,
        sort_priority = 10,
        unlock_conditions = "unlocked",
        scene_path = LEVELS_PATH_PREFIX + "level1.tscn",
        platform_graph_player_names = [
            "momma",
            "duckling",
            "run_away_duckling",
        ],
        intro_choreography = [
            {
                is_user_interaction_enabled = false,
                zoom = 0.5,
            },
            {
                duration = 0.3,
            },
            {
                destination = SurfacerLevelConfig \
                        .INTRO_CHOREOGRAPHY_DESTINATION_GROUP_NAME,
            },
            {
                duration = 0.4,
                zoom = 1.0,
            },
            {
                is_user_interaction_enabled = true,
            },
        ],
    },
    "2": {
        name = "Tend",
        version = "0.0.1",
        is_test_level = false,
        sort_priority = 20,
        unlock_conditions = "finish_previous_level",
        scene_path = LEVELS_PATH_PREFIX + "level2.tscn",
        platform_graph_player_names = [
            "momma",
            "duckling",
            "run_away_duckling",
        ],
    },
    "3": {
        name = "Avoid",
        version = "0.0.1",
        is_test_level = false,
        sort_priority = 30,
        unlock_conditions = "finish_previous_level",
        scene_path = LEVELS_PATH_PREFIX + "level3.tscn",
        platform_graph_player_names = [
            "momma",
            "duckling",
            "run_away_duckling",
            "porcupine",
        ],
    },
    "4": {
        name = "Flee",
        version = "0.0.1",
        is_test_level = false,
        sort_priority = 40,
        unlock_conditions = "finish_previous_level",
        scene_path = LEVELS_PATH_PREFIX + "level4.tscn",
        platform_graph_player_names = [
            "momma",
            "duckling",
            "run_away_duckling",
            "fox",
        ],
    },
    "5": {
        name = "Waddle",
        version = "0.0.1",
        is_test_level = false,
        sort_priority = 50,
        unlock_conditions = "finish_previous_level",
        scene_path = LEVELS_PATH_PREFIX + "level5.tscn",
        platform_graph_player_names = [
            "momma",
            "duckling",
            "run_away_duckling",
            "porcupine",
            "fox",
        ],
    },
}


func _init().(
        ARE_LEVELS_SCENE_BASED,
        level_manifest) -> void:
    pass
