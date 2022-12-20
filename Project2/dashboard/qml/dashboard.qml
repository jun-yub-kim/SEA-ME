/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0
import Joe 1.0

Window {
    id: root
    visible: true
    width: 1024
    height: 600
    RadialGradient {
            anchors.fill: parent
            gradient: Gradient {
                        GradientStop { position: 0.0005; color: "black" }
                        GradientStop { position: 0.9; color: "white" }
                        //GradientStop { position: 0.0005; color: "orange" }
                        //GradientStop { position: 0.9; color: "purple" }
               }
        }
    color: "#DC143C" //background color
    title: "Joe's Dashboard"

    property date curentTime: new Date()
    property int hour: curentTime.getHours()
    property int minutes: curentTime.getMinutes()
    property int seconds: curentTime.getSeconds()
    property string curtime : "\n" + curentTime.getHours() + ":" + curentTime.getMinutes() + ":" + curentTime.getSeconds()
    property int leftturningSignal: (myLabel.text.split(' ')[0] == 5) ? 1 : 0
    property int rightturningSignal: (myLabel.text.split(' ')[0] == 6) ? 1 : 0


    ValueSource {
        id: valueSource
    }

    ChatMainWindow{
        id: myClass
    }

    Connections{
        target: myClass
        onSomeVarChanged: myLabel.text = myClass.getSomeVar()
        //value: speedLabel = myLabel.text;
    }

    //Connections{
      //  target: myClass
        //onSomeVarChanged: myLabel.text = myClass.getSomeVar()
    //}

    //Text {
      //  width:300
        //height:30
       // color:"white"
       // text:qsTr(
       //            myLabel.text.split(' ')[8] + "  9. " + myLabel.text.split(' ')[9] + "  10. " + myLabel.text.split(' ')[10] + " 11. " + myLabel.text.split(' ')[11] + "  12, " + myLabel.text.split(' ')[12]);
                   //+ "," + myLabel.text.split(' ')[13] + "," + myLabel.text.split(' ')[14] + "," + myLabel.text.split(' ')[15] + "," + myLabel.text.split(' ')[16]);
        //text:curentTime.getSeconds();
       // wrapMode: Text.WordWrap
        //Rectangle{
          //  anchors.fill: parent
          //  border.color: "green"
           // color:"transparent"
       // }
   // }

    Text {
        id: myLabel
        x: 0
        y: 36
        width:30
        height:30
        color: "transparent"
        property string allInfo: myLabel.text

            //curentTime = new Date()
            //print(stringList);
            //print(curentTime.getHours(), ":", curentTime.getMinutes(), ":", curentTime.getSeconds());

        text: myLabel.text.split(' ')[0]
        wrapMode: Text.WordWrap
        //Rectangle{
           // anchors.fill: parent
            //border.color: "red"
            //color:"transparent"
            //anchors.rightMargin: 0
            //anchors.bottomMargin: 1
            //anchors.leftMargin: 0
            //anchors.topMargin: -1
        //}
    }


    // Dashboards are typically in a landscape orientation, so we need to ensure
    // our height is never greater than our width.
    Item {
        id: container
        width: root.width
        height: Math.min(root.width, root.height)

        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 0 //height은 root인 window의 height과 width 중 작은 것을 반환한다.
        anchors.centerIn: parent

        Row { //자동으로 horizontal 하게 만들어주는 구문
            id: gaugeRow
            spacing: container.width * 0.02 //margin,padding 등과 유사한 구문임
            anchors.centerIn: parent //이 밑의 요소들은 부모인 Item의 중앙에 맞춘다

            TurnIndicator {//TurnIndicator라는 qml파일을 참조하겠다는 뜻(좌,우측 깜빡이)
                id: leftIndicator
                anchors.verticalCenter: parent.verticalCenter
                width: height
                height: container.height * 0.1 - gaugeRow.spacing

                direction: Qt.LeftArrow
                on: leftturningSignal ? Qt.LeftArrow : 0//valueSource에 turnSignal값이 나오면, lefArrow 실행
                //color : (myLabel.text.split(' ')[0] == 1) ? "orange" : "gray"
                //valueSource.turnSignal == Qt.LeftArrow
            }


            // Item {
                        //     width: height
                        //     height: container.height * 0.25 - gaugeRow.spacing
                        //     anchors.verticalCenter: parent.verticalCenter
                        //     CircularGauge { //DashboardGaugeStyle에 CircularGauge를 정의해두었음, 그 것을 참조하는 코드
                        //         id: fuelGauge
                        //         value: myLabel.text.split(' ')[0]
                        //         maximumValue: 1
                        //         y: parent.height / 2 - height / 2 - container.height * 0.01
                        //         width: parent.width
                        //         height: parent.height * 0.7
                        //         style: IconGaugeStyle {
                        //             id: fuelGaugeStyle
                        //             icon: "qrc:/images/battery-icon.png"
                        //             minWarningColor: Qt.rgba(0.5, 0, 0, 1)
                        //             tickmarkLabel: Text {
                        //                 color: "white"
                        //                 visible: styleData.value === 0 || styleData.value === 1
                        //                 font.pixelSize: fuelGaugeStyle.toPixels(0.225)
                        //                 text: styleData.value === 0 ? "E" : (styleData.value === 1 ? "F" : "")
                        //             }
                        //         }
                        //     }

                        //     CircularGauge {
                        //         value: valueSource.temperature
                        //         maximumValue: 1
                        //         width: parent.width
                        //         height: parent.height * 0.7
                        //         y: parent.height / 2 + container.height * 0.01

                        //         style: IconGaugeStyle {
                        //             id: tempGaugeStyle

                        //             icon: "qrc:/images/temperature-icon.png"
                        //             maxWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        //             tickmarkLabel: Text {
                        //                 color: "white"
                        //                 visible: styleData.value === 0 || styleData.value === 1
                        //                 font.pixelSize: tempGaugeStyle.toPixels(0.225)
                        //                 text: styleData.value === 0 ? "C" : (styleData.value === 1 ? "H" : "")
                        //             }
                        //         }
                        //     }
                        // }\n\n\n\n\n




            CircularGauge { //rpm gauge
                id: tachometer
                width: height
                height: container.height * 0.25 - gaugeRow.spacing
                value : (parseInt(myLabel.text.split(' ')[12],16)%5);

                //value: myLabel.text.split(' ')[12];
                //value: valueSource.rpm
                maximumValue: 8
                anchors.verticalCenter: parent.verticalCenter
                style: TachometerStyle {}
            }




            Item {
                width : height
                height : container.height / 2
                anchors.verticalCenter: parent.verticalCenter
                CircularGauge {
                    id: speedometer
                    value: parseInt(myLabel.text.split(' ')[12],16); // hexadecimal to decimal
                    //value : myLabel.text.split(' ')[12];
                    anchors.verticalCenter: parent.verticalCenter
                    maximumValue: 280
                    Behavior on value{
                                    NumberAnimation{
                                        duration: 1000
                                        easing: Easing.InOutSine
                                    }
                                }
                    // We set the width to the height, because the height will always be
                    // the more limited factor. Also, all circular controls letterbox
                    // their contents to ensure that they remain circular. However, we
                    // don't want to extra space on the left and right of our gauges,
                    // because they're laid out horizontally, and that would create
                    // large horizontal gaps between gauges on wide screens.
                    width: height
                    height: container.height * 0.5

                    style: DashboardGaugeStyle {}
                }


                Rectangle {
                    id: decoration_bar;
                    y: parent.height * 1.06
                    x : parent.width / 15
                    width: parent.width * 0.9
                    height: parent.width / 100
                    RadialGradient { // PRND gradient bar color change
                            anchors.fill: parent
                            gradient: Gradient {
                                        GradientStop { position: 0.0; color: "white" }
                                        GradientStop { position: 0.3; color: "gray" }
                               }
                        }
                }

                Rectangle {
                    id: prnd;
                    y: parent.height * 1.15
                    x : parent.width / 12
                    width: parent.width
                    height: 50
                    color: "transparent"
                    //color : "green"


                    Text {
                        id: letterP
                        //color : (myLabel.text == "2") ? "orange" : "gray"
                        color : (myLabel.text.split(' ')[0] == 1) ? "orange" : "gray"
                        x : 0
                        width: parent.width / 4
                        height: parent.height
                        text: qsTr("P")
                        font.pixelSize: parent.height
                        minimumPointSize: 16
                        minimumPixelSize: 16
                        transformOrigin: Item.Center
                    }

                    Text {
                        id: letterR
                        //color : "gray"
                        //color : "white"
                        color : (myLabel.text.split(' ')[0] == 2) ? "orange" : "gray"
                        x : parent.width / 4
                        width: parent.width / 4
                        height: parent.height
                        text: qsTr("R")
                        font.pixelSize: parent.height
                        minimumPointSize: 16
                        minimumPixelSize: 16
                        transformOrigin: Item.Center
                    }
                    Text {
                        id: letterN
                        //color : "gray"
                        //color : "white"
                        color : (myLabel.text.split(' ')[0] == 3) ? "orange" : "gray"
                        x : parent.width / 2
                        width: parent.width / 4
                        height: parent.height
                        text: qsTr("N")
                        font.pixelSize: parent.height
                        minimumPointSize: 16
                        minimumPixelSize: 16
                        transformOrigin: Item.Center
                    }
                    Text {
                        id: letterD
                        //color : "gray"
                        //color : "white"
                        color : "orange"
                        //color : (myLabel.text.split(' ')[0] == 4) ? "orange" : "gray"
                        x : 3 * parent.width / 4
                        width: parent.width / 4
                        height: parent.height
                        text: qsTr("D")
                        font.pixelSize: parent.height
                        minimumPointSize: 16
                        minimumPixelSize: 16
                        transformOrigin: Item.Center
                    }
                }
            }






            Text {
                id: informationdesk
                y : parent.height * 0.18
                width:parent.width * 0.28
                height:parent.height * 0.7
                //width:230
                //height:200
                color:"white"
                property string allInfo: myLabel.text
                wrapMode: Text.WordWrap

                Rectangle{
                    anchors.fill: parent
                    border.color: "white"
                    radius : 5
                    color:"transparent"
                    anchors.rightMargin: 10
                    anchors.bottomMargin: 1
                    anchors.leftMargin: 0
                    anchors.topMargin: -1
                }

                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    text : curtime
                    color:"orange"
                }

                Text{
                    text:"\n\n\n\n  Battery : 76%";
                    color:"orange"
                }
                Text{
                    anchors.bottomMargin: parent.height * 0.7
                    text:qsTr("\n\n\n\n\n  Temperature : " + (parseInt(myLabel.text.split(' ')[11],16)) + "°C");
                    //text:qsTr("\n\n\n\n\n  Temperature : " + curentTime.getMinutes() + "°C");
                    color:"orange"
                }
                Text{
                    anchors.bottomMargin: parent.height * 70
                    text:qsTr("\n\n\n\n\n\n  Humadity : " + (parseInt(myLabel.text.split(' ')[10],16)) + "%");
                    //text:"\n\n\n\n\n\n  Humadity : 11%";
                    color:"orange"
                }

            }
//---------------------------------------------------------change below------------------------------------------------
                //CircularGauge {
                  //  id: tachometer2
                    //width: height
                   // height: container.height * 0.25 - gaugeRow.spacing
                    //value: myLabel.text;
                    //maximumValue: 8
                    //anchors.verticalCenter: parent.verticalCenter

         //           style: TachometerStyle {}
           //     }



            TurnIndicator {
                id: rightIndicator
                anchors.verticalCenter: parent.verticalCenter
                width: height
                height: container.height * 0.1 - gaugeRow.spacing

                direction: Qt.RightArrow
                //on: myLabel.text.split(' ')[0] == 1;
                //on : myLabel.text.split(' ')[0] == Qt.RightArrow
                on: rightturningSignal ? Qt.LeftArrow : 0
            }

        }
    }
    Timer{
        id:timer
        repeat:true
        interval:100
        running:true
        onTriggered:{
            curentTime = new Date()
            // mylabel.text.split(' ')[0] * 100 + mylabel.text.split(' ')[1]
            // print(mylabel.text.split(' ')[0] + mylabel.text.split(' ')[1]);
            // print(curentTime.getHours(), ":", curentTime.getMinutes(), ":", curentTime.getSeconds());
        }
    }

}
