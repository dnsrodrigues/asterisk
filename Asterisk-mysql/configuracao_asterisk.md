## Configuração Asterisk:<br />

- Mover arquivos de configuração para os diretorios corretos:
``` 
cd /tmp/
mv asterisk/*.conf /etc/asterisk/
mv asterisk/*.ini /etc/
rm -rf asterisk.tar
rm -rf asterisk/
``` 
<br/>

- Configurar os arquivos com dados de acesso do BD:
``` 
cd /etc/asterisk/
vim cdr_adaptive_odbc.conf
vim res_odbc.conf

cd /etc/
vim odbc.ini
vim odbcinst.ini
``` 
<br/>

- Criar um arquivo de inicialização do Asterisk "asterisk.service" e colar o arquivo no caminho /etc/systemd/system/ com o conteudo a baixo:
``` 
[Unit]
Description=Asterisk PBX and telephony daemon
After=network.target

[Service]
Type=forking
PIDFile=/var/run/asterisk/asterisk.pid
ExecStart=/usr/sbin/asterisk -C /etc/asterisk/asterisk.conf
ExecReload=/bin/kill -HUP $MAINPID
ExecStop=/bin/kill -TERM $MAINPID

[Install]
WantedBy=multi-user.target
``` 
<br/>

- Recarregue os serviços do systemd para reconhecer as alterações e inicie o serviço do Asterisk:
``` 
systemctl daemon-reload
systemctl start asterisk
``` 
<br/>

- Habilite o serviço para iniciar automaticamente no boot:
``` 
systemctl enable asterisk
``` 
<br/>

- Agora, verifique o status do serviço:
``` 
systemctl status asterisk
``` 
<br/>

- entrar no CLI do Asterisk e ver o log de erros:
``` 
asterisk -rvvv
core reload
``` 
<br/>

