prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>1700466440038362
,p_default_application_id=>149
,p_default_id_offset=>0
,p_default_owner=>'HR'
);
end;
/
 
prompt APPLICATION 149 - Inspector
--
-- Application Export:
--   Application:     149
--   Name:            Inspector
--   Date and Time:   06:26 Monday October 14, 2024
--   Exported By:     DEVELOPER
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 15703430720627279
--   Manifest End
--   Version:         24.1.0
--   Instance ID:     800104173856312
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/lib4x_axt_popuplovsearchref
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(15703430720627279)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'LIB4X.AXT.POPUPLOVSEARCHREF'
,p_display_name=>'LIB4X - Popup LOV Search Reference'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--------------------------------------------------------------------------------',
'-- t_item_attr type definition',
'--------------------------------------------------------------------------------',
'type t_item_attr is record',
'( ',
'    c_name              varchar2(30)',
'); ',
'',
'--------------------------------------------------------------------------------',
'-- init_item_attr Procedure',
'--------------------------------------------------------------------------------',
'procedure init_item_attr(',
'    p_item    in  apex_plugin.t_item,',
'    item_attr out t_item_attr',
')',
'is',
'begin',
'    item_attr.c_name              := apex_plugin.get_input_name_for_item;',
'end init_item_attr;',
'',
'--------------------------------------------------------------------------------',
'-- Render Procedure',
'-- Renders the hidden input element to capture the LOV search value',
'-- Adds on-load js as to init the item client-side',
'--------------------------------------------------------------------------------',
'procedure render_popup_lov_search_ref (',
'    p_item   in            apex_plugin.t_item,',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_param  in            apex_plugin.t_item_render_param,',
'    p_result in out nocopy apex_plugin.t_item_render_result',
')',
'is',
'    item_attr           t_item_attr; ',
'begin',
'    apex_plugin_util.debug_page_item(p_plugin => p_plugin, p_page_item => p_item);',
'    init_item_attr(p_item, item_attr);',
'    sys.htp.prn(',
'        apex_string.format(',
'            ''<input type="hidden" %s id="%s" value="%s" />''',
'            , apex_plugin_util.get_element_attributes(p_item, item_attr.c_name)',
'            , p_item.name',
'            , ''''',
'        )',
'    );',
'',
'    -- When specifying the library declaratively, it fails to load the minified version. So using the API:',
'    apex_javascript.add_library(',
'          p_name      => ''popuplovsearchref'',',
'          p_check_to_add_minified => true,',
'          p_directory => p_plugin.file_prefix || ''js/'',',
'          p_version   => NULL',
'    );                ',
'',
'    -- page on load: init popupLovSearchRef',
'    apex_javascript.add_onload_code(',
'        p_code => apex_string.format(',
'            ''lib4x.axt.popupLovSearchRef.init("%s", {});''',
'            , p_item.name     ',
'        )',
'    );',
'',
'    p_result.is_navigable := false;',
'end render_popup_lov_search_ref;',
'',
'--------------------------------------------------------------------------------',
'-- Meta Data Procedure',
'--------------------------------------------------------------------------------',
'procedure metadata_popup_lov_search_ref (',
'    p_item   in            apex_plugin.t_item,',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_param  in            apex_plugin.t_item_meta_data_param,',
'    p_result in out nocopy apex_plugin.t_item_meta_data_result )',
'is',
'    item_attr   t_item_attr;     ',
'begin                   ',
'    p_result.escape_output := false;',
'end metadata_popup_lov_search_ref;',
'',
'',
''))
,p_api_version=>2
,p_render_function=>'render_popup_lov_search_ref'
,p_meta_data_function=>'metadata_popup_lov_search_ref'
,p_standard_attributes=>'SOURCE'
,p_substitute_attributes=>true
,p_version_scn=>263099688
,p_subscribe_plugin_settings=>true
,p_help_text=>'Makes the entered search value in a Popup LOV available in the session state, so it can be referenced in the LOV query. By this, a Match Type of ''Starts With'' can be achieved, next to the ''Contains'' standard APEX behavior. It serves as a workaround p'
||'ending FR-3800 (see APEX Ideas App). The item can be added to the actual page, to a range of pages under the same item name, or to the global page and will be rendered as hidden. By it''s name, it can be referenced in the LOV query. For example: where'
||' (upper(FULLNAME) like upper(:P0_LOV_SEARCH)||''%''). Apart from the name, one other configuration is required, namely the Session State Storage. Configure this one as ''Per Request (Memory Only)''. The search value of the current open Popup LOV will aut'
||'omatically be submitted. In case multiple Popup LOV''s are used on the page, only one Search Reference Item is required.'
,p_version_identifier=>'1.0.2'
,p_about_url=>'https://github.com/kekema/apex-popup-lov-search-ref'
,p_files_version=>99
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A2A0D0A202A2040617574686F72204B6172656C20456B656D610D0A202A20406C6963656E7365204D4954206C6963656E73650D0A202A20436F70797269676874202863292032303234204B6172656C20456B656D610D0A202A0D0A202A205065726D';
wwv_flow_imp.g_varchar2_table(2) := '697373696F6E20697320686572656279206772616E7465642C2066726565206F66206368617267652C20746F20616E7920706572736F6E206F627461696E696E67206120636F70790D0A202A206F66207468697320736F66747761726520616E64206173';
wwv_flow_imp.g_varchar2_table(3) := '736F63696174656420646F63756D656E746174696F6E2066696C657320287468652027536F66747761726527292C20746F206465616C0D0A202A20696E2074686520536F66747761726520776974686F7574207265737472696374696F6E2C20696E636C';
wwv_flow_imp.g_varchar2_table(4) := '7564696E6720776974686F7574206C696D69746174696F6E20746865207269676874730D0A202A20746F207573652C20636F70792C206D6F646966792C206D657267652C207075626C6973682C20646973747269627574652C207375626C6963656E7365';
wwv_flow_imp.g_varchar2_table(5) := '2C20616E642F6F722073656C6C0D0A202A20636F70696573206F662074686520536F6674776172652C20616E6420746F207065726D697420706572736F6E7320746F2077686F6D2074686520536F6674776172652069730D0A202A206675726E69736865';
wwv_flow_imp.g_varchar2_table(6) := '6420746F20646F20736F2C207375626A65637420746F2074686520666F6C6C6F77696E6720636F6E646974696F6E733A0D0A202A0D0A202A205468652061626F766520636F70797269676874206E6F7469636520616E642074686973207065726D697373';
wwv_flow_imp.g_varchar2_table(7) := '696F6E206E6F74696365207368616C6C20626520696E636C7564656420696E20616C6C0D0A202A20636F70696573206F72207375627374616E7469616C20706F7274696F6E73206F662074686520536F6674776172652E0D0A202A0D0A202A2054484520';
wwv_flow_imp.g_varchar2_table(8) := '534F4654574152452049532050524F564944454420274153204953272C20574954484F55542057415252414E5459204F4620414E59204B494E442C2045585052455353204F520D0A202A20494D504C4945442C20494E434C5544494E4720425554204E4F';
wwv_flow_imp.g_varchar2_table(9) := '54204C494D4954454420544F205448452057415252414E54494553204F46204D45524348414E544142494C4954592C0D0A202A204649544E45535320464F52204120504152544943554C415220505552504F534520414E44204E4F4E494E4652494E4745';
wwv_flow_imp.g_varchar2_table(10) := '4D454E542E20494E204E4F204556454E54205348414C4C205448450D0A202A20415554484F5253204F5220434F5059524947485420484F4C44455253204245204C4941424C4520464F5220414E5920434C41494D2C2044414D41474553204F52204F5448';
wwv_flow_imp.g_varchar2_table(11) := '45520D0A202A204C494142494C4954592C205748455448455220494E20414E20414354494F4E204F4620434F4E54524143542C20544F5254204F52204F54484552574953452C2041524953494E472046524F4D2C0D0A202A204F5554204F46204F522049';
wwv_flow_imp.g_varchar2_table(12) := '4E20434F4E4E454354494F4E20574954482054484520534F465457415245204F522054484520555345204F52204F54484552204445414C494E475320494E205448450D0A202A20534F4654574152452E0D0A202A2F0D0A0D0A77696E646F772E6C696234';
wwv_flow_imp.g_varchar2_table(13) := '78203D2077696E646F772E6C69623478207C7C207B7D3B0D0A77696E646F772E6C696234782E617874203D2077696E646F772E6C696234782E617874207C7C207B7D3B0D0A0D0A2F2A20506F7075704C6F765365617263685265660D0A202A204D616B65';
wwv_flow_imp.g_varchar2_table(14) := '7320746865207365617263682076616C756520696E20616E7920506F707570204C4F5620617661696C61626C6520666F72207265666572656E636520696E207468652073657373696F6E2063616368652E0D0A2A2F0D0A6C696234782E6178742E706F70';
wwv_flow_imp.g_varchar2_table(15) := '75704C6F76536561726368526566203D202866756E6374696F6E28242C207574696C2C20656E7629207B0D0A0D0A202020202F2F20496E697420746865206974656D202D2077696C6C2062652063616C6C6564206F6E2070616765206C6F61640D0A2020';
wwv_flow_imp.g_varchar2_table(16) := '20202F2F205468652076616C75652077696C6C206265206B657074206F6E20746865207365727665722D736964652067656E6572617465642068696464656E20696E70757420656C656D656E742E0D0A202020202F2F20496E2074686520696E69742068';
wwv_flow_imp.g_varchar2_table(17) := '6572652C20746865207370656369666963206974656D20696E7465726661636520697320736574207570206279206170706C79696E6720617065782E6974656D2E6372656174652E0D0A202020202F2F20436C69656E742D736964652C20746865206874';
wwv_flow_imp.g_varchar2_table(18) := '6D6C20666F72207468652073706563696669632074797065206F662063686F696365206974656D2069732067656E6572617465642E0D0A202020206C657420696E6974203D2066756E6374696F6E286974656D49642C206F7074696F6E73290D0A202020';
wwv_flow_imp.g_varchar2_table(19) := '207B0D0A202020202020202066756E6374696F6E206765744469616C6F674F70656E6572286469616C6F674964290D0A20202020202020207B0D0A2020202020202020202020206C6574206F70656E6572203D207B7D3B0D0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(20) := '20696620286469616C6F674964290D0A2020202020202020202020207B0D0A202020202020202020202020202020206C657420696E64657831203D206469616C6F6749642E696E6465784F6628275F27293B0D0A20202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(21) := '6C657420696E64657832203D206469616C6F6749642E696E6465784F6628275F272C206469616C6F6749642E696E6465784F6628275F2729202B2031293B0D0A202020202020202020202020202020206F70656E65722E706167654E72203D2028696E64';
wwv_flow_imp.g_varchar2_table(22) := '65783120213D202D3120262620696E6465783220213D202D3129203F206469616C6F6749642E737562737472696E6728696E64657831202B20312C20696E6465783229203A206E756C6C3B0D0A202020202020202020202020202020206F70656E65722E';
wwv_flow_imp.g_varchar2_table(23) := '6C6F764974656D4964203D2028696E6465783220213D202D3129203F206469616C6F6749642E737562737472696E6728696E64657832202B2031292E7265706C61636528275F646C67272C272729203A206E756C6C3B0D0A202020202020202020202020';
wwv_flow_imp.g_varchar2_table(24) := '7D0D0A20202020202020202020202072657475726E206F70656E65723B0D0A20202020202020207D0D0A20202020202020206C6574206469616C6F674964203D206E756C6C3B0D0A20202020202020202F2F20696D706C656D656E742074686520697465';
wwv_flow_imp.g_varchar2_table(25) := '6D20696E74657266616365207370656369666963730D0A20202020202020202F2F2077652074616B65207468652076616C756520617320706572207468652063757272656E742076697369626C6520706F7075700D0A2020202020202020617065782E69';
wwv_flow_imp.g_varchar2_table(26) := '74656D2E637265617465286974656D49642C207B0D0A20202020202020202020202067657456616C75653A2066756E6374696F6E282029207B0D0A2020202020202020202020202020202072657475726E20617065782E7574696C2E676574546F704170';
wwv_flow_imp.g_varchar2_table(27) := '657828292E6A517565727928272327202B206469616C6F674964202B2027202E612D506F7075704C4F562D73656172636827292E76616C2829207C7C2027273B0D0A2020202020202020202020207D0D0A20202020202020207D293B0D0A202020202020';
wwv_flow_imp.g_varchar2_table(28) := '20202F2F20636F6E66696775726520746865206D6F64656C20626568696E6420746865204C4F5620617320746F207375626D697420746865207265666572656E6365206974656D200D0A20202020202020202F2F20746865206D6F64656C206973206176';
wwv_flow_imp.g_varchar2_table(29) := '61696C61626C652075706F6E202866697273742920706F707570206F70656E206576656E740D0A20202020202020202F2F20746F2074616B6520696E746F206163636F756E743A206C6F7620706F7075702061726520696E7374616E746961746564206F';
wwv_flow_imp.g_varchar2_table(30) := '6E2074686520746F7020706167650D0A20202020202020206C6574206469616C6F67496E697469616C697A6564203D207B7D3B2020202020202020617065782E7574696C2E676574546F704170657828292E67506172656E7450616765436F6E74657874';
wwv_flow_imp.g_varchar2_table(31) := '240D0A20202020202020206C657420746F7041706578203D20617065782E7574696C2E676574546F704170657828293B0D0A2020202020202020746F70417065782E6A517565727928746F70417065782E67506172656E7450616765436F6E7465787424';
wwv_flow_imp.g_varchar2_table(32) := '292E6F6E2827706F7075706F70656E206469616C6F676F70656E272C20275B69645E3D22506F7075704C6F765F225D272C2066756E6374696F6E286A51756572794576656E742C206461746129207B20202020200D0A2020202020202020202020206469';
wwv_flow_imp.g_varchar2_table(33) := '616C6F674964203D206A51756572794576656E743F2E7461726765743F2E69643B20202020202020202020202020200D0A2020202020202020202020206C6574206F70656E6572203D206765744469616C6F674F70656E6572286469616C6F674964293B';
wwv_flow_imp.g_varchar2_table(34) := '0D0A2020202020202020202020206C657420706167654E72203D202428222370466C6F7753746570496422292E76616C28293B200D0A2020202020202020202020202F2F2069662074686520706167652072756E7320696E2061206D6F64616C20646961';
wwv_flow_imp.g_varchar2_table(35) := '6C6F6720616E6420796F7520686176652074686520706C7567696E20636F6E666967757265642028766961207061676520302920696E20626F74680D0A2020202020202020202020202F2F2070616765732C207468656E2074686520706F7075706F7065';
wwv_flow_imp.g_varchar2_table(36) := '6E206576656E7420666F7220746865206C6F7620706F7075702077696C6C20626520636174636865642074776963650D0A2020202020202020202020202F2F2061732062656361757365206F662074686520676574546F704170657820616E6420746865';
wwv_flow_imp.g_varchar2_table(37) := '206C6F7620706F707570206265696E6720696E7374616E746961746564206F6E2074686520746F7020706167650D0A2020202020202020202020202F2F20736F20636865636B696E6720666F722074686520706167656E72206865726520202020202020';
wwv_flow_imp.g_varchar2_table(38) := '20202020200D0A202020202020202020202020696620286469616C6F6749642026262028706167654E72203D3D206F70656E65722E706167654E722920262620216469616C6F67496E697469616C697A65645B6469616C6F6749645D290D0A2020202020';
wwv_flow_imp.g_varchar2_table(39) := '202020202020207B2020202020202020202020202020202020202020202020202020202020200D0A202020202020202020202020202020206C6574206C6F764974656D4964203D206F70656E65722E6C6F764974656D49643B0D0A202020202020202020';
wwv_flow_imp.g_varchar2_table(40) := '202020202020206C6574206D6F64656C4E616D65203D2024282723272B6C6F764974656D4964292E646174612827706F7075704C6F764D6F64656C4E616D6527293B0D0A20202020202020202020202020202020696620286D6F64656C4E616D65290D0A';
wwv_flow_imp.g_varchar2_table(41) := '202020202020202020202020202020207B0D0A20202020202020202020202020202020202020206C6574206D6F64656C203D20617065782E6D6F64656C2E676574286D6F64656C4E616D65293B0D0A202020202020202020202020202020202020202069';
wwv_flow_imp.g_varchar2_table(42) := '6620286D6F64656C290D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020206C6574206974656D73546F5375626D6974203D206D6F64656C2E6765744F7074696F6E28277061676549';
wwv_flow_imp.g_varchar2_table(43) := '74656D73546F5375626D69742729207C7C205B5D3B0D0A2020202020202020202020202020202020202020202020206974656D73546F5375626D6974203D20205B2E2E2E6E657720536574285B2E2E2E6974656D73546F5375626D69742C206974656D49';
wwv_flow_imp.g_varchar2_table(44) := '645D295D3B0D0A2020202020202020202020202020202020202020202020206D6F64656C2E7365744F7074696F6E2827706167654974656D73546F5375626D6974272C206974656D73546F5375626D6974293B0D0A202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(45) := '202020202020202020617065782E6D6F64656C2E72656C65617365286D6F64656C4E616D65293B0D0A20202020202020202020202020202020202020207D0D0A202020202020202020202020202020207D0D0A2020202020202020202020202020202064';
wwv_flow_imp.g_varchar2_table(46) := '69616C6F67496E697469616C697A65645B6469616C6F6749645D203D20747275653B0D0A2020202020202020202020207D2020200D0A20202020202020207D293B0D0A202020207D0D0A0D0A2020202072657475726E7B0D0A2020202020202020696E69';
wwv_flow_imp.g_varchar2_table(47) := '743A20696E69740D0A202020207D0D0A7D2928617065782E6A51756572792C20617065782E7574696C2C20617065782E656E76293B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(15704053991654737)
,p_plugin_id=>wwv_flow_imp.id(15703430720627279)
,p_file_name=>'js/popuplovsearchref.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2F2A2A0A202A2040617574686F72204B6172656C20456B656D610A202A20406C6963656E7365204D4954206C6963656E73650A202A20436F70797269676874202863292032303234204B6172656C20456B656D610A202A0A202A205065726D697373696F';
wwv_flow_imp.g_varchar2_table(2) := '6E20697320686572656279206772616E7465642C2066726565206F66206368617267652C20746F20616E7920706572736F6E206F627461696E696E67206120636F70790A202A206F66207468697320736F66747761726520616E64206173736F63696174';
wwv_flow_imp.g_varchar2_table(3) := '656420646F63756D656E746174696F6E2066696C657320287468652027536F66747761726527292C20746F206465616C0A202A20696E2074686520536F66747761726520776974686F7574207265737472696374696F6E2C20696E636C7564696E672077';
wwv_flow_imp.g_varchar2_table(4) := '6974686F7574206C696D69746174696F6E20746865207269676874730A202A20746F207573652C20636F70792C206D6F646966792C206D657267652C207075626C6973682C20646973747269627574652C207375626C6963656E73652C20616E642F6F72';
wwv_flow_imp.g_varchar2_table(5) := '2073656C6C0A202A20636F70696573206F662074686520536F6674776172652C20616E6420746F207065726D697420706572736F6E7320746F2077686F6D2074686520536F6674776172652069730A202A206675726E697368656420746F20646F20736F';
wwv_flow_imp.g_varchar2_table(6) := '2C207375626A65637420746F2074686520666F6C6C6F77696E6720636F6E646974696F6E733A0A202A0A202A205468652061626F766520636F70797269676874206E6F7469636520616E642074686973207065726D697373696F6E206E6F746963652073';
wwv_flow_imp.g_varchar2_table(7) := '68616C6C20626520696E636C7564656420696E20616C6C0A202A20636F70696573206F72207375627374616E7469616C20706F7274696F6E73206F662074686520536F6674776172652E0A202A0A202A2054484520534F4654574152452049532050524F';
wwv_flow_imp.g_varchar2_table(8) := '564944454420274153204953272C20574954484F55542057415252414E5459204F4620414E59204B494E442C2045585052455353204F520A202A20494D504C4945442C20494E434C5544494E4720425554204E4F54204C494D4954454420544F20544845';
wwv_flow_imp.g_varchar2_table(9) := '2057415252414E54494553204F46204D45524348414E544142494C4954592C0A202A204649544E45535320464F52204120504152544943554C415220505552504F534520414E44204E4F4E494E4652494E47454D454E542E20494E204E4F204556454E54';
wwv_flow_imp.g_varchar2_table(10) := '205348414C4C205448450A202A20415554484F5253204F5220434F5059524947485420484F4C44455253204245204C4941424C4520464F5220414E5920434C41494D2C2044414D41474553204F52204F544845520A202A204C494142494C4954592C2057';
wwv_flow_imp.g_varchar2_table(11) := '48455448455220494E20414E20414354494F4E204F4620434F4E54524143542C20544F5254204F52204F54484552574953452C2041524953494E472046524F4D2C0A202A204F5554204F46204F5220494E20434F4E4E454354494F4E2057495448205448';
wwv_flow_imp.g_varchar2_table(12) := '4520534F465457415245204F522054484520555345204F52204F54484552204445414C494E475320494E205448450A202A20534F4654574152452E0A202A2F0A77696E646F772E6C696234783D77696E646F772E6C696234787C7C7B7D2C77696E646F77';
wwv_flow_imp.g_varchar2_table(13) := '2E6C696234782E6178743D77696E646F772E6C696234782E6178747C7C7B7D2C6C696234782E6178742E706F7075704C6F765365617263685265663D66756E6374696F6E28652C742C70297B72657475726E7B696E69743A66756E6374696F6E28742C70';
wwv_flow_imp.g_varchar2_table(14) := '297B6C657420693D6E756C6C3B617065782E6974656D2E63726561746528742C7B67657456616C75653A66756E6374696F6E28297B72657475726E20617065782E7574696C2E676574546F704170657828292E6A5175657279282223222B692B22202E61';
wwv_flow_imp.g_varchar2_table(15) := '2D506F7075704C4F562D73656172636822292E76616C28297C7C22227D7D293B6C6574206C3D7B7D3B617065782E7574696C2E676574546F704170657828292E67506172656E7450616765436F6E74657874243B6C6574206E3D617065782E7574696C2E';
wwv_flow_imp.g_varchar2_table(16) := '676574546F704170657828293B6E2E6A5175657279286E2E67506172656E7450616765436F6E7465787424292E6F6E2822706F7075706F70656E206469616C6F676F70656E222C275B69645E3D22506F7075704C6F765F225D272C2866756E6374696F6E';
wwv_flow_imp.g_varchar2_table(17) := '28702C6E297B693D703F2E7461726765743F2E69643B6C6574206F3D66756E6374696F6E2865297B6C657420743D7B7D3B69662865297B6C657420703D652E696E6465784F6628225F22292C693D652E696E6465784F6628225F222C652E696E6465784F';
wwv_flow_imp.g_varchar2_table(18) := '6628225F22292B31293B742E706167654E723D2D31213D7026262D31213D693F652E737562737472696E6728702B312C69293A6E756C6C2C742E6C6F764974656D49643D2D31213D693F652E737562737472696E6728692B31292E7265706C6163652822';
wwv_flow_imp.g_varchar2_table(19) := '5F646C67222C2222293A6E756C6C7D72657475726E20747D2869292C613D6528222370466C6F7753746570496422292E76616C28293B696628692626613D3D6F2E706167654E722626216C5B695D297B6C657420703D6F2E6C6F764974656D49642C6E3D';
wwv_flow_imp.g_varchar2_table(20) := '65282223222B70292E646174612822706F7075704C6F764D6F64656C4E616D6522293B6966286E297B6C657420653D617065782E6D6F64656C2E676574286E293B69662865297B6C657420703D652E6765744F7074696F6E2822706167654974656D7354';
wwv_flow_imp.g_varchar2_table(21) := '6F5375626D697422297C7C5B5D3B703D5B2E2E2E6E657720536574285B2E2E2E702C745D295D2C652E7365744F7074696F6E2822706167654974656D73546F5375626D6974222C70292C617065782E6D6F64656C2E72656C65617365286E297D7D6C5B69';
wwv_flow_imp.g_varchar2_table(22) := '5D3D21307D7D29297D7D7D28617065782E6A51756572792C617065782E7574696C2C617065782E656E76293B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(16187276688991128)
,p_plugin_id=>wwv_flow_imp.id(15703430720627279)
,p_file_name=>'js/popuplovsearchref.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done