--------------------------------------------------------------------------------
-- t_item_attr type definition
--------------------------------------------------------------------------------
type t_item_attr is record
( 
    c_name              varchar2(30)
); 

--------------------------------------------------------------------------------
-- init_item_attr Procedure
--------------------------------------------------------------------------------
procedure init_item_attr(
    p_item    in  apex_plugin.t_item,
    item_attr out t_item_attr
)
is
begin
    item_attr.c_name              := apex_plugin.get_input_name_for_item;
end init_item_attr;

--------------------------------------------------------------------------------
-- Render Procedure
-- Renders the hidden input element to capture the LOV search value
-- Adds on-load js as to init the item client-side
--------------------------------------------------------------------------------
procedure render_popup_lov_search_ref (
    p_item   in            apex_plugin.t_item,
    p_plugin in            apex_plugin.t_plugin,
    p_param  in            apex_plugin.t_item_render_param,
    p_result in out nocopy apex_plugin.t_item_render_result
)
is
    item_attr           t_item_attr; 
begin
    apex_plugin_util.debug_page_item(p_plugin => p_plugin, p_page_item => p_item);
    init_item_attr(p_item, item_attr);
    sys.htp.prn(
        apex_string.format(
            '<input type="hidden" %s id="%s" value="%s" />'
            , apex_plugin_util.get_element_attributes(p_item, item_attr.c_name)
            , p_item.name
            , ''
        )
    );

    -- When specifying the library declaratively, it fails to load the minified version. So using the API:
    apex_javascript.add_library(
          p_name      => 'popuplovsearchref',
          p_check_to_add_minified => true,
          p_directory => p_plugin.file_prefix || 'js/',
          p_version   => NULL
    );                

    -- page on load: init popupLovSearchRef
    apex_javascript.add_onload_code(
        p_code => apex_string.format(
            'lib4x.axt.popupLovSearchRef.init("%s", {});'
            , p_item.name     
        )
    );

    p_result.is_navigable := false;
end render_popup_lov_search_ref;

--------------------------------------------------------------------------------
-- Meta Data Procedure
--------------------------------------------------------------------------------
procedure metadata_popup_lov_search_ref (
    p_item   in            apex_plugin.t_item,
    p_plugin in            apex_plugin.t_plugin,
    p_param  in            apex_plugin.t_item_meta_data_param,
    p_result in out nocopy apex_plugin.t_item_meta_data_result )
is
    item_attr   t_item_attr;     
begin                   
    p_result.escape_output := false;
end metadata_popup_lov_search_ref;

