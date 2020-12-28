extends MarginContainer

func _ready():
	Global.connect("coin_taked", self, "_coin_Counter_edit")
	$"../../Person".connect("health_updated", self, "_on_Person_health_updated")
	$"../../Person".connect("max_health_updated", self, "_on_Person_max_health_updated")
	

func _on_Person_health_updated(health):
	$HBoxContainer/Bars/LifeBar/HealthBar/HealhOver.value = health
	$HBoxContainer/Bars/LifeBar/HealthBar/UpdateTween.interpolate_property(\
		$HBoxContainer/Bars/LifeBar/HealthBar/HealthUnder, "value", \
		$HBoxContainer/Bars/LifeBar/HealthBar/HealthUnder.value, health, 0.4, \
		Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	$HBoxContainer/Bars/LifeBar/HealthBar/UpdateTween.start()


func _on_Person_max_health_updated(max_health):
	$HBoxContainer/Bars/LifeBar/HealthBar/HealhOver.max_value = max_health
	$HBoxContainer/Bars/EnergyBar/HealthBar/HealthUnder.max_value = max_health

func _coin_Counter_edit(coin_count):
	$HBoxContainer/Counters/CoinCounter/Background/Number.text = str(coin_count)
	if coin_count >= 100:
		$HBoxContainer/Counters/CoinCounter/Background.rect_size = Vector2(130, 40)
