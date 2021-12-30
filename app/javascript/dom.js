const elRx = /(<[^>]+>)/

function $(el) {
	if(el.match(elRx)) {
		return htmlToElement(el)
	}

	return document.querySelector(el)
}

function $append(parent, el) {
	if(!parent.nodeType) return;
	if(el.nodeType) {
		parent.appendChild(el)
		return el
	}

	parent.insertAdjacentHTML('beforeend', el.trim())
	return parent.children[parent.children.length - 1]
}


function htmlToElement(html) {
    var template = document.createElement('template');
    html = html.trim();
    template.innerHTML = html;
    return template.content.firstChild;
}