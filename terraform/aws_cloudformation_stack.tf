#Create detector model
resource "aws_cloudformation_stack" "backautomat_detector_model_stack" {
  depends_on   = [time_sleep.wait_15_seconds]
  name         = "BackautomatDetectorModelStack"
  iam_role_arn = aws_iam_role.cloud_formation_to_events_role.arn

  template_body = <<STACK
{
    "AWSTemplateFormatVersion": "2010-09-09",
    "Metadata": {
        "AWS::CloudFormation::Designer": {
            "6174c346-ae3e-4e97-b5ae-caa1a4cd4b12": {
                "size": {
                    "width": 60,
                    "height": 60
                },
                "position": {
                    "x": 185,
                    "y": 47
                },
                "z": 0,
                "embeds": [],
                "dependson": [
                    "3c8aff24-b601-4dab-a2dc-ffd8f8d00bfe"
                ]
            },
            "3c8aff24-b601-4dab-a2dc-ffd8f8d00bfe": {
                "size": {
                    "width": 60,
                    "height": 60
                },
                "position": {
                    "x": 160,
                    "y": 150
                },
                "z": 0,
                "embeds": []
            }
        }
    },
    "Resources": {
        "backautomatInput": {
            "Type": "AWS::IoTEvents::Input",
            "Properties": {
                "InputName": "backautomat_input",
                "InputDescription": "Input from the backautomat",
                "InputDefinition": {
                    "Attributes": [
                        {
                            "JsonPath": "state.reported.state"
                        }
                    ]
                }
            },
            "Metadata": {
                "AWS::CloudFormation::Designer": {
                    "id": "3c8aff24-b601-4dab-a2dc-ffd8f8d00bfe"
                }
            }
        },
        "BackautomatDetectorModel": {
            "Type": "AWS::IoTEvents::DetectorModel",
            "Properties": {
                "DetectorModelDefinition": {
                    "states": [
                        {
                            "stateName": "idle",
                            "onInput": {
                                "events": [],
                                "transitionEvents": [
                                    {
                                        "eventName": "goToRunning",
                                        "condition": "$input.Backautomat_Rule.state.reported.state == \"running\"",
                                        "actions": [],
                                        "nextState": "running"
                                    }
                                ]
                            },
                            "onEnter": {
                                "events": []
                            },
                            "onExit": {
                                "events": []
                            }
                        },
                        {
                            "stateName": "running",
                            "onInput": {
                                "events": [],
                                "transitionEvents": [
                                    {
                                        "eventName": "goToFinished",
                                        "condition": "$input.Backautomat_Rule.state.reported.state==\"finished\"",
                                        "actions": [],
                                        "nextState": "finished"
                                    }
                                ]
                            },
                            "onEnter": {
                                "events": []
                            },
                            "onExit": {
                                "events": []
                            }
                        },
                        {
                            "stateName": "finished",
                            "onInput": {
                                "events": [],
                                "transitionEvents": [
                                    {
                                        "eventName": "true",
                                        "condition": "true",
                                        "actions": [],
                                        "nextState": "idle"
                                    }
                                ]
                            },
                            "onEnter": {
                                "events": [
                                    {
                                        "eventName": "Backautomat_send_email",
                                        "condition": "true",
                                        "actions": [
                                            {
                                                "sns": {
                                                    "targetArn": "arn:aws:sns:eu-central-1:274167473874:Backautomat",
                                                    "payload": {
                                                        "contentExpression": "'Backautomat finished, returning to idle'",
                                                        "type": "STRING"
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                ]
                            },
                            "onExit": {
                                "events": []
                            }
                        }
                    ],
                    "initialStateName": "idle"
                },
                "DetectorModelDescription": "Detector Model of the backautomat",
                "DetectorModelName": "Backautomat",
                "EvaluationMethod": "BATCH",
                "RoleArn": "arn:aws:iam::274167473874:role/service-role/IoTEventsRole"
            },
            "Metadata": {
                "AWS::CloudFormation::Designer": {
                    "id": "6174c346-ae3e-4e97-b5ae-caa1a4cd4b12"
                }
            },
            "DependsOn": [
                "backautomatInput"
            ]
        }
    }
}
STACK
}
