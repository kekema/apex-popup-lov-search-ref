# apex-popup-lov-search-ref
Makes the search value in a Popup LOV available for reference in the LOV query, enabling 'Starts With' search.

It submits the entered value to the session cache. Having this reference item available, a Match Type of 'Starts With' can be achieved, next to the 'Contains' standard APEX behavior. It serves as a workaround pending FR-3800 (see APEX Ideas App). 

The item can be added to the actual page or to the global page and will be rendered as hidden. By it's name, it can be referenced in the LOV query. For example: where (upper(FULLNAME) like upper(:P0_LOV_SEARCH)||'%'). Apart from the name, no other configuration is required. The search value of the current open Popup LOV will automatically be submitted. In case multiple Popup LOV's are used on the page, only one Search Reference Item is required.

![image](https://github.com/kekema/apex-popup-lov-search-ref/blob/main/ref-item-definition.jpg)

![image](https://github.com/kekema/apex-popup-lov-search-ref/blob/main/lov-search.jpg)
