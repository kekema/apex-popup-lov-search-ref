# apex-popup-lov-search-ref
Makes the search value in a Popup LOV available for reference in the LOV query, enabling 'Starts With' search.

It submits the entered value to the session cache (transient, so per search request). Having this reference item available, a Match Type of 'Starts With' can be achieved, next to the 'Contains' standard APEX behavior. It serves as a workaround pending FR-3800 (see APEX Ideas App). 

The item can be added to the actual page, to a range of pages under the same item name, or to the global page and will be rendered as hidden. By it's name, it can be referenced in the LOV query. For example: where (upper(FULLNAME) like upper(:P0_LOV_SEARCH)||'%'). Apart from the name, one other configuration is required, namely the Session State Storage. Configure this one as 'Per Request (Memory Only)'. This setting will be important for the correct functioning of the plugin. The search value of the current open Popup LOV will automatically be transient submitted. In case multiple Popup LOV's are used on the page, only one Search Reference Item is required.

The search reference item will only have a value in case of usage from the search bar. The LOV query is also used in other situations (like getting the display value given a return value, or as part of an IG query) - the reference item will be NULL then.

The plugin has been developed under 24.1, but you should be able to use the source in releases before as well. Notice for 24.1, you have the Select One and Select Many item types available (as page items, not in IG yet), which do support 'Starts With' search and do have other improvements as well.

![image](https://github.com/kekema/apex-popup-lov-search-ref/blob/main/ref-item-definition.jpg)

![image](https://github.com/kekema/apex-popup-lov-search-ref/blob/main/lov-search.jpg)
