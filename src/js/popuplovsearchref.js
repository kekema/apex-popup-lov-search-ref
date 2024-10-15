/**
 * @author Karel Ekema
 * @license MIT license
 * Copyright (c) 2024 Karel Ekema
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the 'Software'), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

window.lib4x = window.lib4x || {};
window.lib4x.axt = window.lib4x.axt || {};

/* PopupLovSearchRef
 * Makes the search value in any Popup LOV available for reference in the LOV query.
*/
lib4x.axt.popupLovSearchRef = (function($, util, env) {

    // Init the item - will be called on page load
    // The value will be kept on the server-side generated hidden input element.
    // In the init here, the specific item interface is set up by applying apex.item.create.
    // Client-side, the html for the specific type of choice item is generated.
    let init = function(itemId, options)
    {
        function getDialogOpener(dialogId)
        {
            let opener = {};
            if (dialogId)
            {
                let index1 = dialogId.indexOf('_');
                let index2 = dialogId.indexOf('_', dialogId.indexOf('_') + 1);
                opener.pageNr = (index1 != -1 && index2 != -1) ? dialogId.substring(index1 + 1, index2) : null;
                opener.lovItemId = (index2 != -1) ? dialogId.substring(index2 + 1).replace('_dlg','') : null;
            }
            return opener;
        }
        let dialogId = null;
        // implement the item interface specifics
        // we take the value as per the current visible popup
        apex.item.create(itemId, {
            getValue: function( ) {
                return apex.util.getTopApex().jQuery('#' + dialogId + ' .a-PopupLOV-search').val() || '';
            }
        });
        // configure the model behind the LOV as to submit the reference item 
        // the model is available upon (first) popup open event
        // to take into account: lov popup are instantiated on the top page
        let dialogInitialized = {};        apex.util.getTopApex().gParentPageContext$
        let topApex = apex.util.getTopApex();
        topApex.jQuery(topApex.gParentPageContext$).on('popupopen dialogopen', '[id^="PopupLov_"]', function(jQueryEvent, data) {     
            dialogId = jQueryEvent?.target?.id;              
            let opener = getDialogOpener(dialogId);
            let pageNr = $("#pFlowStepId").val(); 
            // if the page runs in a modal dialog and you have the plugin configured (via page 0) in both
            // pages, then the popupopen event for the lov popup will be catched twice
            // as because of the getTopApex and the lov popup being instantiated on the top page
            // so checking for the pagenr here            
            if (dialogId && (pageNr == opener.pageNr) && !dialogInitialized[dialogId])
            {                              
                let lovItemId = opener.lovItemId;
                let modelName = $('#'+lovItemId).data('popupLovModelName');
                if (modelName)
                {
                    let model = apex.model.get(modelName);
                    if (model)
                    {
                        let itemsToSubmit = model.getOption('pageItemsToSubmit') || [];
                        itemsToSubmit =  [...new Set([...itemsToSubmit, itemId])];
                        model.setOption('pageItemsToSubmit', itemsToSubmit);
                        apex.model.release(modelName);
                    }
                }
                dialogInitialized[dialogId] = true;
            }   
        });
    }

    return{
        init: init
    }
})(apex.jQuery, apex.util, apex.env);
