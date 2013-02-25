#zfixtures just so loads after other model files
#pro
App.Set.FIXTURES = [
  {id: 1, name: "Ember", cards: [101,102,103]}
  {id: 2, name: "Rails", cards: [201,202]}
  {id: 3, name: "中文", cards: [301,302]}
  {id: 4, name: "ひらがな", cards: [401,402]}
]

App.Card.FIXTURES = [
  {id: 101, front: "route", back: "Em.Route", set: 1}
  {id: 102, front: "controller", back: "Em.Controller", set: 1}
  {id: 103, front: "view", back: "Em.View", set: 1}
  {id: 201, front: "routes", back: "Rails router", set: 2}
  {id: 202, front: "partials", back: "Rails partials", set: 2}
  {id: 301, front: "好", back: "hao3 good", set: 3}
  {id: 302, front: "运", back: "yun4 transport, luck", set: 3}
  {id: 401, front: "あ", back: "a", set: 4}
  {id: 402, front: "い", back: "i", set: 4}
  {id: 403, front: "う", back: "u", set: 4}
  {id: 404, front: "え", back: "e", set: 4}
  {id: 405, front: "お", back: "o", set: 4}



]