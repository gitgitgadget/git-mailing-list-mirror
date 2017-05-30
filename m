Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A067E1FD09
	for <e@80x24.org>; Tue, 30 May 2017 08:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750992AbdE3ITw (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 04:19:52 -0400
Received: from mikako.shopkeeper.de ([82.119.175.20]:29561 "EHLO
        mikako.shopkeeper.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdE3ITv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 04:19:51 -0400
Received: from email.pecont.de (p54B88C92.dip0.t-ipconnect.de [84.184.140.146])
        (authenticated bits=0)
        by mikako.shopkeeper.de (8.15.2/8.14.3) with ESMTPSA id v4U8JgXF085831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:19:49 +0200 (CEST)
        (envelope-from mathias.artus@pecont.de)
Message-Id: <201705300819.v4U8JgXF085831@mikako.shopkeeper.de>
X-Authentication-Warning: mikako.shopkeeper.de: Host p54B88C92.dip0.t-ipconnect.de [84.184.140.146] claimed to be email.pecont.de
X-CTCH-RefID: str=0001.0A0C0206.592D2B18.00FB,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Mathias Artus <mathias.artus@pecont.de>
To:     Johannes Sixt <j6t@kdbg.org>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: Error with Templates: Could not find templates on cloning but
 on creating
Thread-Topic: Error with Templates: Could not find templates on cloning but
 on creating
Thread-Index: AQHS2L9LlWIJ+ANcSZmo3Pus4h+iZ6IMiRzQ
Date:   Tue, 30 May 2017 08:19:33 +0000
References: <201705291120.v4TBKfkV082879@mikako.shopkeeper.de>
 <fa99116f-ce82-f7c6-30ed-807c873c3634@kdbg.org>
In-Reply-To: <fa99116f-ce82-f7c6-30ed-807c873c3634@kdbg.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-as-product-ver: SMEX-10.5.0.1057-8.100.1062-23100.006
x-tm-as-result: No--12.945900-5.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgSGFubmVzLA0Kbm8gaSB1c2UgdGhlIG5hdGl2ZSBpbnN0YWxsYXRpb24gd2l0aCBNaW5ndy4N
Cg0KR3JlZXR6IE1hdGhpYXMNCg0KTWl0IGZyZXVuZGxpY2hlbiBHcsO8w59lbg0KTWF0aGlhcyBB
cnR1cw0KcGVjb250wqBzdGV1ZXJ1bmdlbiAvwqBzb2Z0d2FyZSBHbWJIIC/CoEt1cnQgRnJhbmtl
IFN0cmHDn2UgMSAvIMKgOTkwOTggRXJmdXJ0L8KgIEdlc2Now6RmdHNmw7xocmVyOsKgIFZvbGtl
ciBQZW5uZXdpdHosIMKgQW50cyBXaWVnYW5kIC8gDQpUZWwuOiArNDnCoCgxNzIpIDY5NDg2NDkg
LyBGYXg6ICs0OcKgKDM2MjAzKSA3MTk3NzYgLyBIUkI6wqAxMDc0NDMgLyBKZW5hIA0KDQoNCi0t
LS0tVXJzcHLDvG5nbGljaGUgTmFjaHJpY2h0LS0tLS0NClZvbjogSm9oYW5uZXMgU2l4dCBbbWFp
bHRvOmo2dEBrZGJnLm9yZ10gDQpHZXNlbmRldDogTW9udGFnLCAyOS4gTWFpIDIwMTcgMjM6MDUN
CkFuOiBNYXRoaWFzIEFydHVzIDxtYXRoaWFzLmFydHVzQHBlY29udC5kZT4NCkNjOiBnaXRAdmdl
ci5rZXJuZWwub3JnDQpCZXRyZWZmOiBSZTogRXJyb3Igd2l0aCBUZW1wbGF0ZXM6IENvdWxkIG5v
dCBmaW5kIHRlbXBsYXRlcyBvbiBjbG9uaW5nIGJ1dCBvbiBjcmVhdGluZw0KDQpBbSAyOS4wNS4y
MDE3IHVtIDEzOjIwIHNjaHJpZWIgTWF0aGlhcyBBcnR1czoNCj4gSGksDQo+IFRvZGF5IGkndmUg
dHJpZWQgdG8gc2V0IHVwIGEgdGVtcGxhdGUgZGlyZWN0b3J5LiBJIGFkZGVkIGluIHRoZSBzeXN0
ZW0gd2lkZSBnaXRjb25maWcgdGhlIGZvbGxvd2luZyBsaW5lczoNCj4gCQ0KPiAJW2luaXRdDQo+
IAkJdGVtcGxhdGVkaXIgPSAiLy9PdXJTZXJ2ZXIvU29tZURpcmVjdG9yeS9HaXRUZW1wbGF0ZSIN
Cj4gDQo+IFdoZXJlIC8vT3Vyc2VydmVyIGlzIGEgTmV0d29yayBQYXRoLg0KPiBXaXRoIHRoaXMg
bGluZSBpIGNhbiBjcmVhdGUgYSBuZXcgUmVwb3NpdG9yeSBhbmQgdGhlIHRlbXBsYXRlIGdldHMg
Y29waWVkLiBCdXQgd2hlbiBpIGNsb25lIGEgcmVwbyB0aGUgZm9sbG93aW5nIGVycm9yIHNob3dz
IHVwIGFuZCB0aGUgdGVtcGxhdGUgZG9lc24ndCBnZXQgY29waWVkOg0KPiAJdGVtcGxhdGVzIG5v
dCBmb3VuZCAvT3VyU2VydmVyL1NvbWVEaXJlY3RvcnkvR2l0VGVtcGxhdGUNCj4gDQo+IEkgUmVj
b2duaXplZCB0aGF0IG9uZSBzbGFzaCB3YXMgbWlzc2luZy4gSGVuY2UgaSBhZGRlZCBvbmU6DQo+
IAlbaW5pdF0NCj4gCQl0ZW1wbGF0ZWRpciA9ICIvLy9PdXJTZXJ2ZXIvU29tZURpcmVjdG9yeS9H
aXRUZW1wbGF0ZSINCj4gDQo+IEZpbmUsIGNsb25pbmcgd29ya3MgYWZ0ZXIgdGhhdCwgYnV0IGNy
ZWF0aW5nIGEgbmV3IHJlcG9zaXRvcnkgdGhlbiBzaG93cyB1cCBhIFdhcm5pbmc6DQo+IAl0ZW1w
bGF0ZXMgbm90IGZvdW5kIC8vL091clNlcnZlci9Tb21lRGlyZWN0b3J5L0dpdFRlbXBsYXRlDQo+
IA0KPiBJcyB0aGF0IGEga25vd24gYnVnIG9yIGlzIGl0IG15IEZhaWx1cmU/DQo+IA0KPiBJIHVz
ZSBnaXQgMi4xMyBvbiB3aW5kb3dzIDcNCg0KSSBjYW5ub3QgcmVwcm9kdWNlLiBJJ20gb24gV2lu
ZG93cyA4LjEsIGJ1dCBJIHdvdWxkbid0IGV4cGVjdCB0aGF0IHRvIG1ha2UgYSBkaWZmZXJlbmNl
LiBBcmUgeW91IHVzaW5nIEN5Z3dpbidzIGdpdCBieSBhbnkgY2hhbmNlPw0KDQotLSBIYW5uZXMN
Cg0KDQo=