- Inserts para criar ramais:
``` 
->insert na tabela ps_aors:
insert into ps_aors (id, contact, default_expiration, mailboxes, max_contacts, minimum_expiration, remove_existing, qualify_frequency, authenticate_qualify, maximum_expiration, outbound_proxy, support_path, qualify_timeout, voicemail_extension, remove_unavailable) values ('1001', null, 7200, null, 1, 60, 'yes', 20, 'no', 7200, null, 'no', null, null, 'yes');
insert into ps_aors (id, contact, default_expiration, mailboxes, max_contacts, minimum_expiration, remove_existing, qualify_frequency, authenticate_qualify, maximum_expiration, outbound_proxy, support_path, qualify_timeout, voicemail_extension, remove_unavailable) values ('1002', null, 7200, null, 1, 60, 'yes', 20, 'no', 7200, null, 'no', null, null, 'yes');
insert into ps_aors (id, contact, default_expiration, mailboxes, max_contacts, minimum_expiration, remove_existing, qualify_frequency, authenticate_qualify, maximum_expiration, outbound_proxy, support_path, qualify_timeout, voicemail_extension, remove_unavailable) values ('1003', null, 7200, null, 1, 60, 'yes', 20, 'no', 7200, null, 'no', null, null, 'yes');

->insert na tabela ps_auths:
insert into ps_auths (id, auth_type, nonce_lifetime, md5_cred, password, realm, username, refresh_token, oauth_clientid, oauth_secret) values ('1001', 'userpass', 32, null, '1234qwerrty564', null, '1001', null, null, null);
insert into ps_auths (id, auth_type, nonce_lifetime, md5_cred, password, realm, username, refresh_token, oauth_clientid, oauth_secret) values ('1002', 'userpass', 32, null, '1234qwerrty564', null, '1002', null, null, null);
insert into ps_auths (id, auth_type, nonce_lifetime, md5_cred, password, realm, username, refresh_token, oauth_clientid, oauth_secret) values ('1003', 'userpass', 32, null, '1234qwerrty564', null, '1003', null, null, null);

->insert na tabela ps_endpoints:
insert into ps_endpoints (id, transport, aors, auth, context, disallow, allow, direct_media, connected_line_method, direct_media_method, direct_media_glare_mitigation, disable_direct_media_on_nat, dtmf_mode, external_media_address, force_rport, ice_support, identify_by, mailboxes, moh_suggest, outbound_auth, outbound_proxy, rewrite_contact, rtp_ipv6, rtp_symmetric, send_diversion, send_pai, send_rpid, timers_min_se, timers, timers_sess_expires, callerid, callerid_privacy, callerid_tag, 100rel, aggregate_mwi, trust_id_inbound, trust_id_outbound, use_ptime, use_avpf, media_encryption, inband_progress, call_group, pickup_group, named_call_group, named_pickup_group, device_state_busy_at, fax_detect, t38_udptl, t38_udptl_ec, t38_udptl_maxdatagram, t38_udptl_nat, t38_udptl_ipv6, tone_zone, language, one_touch_recording, record_on_feature, record_off_feature, rtp_engine, allow_transfer, allow_subscribe, sdp_owner, sdp_session, tos_audio, tos_video, sub_min_expiry, from_domain, from_user, mwi_from_user, dtls_verify, dtls_rekey, dtls_cert_file, dtls_private_key, dtls_cipher, dtls_ca_file, dtls_ca_path, dtls_setup, srtp_tag_32, media_address, redirect_method, set_var, cos_audio, cos_video, message_context, force_avp, media_use_received_transport, accountcode, user_eq_phone, moh_passthrough, media_encryption_optimistic, rpid_immediate, g726_non_standard, rtp_keepalive, rtp_timeout, rtp_timeout_hold, bind_rtp_to_media_address, voicemail_extension, mwi_subscribe_replaces_unsolicited, deny, permit, acl, contact_deny, contact_permit, contact_acl, subscribe_context, fax_detect_timeout, contact_user, preferred_codec_only, asymmetric_rtp_codec, rtcp_mux, allow_overlap, refer_blind_progress, notify_early_inuse_ringing, max_audio_streams, max_video_streams, webrtc, dtls_fingerprint, incoming_mwi_mailbox, bundle, dtls_auto_generate_cert, follow_early_media_fork, accept_multiple_sdp_answers, suppress_q850_reason_headers, trust_connected_line, send_connected_line, ignore_183_without_sdp, codec_prefs_incoming_offer, codec_prefs_outgoing_offer, codec_prefs_incoming_answer, codec_prefs_outgoing_answer, stir_shaken, send_history_info, allow_unauthenticated_options, t38_bind_udptl_to_media_address, geoloc_incoming_call_profile, geoloc_outgoing_call_profile, incoming_call_offer_pref, outgoing_call_offer_pref, stir_shaken_profile, security_negotiation, security_mechanisms, send_aoc, overlap_context) values ('1001', 'utrunk', '1001', '1001', 'contexto', 'all', 'g729,ulaw', 'no', 'invite', 'invite', 'none', 'no', 'rfc4733', null, 'no', 'no', 'username', null, 'default', null, null, 'no', 'no', 'no', 'no', 'no', 'no', 90, 'yes', 1800, '1001', 'allowed_not_screened', null, null, 'no', 'no', 'no', 'no', 'no', 'no', 'no', null, null, null, null, 1, 'no', 'no', 'none', null, 'no', 'no', null, 'pt_BR', 'no', 'apprecord', 'apprecord', null, 'yes', 'yes', null, null, 'ef', null, null, null, null, null, null, null, null, null, null, null, null, null, 'no', null, 'user', null, 5, 4, null, 'no', 'yes', null, 'no', 'no', 'no', 'no', 'no', 30, 60, null, 'yes', null, null, null, null, null, null, null, null, null, null, null, 'no', 'no', 'no', 'no', 'yes', 'no', null, null, 'no', null, null, 'no', 'no', 'no', 'no', 'no', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
insert into ps_endpoints (id, transport, aors, auth, context, disallow, allow, direct_media, connected_line_method, direct_media_method, direct_media_glare_mitigation, disable_direct_media_on_nat, dtmf_mode, external_media_address, force_rport, ice_support, identify_by, mailboxes, moh_suggest, outbound_auth, outbound_proxy, rewrite_contact, rtp_ipv6, rtp_symmetric, send_diversion, send_pai, send_rpid, timers_min_se, timers, timers_sess_expires, callerid, callerid_privacy, callerid_tag, 100rel, aggregate_mwi, trust_id_inbound, trust_id_outbound, use_ptime, use_avpf, media_encryption, inband_progress, call_group, pickup_group, named_call_group, named_pickup_group, device_state_busy_at, fax_detect, t38_udptl, t38_udptl_ec, t38_udptl_maxdatagram, t38_udptl_nat, t38_udptl_ipv6, tone_zone, language, one_touch_recording, record_on_feature, record_off_feature, rtp_engine, allow_transfer, allow_subscribe, sdp_owner, sdp_session, tos_audio, tos_video, sub_min_expiry, from_domain, from_user, mwi_from_user, dtls_verify, dtls_rekey, dtls_cert_file, dtls_private_key, dtls_cipher, dtls_ca_file, dtls_ca_path, dtls_setup, srtp_tag_32, media_address, redirect_method, set_var, cos_audio, cos_video, message_context, force_avp, media_use_received_transport, accountcode, user_eq_phone, moh_passthrough, media_encryption_optimistic, rpid_immediate, g726_non_standard, rtp_keepalive, rtp_timeout, rtp_timeout_hold, bind_rtp_to_media_address, voicemail_extension, mwi_subscribe_replaces_unsolicited, deny, permit, acl, contact_deny, contact_permit, contact_acl, subscribe_context, fax_detect_timeout, contact_user, preferred_codec_only, asymmetric_rtp_codec, rtcp_mux, allow_overlap, refer_blind_progress, notify_early_inuse_ringing, max_audio_streams, max_video_streams, webrtc, dtls_fingerprint, incoming_mwi_mailbox, bundle, dtls_auto_generate_cert, follow_early_media_fork, accept_multiple_sdp_answers, suppress_q850_reason_headers, trust_connected_line, send_connected_line, ignore_183_without_sdp, codec_prefs_incoming_offer, codec_prefs_outgoing_offer, codec_prefs_incoming_answer, codec_prefs_outgoing_answer, stir_shaken, send_history_info, allow_unauthenticated_options, t38_bind_udptl_to_media_address, geoloc_incoming_call_profile, geoloc_outgoing_call_profile, incoming_call_offer_pref, outgoing_call_offer_pref, stir_shaken_profile, security_negotiation, security_mechanisms, send_aoc, overlap_context) values ('1002', 'utrunk', '1002', '1002', 'contexto', 'all', 'g729,ulaw', 'no', 'invite', 'invite', 'none', 'no', 'rfc4733', null, 'no', 'no', 'username', null, 'default', null, null, 'no', 'no', 'no', 'no', 'no', 'no', 90, 'yes', 1800, '1002', 'allowed_not_screened', null, null, 'no', 'no', 'no', 'no', 'no', 'no', 'no', null, null, null, null, 1, 'no', 'no', 'none', null, 'no', 'no', null, 'pt_BR', 'no', 'apprecord', 'apprecord', null, 'yes', 'yes', null, null, 'ef', null, null, null, null, null, null, null, null, null, null, null, null, null, 'no', null, 'user', null, 5, 4, null, 'no', 'yes', null, 'no', 'no', 'no', 'no', 'no', 30, 60, null, 'yes', null, null, null, null, null, null, null, null, null, null, null, 'no', 'no', 'no', 'no', 'yes', 'no', null, null, 'no', null, null, 'no', 'no', 'no', 'no', 'no', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
insert into ps_endpoints (id, transport, aors, auth, context, disallow, allow, direct_media, connected_line_method, direct_media_method, direct_media_glare_mitigation, disable_direct_media_on_nat, dtmf_mode, external_media_address, force_rport, ice_support, identify_by, mailboxes, moh_suggest, outbound_auth, outbound_proxy, rewrite_contact, rtp_ipv6, rtp_symmetric, send_diversion, send_pai, send_rpid, timers_min_se, timers, timers_sess_expires, callerid, callerid_privacy, callerid_tag, 100rel, aggregate_mwi, trust_id_inbound, trust_id_outbound, use_ptime, use_avpf, media_encryption, inband_progress, call_group, pickup_group, named_call_group, named_pickup_group, device_state_busy_at, fax_detect, t38_udptl, t38_udptl_ec, t38_udptl_maxdatagram, t38_udptl_nat, t38_udptl_ipv6, tone_zone, language, one_touch_recording, record_on_feature, record_off_feature, rtp_engine, allow_transfer, allow_subscribe, sdp_owner, sdp_session, tos_audio, tos_video, sub_min_expiry, from_domain, from_user, mwi_from_user, dtls_verify, dtls_rekey, dtls_cert_file, dtls_private_key, dtls_cipher, dtls_ca_file, dtls_ca_path, dtls_setup, srtp_tag_32, media_address, redirect_method, set_var, cos_audio, cos_video, message_context, force_avp, media_use_received_transport, accountcode, user_eq_phone, moh_passthrough, media_encryption_optimistic, rpid_immediate, g726_non_standard, rtp_keepalive, rtp_timeout, rtp_timeout_hold, bind_rtp_to_media_address, voicemail_extension, mwi_subscribe_replaces_unsolicited, deny, permit, acl, contact_deny, contact_permit, contact_acl, subscribe_context, fax_detect_timeout, contact_user, preferred_codec_only, asymmetric_rtp_codec, rtcp_mux, allow_overlap, refer_blind_progress, notify_early_inuse_ringing, max_audio_streams, max_video_streams, webrtc, dtls_fingerprint, incoming_mwi_mailbox, bundle, dtls_auto_generate_cert, follow_early_media_fork, accept_multiple_sdp_answers, suppress_q850_reason_headers, trust_connected_line, send_connected_line, ignore_183_without_sdp, codec_prefs_incoming_offer, codec_prefs_outgoing_offer, codec_prefs_incoming_answer, codec_prefs_outgoing_answer, stir_shaken, send_history_info, allow_unauthenticated_options, t38_bind_udptl_to_media_address, geoloc_incoming_call_profile, geoloc_outgoing_call_profile, incoming_call_offer_pref, outgoing_call_offer_pref, stir_shaken_profile, security_negotiation, security_mechanisms, send_aoc, overlap_context) values ('1003', 'utrunk', '1003', '1003', 'contexto', 'all', 'g729,ulaw', 'no', 'invite', 'invite', 'none', 'no', 'rfc4733', null, 'no', 'no', 'username', null, 'default', null, null, 'no', 'no', 'no', 'no', 'no', 'no', 90, 'yes', 1800, '1003', 'allowed_not_screened', null, null, 'no', 'no', 'no', 'no', 'no', 'no', 'no', null, null, null, null, 1, 'no', 'no', 'none', null, 'no', 'no', null, 'pt_BR', 'no', 'apprecord', 'apprecord', null, 'yes', 'yes', null, null, 'ef', null, null, null, null, null, null, null, null, null, null, null, null, null, 'no', null, 'user', null, 5, 4, null, 'no', 'yes', null, 'no', 'no', 'no', 'no', 'no', 30, 60, null, 'yes', null, null, null, null, null, null, null, null, null, null, null, 'no', 'no', 'no', 'no', 'yes', 'no', null, null, 'no', null, null, 'no', 'no', 'no', 'no', 'no', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
``` 
<br/>

