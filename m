Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D24A1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 13:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbeBFNJj (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 08:09:39 -0500
Received: from rhcavuit01.kulnet.kuleuven.be ([134.58.240.129]:49179 "EHLO
        rhcavuit01.kulnet.kuleuven.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752403AbeBFNJh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Feb 2018 08:09:37 -0500
X-KULeuven-Envelope-From: filip.jorissen@kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 977F1120331.A3851
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-1.cc.kuleuven.be (icts-p-smtps-1e.kulnet.kuleuven.be [134.58.240.33])
        by rhcavuit01.kulnet.kuleuven.be (Postfix) with ESMTP id 977F1120331
        for <git@vger.kernel.org>; Tue,  6 Feb 2018 14:09:23 +0100 (CET)
Received: from ICTS-S-EXMBX20.luna.kuleuven.be (icts-s-exmbx20.luna.kuleuven.be [10.112.11.55])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by icts-p-smtps-1.cc.kuleuven.be (Postfix) with ESMTPS id 93CE1403B;
        Tue,  6 Feb 2018 14:09:23 +0100 (CET)
Received: from ICTS-S-EXMBX21.luna.kuleuven.be (10.112.11.56) by
 ICTS-S-EXMBX20.luna.kuleuven.be (10.112.11.55) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 6 Feb 2018 14:09:23 +0100
Received: from ICTS-S-EXMBX21.luna.kuleuven.be ([fe80::40ed:b1c6:4ef8:3c88])
 by ICTS-S-EXMBX21.luna.kuleuven.be ([fe80::40ed:b1c6:4ef8:3c88%23]) with mapi
 id 15.00.1320.000; Tue, 6 Feb 2018 14:09:23 +0100
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Filip Jorissen <filip.jorissen@kuleuven.be>
To:     =?utf-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
CC:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cloned repository has file changes -> bug?
Thread-Topic: Cloned repository has file changes -> bug?
Thread-Index: AQHTl6YICpRIXjWJ3kyLd7lXxhw5laOIErcAgADIhYCADnwVAA==
Date:   Tue, 6 Feb 2018 13:09:23 +0000
Message-ID: <CD3563ED-5E0D-4238-A664-4F2335598FE2@kuleuven.be>
References: <BCFDB3A3-B515-4932-AC67-F720AEB4B0BE@kuleuven.be>
 <87607nvzrd.fsf@evledraar.gmail.com> <20180128075731.GA17412@tor.lan>
In-Reply-To: <20180128075731.GA17412@tor.lan>
Accept-Language: nl-NL, nl-BE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.5.20)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.112.50.1]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B41294C915BF9408442AC90B3BB0B22@luna.kuleuven.be>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgYWxsLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcXVpY2sgcmVzcG9uc2VzLiBJIHdhcyBhYmxl
IHRvIHJlc29sdmUgdGhlIHByb2JsZW0gYmFzZWQgb24geW91ciBmZWVkYmFjayENCg0KQmFzZWQg
b24gdGhpcyBleHBlcmllbmNlLCBJIHdvdWxkIGxpa2UgdG8gc3VnZ2VzdCB0aGF0IGdpdCBpcyBz
b21laG93IGFibGUgdG8gYXZvaWQgdGhlc2UgcHJvYmxlbXMgYnkgZG9pbmcgYSBjYXNlIGNoZWNr
IGl0c2VsZiByYXRoZXIgdGhhbiByZWx5aW5nIG9uIHRoZSBob3N0IE9TIGZvciB0aGlzPyANCg0K
S2luZCByZWdhcmRzIQ0KDQpGaWxpcA0KDQoNCg0KPiBPcCAyOCBqYW4uIDIwMTgsIG9tIDA4OjU3
IGhlZWZ0IFRvcnN0ZW4gQsO2Z2Vyc2hhdXNlbiA8dGJvZWdpQHdlYi5kZT4gaGV0IHZvbGdlbmRl
IGdlc2NocmV2ZW46DQo+IA0KPiBPbiBTYXQsIEphbiAyNywgMjAxOCBhdCAwODo1OTo1MFBNICsw
MTAwLCDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbiB3cm90ZToNCj4+IA0KPj4gT24gU2F0LCBK
YW4gMjcgMjAxOCwgRmlsaXAgSm9yaXNzZW4gam90dGVkOg0KPj4gDQo+Pj4gSSB0aGluayBvdXIg
Z2l0IHJlcG9zaXRvcnkgaXMgYnVnZ2VkLiBUaGUgcmVhc29uIHdoeSBJIHNheSB0aGlzIGlzIHRo
ZQ0KPj4+IGZvbGxvd2luZy4gV2hlbiBjbG9uaW5nIHRoZSByZXBvc2l0b3J5LCB0aGUgbmV3bHkg
Y2xvbmVkIHJlcG9zaXRvcnkNCj4+PiBpbW1lZGlhdGVseSBoYXMgZmlsZSBjaGFuZ2VzWy4uLl0u
DQo+PiANCj4+IElmIHlvdSBydW4gdGhpczoNCj4+IA0KPj4gICAgZ2l0IGxzLWZpbGVzIHwgdHIg
J1s6dXBwZXI6XScgJ1s6bG93ZXI6XScgfCBzb3J0IHwgdW5pcSAtRCB8IGdyZXAgJ14nDQo+PiAN
Cj4+IFlvdSdsbCBzZWUgdGhhdCB0aGUgcmVhc29uIGlzIHRoYXQgeW91IGhhdmUgZmlsZXMgdGhh
dCBkaWZmZXIgb25seSBpbg0KPj4gY2FzZS4NCj4+IA0KPj4gWW91IGFyZSB1c2luZyBhIE1hYywg
YW5kIE1hY3MgYnkgZGVmYXVsdCB0aGluayB0aGF0IGZpbGVzIHRoYXQgYXJlDQo+PiBkaWZmZXJl
bnQgYmluYXJ5IHN0cmluZ3MgYXJlIHRoZSBzYW1lIGZpbGUsIHNpbmNlIHRoZXkgZG9uJ3QgY29u
c2lkZXINCj4+IGNhc2UgdG8gYmUgcmVsZXZhbnQuIFRoZSBmaWxlIEZPTywgZm9vIGFuZCBGb08g
YW5kIGZPbyBhcmUgYWxsIHRoZSBzYW1lDQo+PiBmaWxlIGFzIGZhciBhcyB5b3VyIE1hYyBpcyBj
b25jZXJuZWQsIGJ1dCB3b3VsZCBiZSA0IGRpZmZlcmVudCBmaWxlcyBvbg0KPj4gTGludXguDQo+
PiANCj4+PiBIb3cgY2FuIEkgZml4IHRoZSByZXBvc2l0b3J5Pw0KPj4gDQo+PiBZb3UgY291bGQg
Y2hlY2sgaXQgb3V0IG9uIGEgT1MgdGhhdCBjb25zaWRlcnMgZmlsZXMgdGhhdCBkaWZmZXIgaW4g
Y2FzZQ0KPj4gdG8gYmUgZGlmZmVyZW50IGZpbGVzLCBlLmcuIG9uIExpbnV4LCBtb3ZlIHRoZW0g
YXJvdW5kLCBwdXNoIGl0LCBhbmQgbmV3DQo+PiBjbG9uZXMgc2hvdWxkIHdvcmsgb24geW91ciBN
YWMuDQo+PiANCj4+IEFsdGVybmF0aXZlbHkgSSBoZWFyIHRoYXQgeW91IGNhbiBjcmVhdGUgYSBs
b29wYmFjayBjYXNlLXNlbnNpdGl2ZSBGUw0KPj4gaW1hZ2Ugb24gTWFjcy4NCj4gDQo+IFlvdSBj
YW4gZXZlbiBmaXggdGhlIHJlcG8gbG9jYWxseS4NCj4gVGhlcmUgYXJlIDIgZmlsZXMgd2l0aCB1
cHBlcmNhc2UvbG93ZXJjYXNlIGNvbGxpc2lvbnMuDQo+IEkgc2hvdyB5b3UgaG93IHRvIGZpeCBv
bmUgb2ZmIHRoZXNlLCB0aGUgb3RoZXIgb25lIGdvZXMgc2ltaWxhci4NCj4gQWZ0ZXIgdGhhdCwg
ZG8gYSBjb21taXQgYW5kIGEgcHVzaCBhbmQgcHVsbCByZXF1ZXN0Lg0KPiANCj4gDQo+IA0KPiBD
aGFuZ2VzIG5vdCBzdGFnZWQgZm9yIGNvbW1pdDoNCj4gICh1c2UgImdpdCBhZGQgPGZpbGU+Li4u
IiB0byB1cGRhdGUgd2hhdCB3aWxsIGJlIGNvbW1pdHRlZCkNCj4gICh1c2UgImdpdCBjaGVja291
dCAtLSA8ZmlsZT4uLi4iIHRvIGRpc2NhcmQgY2hhbmdlcyBpbiB3b3JraW5nIGRpcmVjdG9yeSkN
Cj4gDQo+ICAgICAgICBtb2RpZmllZDogICBJREVBUy9SZXNvdXJjZXMvUmVmZXJlbmNlUmVzdWx0
cy9EeW1vbGEvSURFQVNfRmx1aWRfSGVhdEV4Y2hhbmdlcnNfR3JvdW5kSGVhdEV4Y2hhbmdlcnNf
Qm9yZWZpZWxkX0V4YW1wbGVzX011bHRpcGxlQm9yZWhvbGVzV2l0aEhlYXRQdW1wLnR4dA0KPiAg
ICAgICAgbW9kaWZpZWQ6ICAgSURFQVMvUmVzb3VyY2VzL1JlZmVyZW5jZVJlc3VsdHMvRHltb2xh
L0lERUFTX1V0aWxpdGllc19Qc3ljaHJvbWV0cmljc19GdW5jdGlvbnNfRXhhbXBsZXNfc2F0dXJh
dGlvblByZXNzdXJlLnR4dA0KPiANCj4gbm8gY2hhbmdlcyBhZGRlZCB0byBjb21taXQgKHVzZSAi
Z2l0IGFkZCIgYW5kL29yICJnaXQgY29tbWl0IC1hIikNCj4gdXNlckBtYWM6L3RtcC9JREVBUz4g
Z2l0IGxzLWZpbGVzIC1zIHwgZ3JlcCAtaSBJREVBUy9SZXNvdXJjZXMvUmVmZXJlbmNlUmVzdWx0
cy9EeW1vbGEvSURFQVNfRmx1aWRfSGVhdEV4Y2hhbmdlcnNfR3JvdW5kSGVhdEV4Y2hhbmdlcnNf
Qm9yZWZpZWxkX0V4YW1wbGVzX011bHRpcGxlQm9yZWhvbGVzV2l0aEhlYXRQdW1wLnR4dA0KPiAx
MDA2NDQgZjU2Y2ZjZjE0YWE0YjUzZGZjNWVjZmI0ODgzNjZmNzIxYzk0YzhlMiAwICAgICAgIElE
RUFTL1Jlc291cmNlcy9SZWZlcmVuY2VSZXN1bHRzL0R5bW9sYS9JREVBU19GbHVpZF9IZWF0RXhj
aGFuZ2Vyc19Hcm91bmRIZWF0RXhjaGFuZ2Vyc19Cb3JlZmllbGRfRXhhbXBsZXNfTXVsdGlwbGVC
b3JlaG9sZXNXaXRoSGVhdFB1bXAudHh0DQo+IDEwMDY0NCBlMzQ1ZTEzNzIxMTFkMDM0YjRjNWEx
Yzc1ZWI3OTEzNDBiOTNmNTVlIDAgICAgICAgSURFQVMvUmVzb3VyY2VzL1JlZmVyZW5jZVJlc3Vs
dHMvRHltb2xhL2lkZWFzX0ZsdWlkX0hlYXRFeGNoYW5nZXJzX0dyb3VuZEhlYXRFeGNoYW5nZXJz
X0JvcmVmaWVsZF9FeGFtcGxlc19NdWx0aXBsZUJvcmVob2xlc1dpdGhIZWF0UHVtcC50eHQNCj4g
dXNlckBtYWM6L3RtcC9JREVBUz4gZ2l0IG12IElERUFTL1Jlc291cmNlcy9SZWZlcmVuY2VSZXN1
bHRzL0R5bW9sYS9pZGVhc19GbHVpZF9IZWF0RXhjaGFuZ2Vyc19Hcm91bmRIZWF0RXhjaGFuZ2Vy
c19Cb3JlZmllbGRfRXhhbXBsZXNfTXVsdGlwbGVCb3JlaG9sZXNXaXRoSGVhdFB1bXAudHh0IElE
RUFTL1Jlc291cmNlcy9SZWZlcmVuY2VSZXN1bHRzL0R5bW9sYS9pZGVhc19GbHVpZF9IZWF0RXhj
aGFuZ2Vyc19Hcm91bmRIZWF0RXhjaGFuZ2Vyc19Cb3JlZmllbGRfRXhhbXBsZXNfTXVsdGlwbGVC
b3JlaG9sZXNXaXRoSGVhdFB1bXAyLnR4dA0KPiB1c2VyQG1hYzovdG1wL0lERUFTPiBnaXQgY2hl
Y2tvdXQgIElERUFTL1Jlc291cmNlcy9SZWZlcmVuY2VSZXN1bHRzL0R5bW9sYS9pZGVhc19GbHVp
ZF9IZWF0RXhjaGFuZ2Vyc19Hcm91bmRIZWF0RXhjaGFuZ2Vyc19Cb3JlZmllbGRfRXhhbXBsZXNf
TXVsdGlwbGVCb3JlaG9sZXNXaXRoSGVhdFB1bXAyLnR4dA0KPiB1c2VyQG1hYzovdG1wL0lERUFT
PiBnaXQgY2hlY2tvdXQgSURFQVMvUmVzb3VyY2VzL1JlZmVyZW5jZVJlc3VsdHMvRHltb2xhL0lE
RUFTX0ZsdWlkX0hlYXRFeGNoYW5nZXJzX0dyb3VuZEhlYXRFeGNoYW5nZXJzX0JvcmVmaWVsZF9F
eGFtcGxlc19NdWx0aXBsZUJvcmVob2xlc1dpdGhIZWF0UHVtcC50eHQNCj4gdXNlckBtYWM6L3Rt
cC9JREVBUz4gZ2l0IHN0YXR1cw0KPiBPbiBicmFuY2ggbWFzdGVyDQo+IFlvdXIgYnJhbmNoIGlz
IHVwIHRvIGRhdGUgd2l0aCAnb3JpZ2luL21hc3RlcicuDQo+IA0KPiBDaGFuZ2VzIHRvIGJlIGNv
bW1pdHRlZDoNCj4gICh1c2UgImdpdCByZXNldCBIRUFEIDxmaWxlPi4uLiIgdG8gdW5zdGFnZSkN
Cj4gDQo+ICAgICAgICByZW5hbWVkOiAgICBJREVBUy9SZXNvdXJjZXMvUmVmZXJlbmNlUmVzdWx0
cy9EeW1vbGEvaWRlYXNfRmx1aWRfSGVhdEV4Y2hhbmdlcnNfR3JvdW5kSGVhdEV4Y2hhbmdlcnNf
Qm9yZWZpZWxkX0V4YW1wbGVzX011bHRpcGxlQm9yZWhvbGVzV2l0aEhlYXRQdW1wLnR4dCAtPiBJ
REVBUy9SZXNvdXJjZXMvUmVmZXJlbmNlUmVzdWx0cy9EeW1vbGEvaWRlYXNfRmx1aWRfSGVhdEV4
Y2hhbmdlcnNfR3JvdW5kSGVhdEV4Y2hhbmdlcnNfQm9yZWZpZWxkX0V4YW1wbGVzX011bHRpcGxl
Qm9yZWhvbGVzV2l0aEhlYXRQdW1wMi50eHQNCj4gDQo+IENoYW5nZXMgbm90IHN0YWdlZCBmb3Ig
Y29tbWl0Og0KPiAgKHVzZSAiZ2l0IGFkZCA8ZmlsZT4uLi4iIHRvIHVwZGF0ZSB3aGF0IHdpbGwg
YmUgY29tbWl0dGVkKQ0KPiAgKHVzZSAiZ2l0IGNoZWNrb3V0IC0tIDxmaWxlPi4uLiIgdG8gZGlz
Y2FyZCBjaGFuZ2VzIGluIHdvcmtpbmcgZGlyZWN0b3J5KQ0KPiANCj4gICAgICAgIG1vZGlmaWVk
OiAgIElERUFTL1Jlc291cmNlcy9SZWZlcmVuY2VSZXN1bHRzL0R5bW9sYS9JREVBU19VdGlsaXRp
ZXNfUHN5Y2hyb21ldHJpY3NfRnVuY3Rpb25zX0V4YW1wbGVzX3NhdHVyYXRpb25QcmVzc3VyZS50
eHQNCj4gDQo+IHVzZXJAbWFjOi90bXAvSURFQVM+DQoNCg==
