Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D401F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 08:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389648AbeKVSwf (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 13:52:35 -0500
Received: from mail95.atlas.de ([194.156.172.85]:6609 "EHLO mail95.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733146AbeKVSwf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 13:52:35 -0500
X-Greylist: delayed 721 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2018 13:52:34 EST
X-IPAS-Result: =?us-ascii?q?A2BQAABSYvZb/wXKxApiHAEBAQQBAQcEAQGBUwUBAQsBgVq?=
 =?us-ascii?q?BD4Epg3iWJoNCk3iBeg0lhEcCF4QVNgcNAQMBAQEBAQECgQkMhT0BAQEDIxFFE?=
 =?us-ascii?q?AIBCBgCAiYCAgIwFQIBDQIEAQwBBwEBgx0BghCpfYEvhEQPbYRhBYELjRSBOIJ?=
 =?us-ascii?q?rgxsCgWEXgm2CVwKJIyyWMwcChnyKLR6BWYULgniHLI1DhAyGYYFNA4IDcIM9g?=
 =?us-ascii?q?zwBCIJCilJyAQEBjiABAQ?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW101FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 22 Nov 2018 09:01:58 +0100
Received: from localhost.localdomain (localhost [127.0.0.1])
        by SCESRV02.atlas.de (Postfix) with SMTP id 430sNQ3h7Xz2yWPR
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 08:01:58 +0000 (UTC)
Received: from MGW201PAR.atlas.de (unknown [10.206.101.60])
        by SCESRV02.atlas.de (Postfix) with ESMTPS id 430sNQ1W2xz2yWPD
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 08:01:58 +0000 (UTC)
Received: from msexsrv1.atlas.de ([10.200.102.56])
  by MGW201DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Nov 2018 09:01:58 +0100
Received: from MSEXSRV5.atlas.de ([169.254.3.159]) by MSEXSRV1.atlas.de
 ([10.200.102.56]) with mapi id 14.03.0351.000; Thu, 22 Nov 2018 09:01:58
 +0100
From:   <stefan.naewe@atlas-elektronik.com>
To:     <Johannes.Schindelin@gmx.de>, <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <git-for-windows@googlegroups.com>,
        <git-packagers@googlegroups.com>
Subject: Re: Git for Windows v2.20.0-rc0
Thread-Topic: Git for Windows v2.20.0-rc0
Thread-Index: AQHUgjmkYYrQoLUMmUuWXY0KNrnlkQ==
Date:   Thu, 22 Nov 2018 08:01:57 +0000
Message-ID: <08df3706-fe2c-519b-f27c-3f706739d1d4@atlas-elektronik.com>
References: <xmqqh8gefowy.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1811202152290.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1811202152290.41@tvgsbejvaqbjf.bet>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <C43815C3AA9CF949A19D8228386A00E1@atlas-elektronik.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SnVzdCBhIHF1aWNrIG5vdGU6DQoNCkkgaW5zdGFsbGVkIHYyLjIwLjAtcmMwIHdpdGggdGhlc2Ug
b3B0aW9uczoNCg0KJCBjYXQgL2V0Yy9pbnN0YWxsLW9wdGlvbnMudHh0DQpFZGl0b3IgT3B0aW9u
OiBWSU0NCkN1c3RvbSBFZGl0b3IgUGF0aDoNClBhdGggT3B0aW9uOiBDbWQNClNTSCBPcHRpb246
IE9wZW5TU0gNCkNVUkwgT3B0aW9uOiBPcGVuU1NMDQpDUkxGIE9wdGlvbjogQ1JMRkNvbW1pdEFz
SXMNCkJhc2ggVGVybWluYWwgT3B0aW9uOiBNaW5UVFkNClBlcmZvcm1hbmNlIFR3ZWFrcyBGU0Nh
Y2hlOiBFbmFibGVkDQpVc2UgQ3JlZGVudGlhbCBNYW5hZ2VyOiBFbmFibGVkDQpFbmFibGUgU3lt
bGlua3M6IERpc2FibGVkDQpFbmFibGUgQnVpbHRpbiBSZWJhc2U6IEVuYWJsZWQNCkVuYWJsZSBC
dWlsdGluIFN0YXNoOiBFbmFibGVkDQoNCg0KDQpXaGVuIHN0YXJ0aW5nIHRoZSBnaXQgYmFzaCB0
d28gd2luZG93cyBwb3AgdXAgaW5zdGVhZCBvZiBvbmUuDQpPbmUgdGhhdCdzICJlbXB0eSIgYW5k
IHRoZSBvdGhlciBvbmUgY29udGFpbmluZyB0aGUgcmVhbCBnaXQgYmFzaC4NCg0KVGhhbmtzLA0K
ICBTdGVmYW4NCg0KQW0gMjAuMTEuMjAxOCB1bSAyMTo1NiBzY2hyaWViIEpvaGFubmVzIFNjaGlu
ZGVsaW46DQo+IFRlYW0sDQo+IA0KPiBPbiBTdW4sIDE4IE5vdiAyMDE4LCBKdW5pbyBDIEhhbWFu
byB3cm90ZToNCj4gDQo+PiBBbiBlYXJseSBwcmV2aWV3IHJlbGVhc2UgR2l0IHYyLjIwLjAtcmMw
IGlzIG5vdyBhdmFpbGFibGUgZm9yDQo+PiB0ZXN0aW5nIGF0IHRoZSB1c3VhbCBwbGFjZXMuICBJ
dCBpcyBjb21wcmlzZWQgb2YgODg3IG5vbi1tZXJnZQ0KPj4gY29tbWl0cyBzaW5jZSB2Mi4xOS4w
LCBjb250cmlidXRlZCBieSA3MSBwZW9wbGUsIDIzIG9mIHdoaWNoIGFyZQ0KPj4gbmV3IGZhY2Vz
Lg0KPiANCj4gVGhlICJmb3IgV2luZG93cyIgZmxhdm9yIG9mIEdpdCB2Mi4yMC4wLXJjMCBpcyBh
dmFpbGFibGUgaGVyZToNCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9naXQtZm9yLXdpbmRvd3Mv
Z2l0L3JlbGVhc2VzL3RhZy92Mi4yMC4wLXJjMC53aW5kb3dzLjENCj4gDQo+IFRoZSBjdXJyZW50
IGNoYW5nZSBsb2cgZm9yIHYyLjIwLjAgcmVhZHMgbGlrZSB0aGlzOg0KPiANCj4gQ2hhbmdlcyBz
aW5jZSBHaXQgZm9yIFdpbmRvd3MgdjIuMTkuMSAoT2N0IDV0aCAyMDE4KQ0KPiANCj4gUGxlYXNl
IG5vdGU6IEdpdCBDTUQgaXMgZGVwcmVjYXRlZCBhcyBvZiB0aGlzIEdpdCBmb3IgV2luZG93cyB2
ZXJzaW9uLiBUaGUNCj4gZGVmYXVsdCBpcyB0byBoYXZlIGdpdC5leGUgaW4gdGhlIFBBVEggYW55
d2F5LCBzbyB0aGVyZSBpcyBubyBub3RpY2VhYmxlDQo+IGRpZmZlcmVuY2UgYmV0d2VlbiBDTUQg
YW5kIEdpdCBDTUQuIEl0IGlzIGltcG9zc2libGUgdG8gdHVybiBvZmYgQ01EJ3MNCj4gYmVoYXZp
b3Igd2hlcmUgaXQgcGlja3MgdXAgYW55IGdpdC5leGUgaW4gdGhlIGN1cnJlbnQgZGlyZWN0b3J5
LCBzbyBsZXQncw0KPiBkaXNjb3VyYWdlIHRoZSB1c2Ugb2YgR2l0IENNRC4gVXNlcnMgd2hvIGRp
c2xpa2UgR2l0IEJhc2ggc2hvdWxkIHN3aXRjaCB0bw0KPiBQb3dlcnNoZWxsIGluc3RlYWQuDQo+
IA0KPiBOZXcgRmVhdHVyZXMNCj4gDQo+ICAg4oCiIENvbWVzIHdpdGggT3BlblNTSCB2Ny45cDEu
DQo+ICAg4oCiIFRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgZWRpdG9yIG9wdGlvbiB0byBjaG9vc2Ug
VmltIGhhcyBiZWVuIGNsYXJpZmllZA0KPiAgICAgdG8gc3RhdGUgdGhhdCB0aGlzIHVuc2V0cyBj
b3JlLmVkaXRvci4NCj4gICDigKIgQ29tZXMgd2l0aCBjVVJMIHY3LjYyLjAuDQo+ICAg4oCiIFRo
ZSB0eXBlIG9mIHN5bWxpbmtzIHRvIGNyZWF0ZSAoZGlyZWN0b3J5IG9yIGZpbGUpIGNhbiBub3cg
YmUNCj4gICAgIHNwZWNpZmllZCB2aWEgdGhlIC5naXRhdHRyaWJ1dGVzLg0KPiAgIOKAoiBUaGUg
RlNDYWNoZSBmZWF0dXJlIG5vdyB1c2VzIGEgZmFzdGVyIG1ldGhvZCB0byBlbnVtZXJhdGUgZmls
ZXMsDQo+ICAgICBtYWtpbmcgZS5nLiBnaXQgc3RhdHVzIGZhc3RlciBpbiBsYXJnZSByZXBvc2l0
b3JpZXMuDQo+ICAg4oCiIENvbWVzIHdpdGggR2l0IENyZWRlbnRpYWwgTWFuYWdlciB2MS4xOC4z
Lg0KPiAgIOKAoiBDb21lcyB3aXRoIEdpdCBMRlMgdjIuNi4wLg0KPiAgIOKAoiBDb21lcyB3aXRo
IE1TWVMyIHJ1bnRpbWUgKEdpdCBmb3IgV2luZG93cyBmbGF2b3IpIGJhc2VkIG9uIEN5Z3dpbg0K
PiAgICAgMi4xMS4yLg0KPiAgIOKAoiBUaGUgRlNDYWNoZSBmZWF0dXJlIHdhcyBvcHRpbWl6ZWQg
dG8gYmVjb21lIGZhc3Rlci4NCj4gDQo+IEJ1ZyBGaXhlcw0KPiANCj4gICDigKIgVGhlIDY0LWJp
dCBQb3J0YWJsZSBHaXQgbm8gbG9uZ2VyIHNldHMgcGFjay5wYWNrU2l6ZUxpbWl0Lg0KPiANCj4g
VGhhbmtzLA0KPiBKb2hhbm5lcw0KPiANCg0KDQotLSANCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCi9kZXYvcmFuZG9tIHNh
eXM6IFRvIHNhdmUgdHJvdWJsZSBsYXRlciwgSm9lIG5hbWVkIGhpcyBjYXQgUm9hZGtpbGwgRnJl
ZA0KcHl0aG9uIC1jICJwcmludCAnNzM3NDY1NjY2MTZlMmU2ZTYxNjU3NzY1NDA2MTc0NmM2MTcz
MmQ2NTZjNjU2Yjc0NzI2ZjZlNjk2YjJlNjM2ZjZkJy5kZWNvZGUoJ2hleCcpIiANCkdQRyBLZXkg
ZmluZ2VycHJpbnQgPSAyREY1IEUwMUIgMDlDMyA3NTAxIEJDQTkgIDk2NjYgODI5QiA0OUM1IDky
MjEgMjdBRg==