- Configurar arquivo no caminho /etc/asterisk extensions.conf:
<br/>

- Configurar arquivo log full ativar a opção full.log e dar um restart no asterisk:
``` 
vim /etc/asterisk/logger.conf
``` 
<br/>

- Restart no asterisk:
``` 
systemctl restart asterisk.service
``` 
<br/>

- Visualizar log full:
``` 
less /var/log/asterisk/full.log
``` 
<br/>

- Colocar os audios em pt-br, criar diretorio em:
``` 
mkdir /var/lib/asterisk/sounds/pt-br
``` 
<br/>

- Baixar e descompactar os arquivos no diretorio criado:
``` 
cd /var/lib/asterisk/sounds/pt-br
curl -sLO https://www.asterisksounds.org/sites/asterisksounds.org/files/sounds/pt-BR/download/asterisk-sounds-core-pt-BR-3.8.3.zip && unzip -q asterisk-sounds-core-pt-BR-3.8.3.zip
curl -sLO https://www.asterisksounds.org/sites/asterisksounds.org/files/sounds/pt-BR/download/asterisk-sounds-extra-pt-BR-1.11.10.zip && unzip -q asterisk-sounds-extra-pt-BR-1.11.10.zip
``` 
<br/>

- Excluir os arquivos zip baixados após extração:
``` 
cd /var/lib/asterisk/sounds/pt-br
rm asterisk-sounds-core-pt-BR-3.8.3.zip
rm asterisk-sounds-extra-pt-BR-1.11.10.zip
``` 
<br/>

- Alterar a permissão da pasta:
``` 
find /var/lib/asterisk//sounds//pt-br/ -type d -exec chmod 0775 {} \;
``` 
<br/>

- Converter formato de todos os audios para o formato dos codecs necessarios:
``` 
wget https://raw.githubusercontent.com/dnsrodrigues/asterisk/main/Asterisk-mysql/02%20-%20arquivos-config-asterisk/%23arquivos-config/convert.sh ; bash convert.sh
``` 
