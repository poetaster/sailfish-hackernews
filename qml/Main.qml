import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3


Page {
  id: main

  Component.onCompleted: {
    py.call("main.getNewstories",[], function(data) {
      if (data && data.length > 0) {
        for (var i=0; i<data.length; i++) {
          items.append(data[i]);
        }
      }
    })
  }

  Python {
    Component.onCompleted: {
      setHandler('new-story', main.appendStory)
    }

     onReceived: console.log('Unhandled event: ' + data)
  }

  ListModel {
    id: items
  }

  function appendStory(story) {
    console.log(JSON.stringify(story))
    items.append(story)
  }

  SilicaFlickable {
    anchors.fill: parent
    contentHeight: column.height

    Column {
      id: column

      width: main.width
      spacing: Theme.paddingLarge

      PageHeader {
        title: qsTr("Channels")
      }

      SilicaListView {
        id: itemList
        width: parent.width
        height: parent.height
        model: items

        delegate: BackgroundItem {
          // onClicked: { pageStack.push(Qt.resolvedUrl("ChannelPage.qml"), { channelName: model.name, channelID: model.id  }) }
          width: parent.width
          Label {
            text: '#' + model.id
            font.pixelSize: Theme.fontSizeLarge
            height: Theme.itemSizeLarge
            width: parent.width
            color: highlighted ? Theme.highlightColor : Theme.primaryColor
            horizontalAlignment: Text.AlignHCenter
          }
        }
      }
    }
  }
}
