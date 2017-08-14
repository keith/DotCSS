var customCSS = "";
safari.extension.dispatchMessage("get_css", { url: document.URL });
safari.self.addEventListener("message", handleMessage, true);

document.addEventListener("DOMContentLoaded", function(event) {
  addStyleToHead(customCSS);
}, true);

function addStyleToHead(css) {
  if (!css) {
    return;
  }

  var style = document.createElement("style");
  style.type = "text/css";
  style.appendChild(document.createTextNode(css))
  document.head.appendChild(style);
}

function handleMessage(event) {
  if (event.name !== "loaded_css") {
    console.log("DotCSS got unexpected event: " + event.name);
    return;
  }

  var css = event.message.css;
  switch (document.readyState) {
    case "complete":
    case "interactive":
      addStyleToHead(css);
      break;
    default:
      customCSS = css;
      break;
  }
}
