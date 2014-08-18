From: "Dickson, Alex" <alex_dickson@mentor.com>
Subject: RE: Cannot run cmd command lines from GIT bash
Date: Mon, 18 Aug 2014 15:30:59 +0000
Message-ID: <E41D1E6BD9F1DF48877C833FE120496FDDE1D3FA@EU-MBX-04.mgc.mentorg.com>
References: <E41D1E6BD9F1DF48877C833FE120496FDDE1D2FD@EU-MBX-04.mgc.mentorg.com>
 <1193308472.195844.1408373013669.JavaMail.zimbra@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 17:33:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJOwI-0002qA-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 17:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbaHRPbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 11:31:03 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:55446 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbaHRPbC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 11:31:02 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp 
	id 1XJOtg-00061u-OS from alex_dickson@mentor.com ; Mon, 18 Aug 2014 08:31:00 -0700
Received: from SVR-IES-FEM-03.mgc.mentorg.com ([137.202.0.108]) by SVR-ORW-EXC-10.mgc.mentorg.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 18 Aug 2014 08:31:00 -0700
Received: from EU-MBX-04.mgc.mentorg.com ([169.254.4.161]) by
 SVR-IES-FEM-03.mgc.mentorg.com ([137.202.0.108]) with mapi id 14.02.0247.003;
 Mon, 18 Aug 2014 16:30:59 +0100
Thread-Topic: Cannot run cmd command lines from GIT bash
Thread-Index: Ac+61DagxPOXr1ytShaxC21qQgOaGgAAFjSgl4rXcCyXio7EsA==
In-Reply-To: <1193308472.195844.1408373013669.JavaMail.zimbra@dewire.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.202.0.76]
X-OriginalArrivalTime: 18 Aug 2014 15:31:00.0632 (UTC) FILETIME=[6A138180:01CFBAF9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255391>

VGhhbmtzIGZvciB5b3VyIHJlcGx5LCBJIGhhZG4ndCBrbm93biB0aGF0IG1zeXMgZGlkIHRyYW5z
bGF0aW9uIG9mIHBhcmFtZXRlcnMgd2l0aCAvLg0KRG91YmxpbmcgdGhlc2UgdXAgZG9lcyBtYWtl
IHRoZSBjb21tYW5kcyB3b3JrLCBidXQgZG9lc27igJl0IGV4cGxhaW4gd2h5IHRoZXkgdXNlZCB0
byB3b3JrIGFuZCBub3cgZG9uJ3QgOigNCg0KQWxleCBEaWNrc29uLCBJRVNELCBNZW50b3IgR3Jh
cGhpY3MsIE5ld2J1cnksIFVLLg0KcGhvbmU6KzQ0IDE2MzUgODExNDI5LCAgICAgICAgZmF4Ois0
NCAxNjM1IDgxMDEwMg0KbWFpbHRvOmFsZXhfZGlja3NvbkBtZW50b3IuY29tLCBodHRwOi8vd3d3
Lm1lbnRvci5jb20NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFJvYmluIFJv
c2VuYmVyZyBbbWFpbHRvOnJvYmluLnJvc2VuYmVyZy5saXN0c0BkZXdpcmUuY29tXSANClNlbnQ6
IDE4IEF1Z3VzdCAyMDE0IDE1OjQ0DQpUbzogRGlja3NvbiwgQWxleA0KQ2M6IGdpdEB2Z2VyLmtl
cm5lbC5vcmcNClN1YmplY3Q6IFJlOiBDYW5ub3QgcnVuIGNtZCBjb21tYW5kIGxpbmVzIGZyb20g
R0lUIGJhc2gNCg0KDQoNCi0tLS0tIFVyc3BydW5nbGlndCBtZWRkZWxhbmRlIC0tLS0tDQo+IEZy
w6VuOiAiQWxleCBEaWNrc29uIiA8YWxleF9kaWNrc29uQG1lbnRvci5jb20+DQo+IFRpbGw6IGdp
dEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2tpY2thdDogbcOlbmRhZywgMTggYXVnIDIwMTQgMTM6MDc6
NDYNCj4gw4RtbmU6IENhbm5vdCBydW4gY21kIGNvbW1hbmQgbGluZXMgZnJvbSBHSVQgYmFzaA0K
PiANCj4gSEksDQo+IEkgaGF2ZSBqdXN0IGluc3RhbGxlZCBHSVQgZnJvbSBHaXQtMS45LjQtcHJl
dmlldzIwMTQwODE1LmV4ZSBoYXZpbmcNCj4gcHJldmlvdXNseSBiZWVuIHVzaW5nIEdpdC0xLjku
Mi1wcmV2aWV3MjAxNDA0MTEuZXhlIEkgbm93DQo+IGZpbmQgdGhhdCBzb21lIHNjcmlwdHMgSSBo
YXZlIGJlZW4gdXNpbmcgZm9yIHNvbWUgdGltZSBhcmUgbm8gbG9uZ2VyIHdvcmtpbmcNCj4gY29y
cmVjdGx5Lg0KPiANCj4gSXQgc2VlbXMgdGhhdCBub3cgSSBjYW5ub3QgcGFzcyBwYXJhbWV0ZXJz
IHRocm91Z2ggdG8gYSBET1MgwqBjb21tYW5kIGUuZy4NCj4gwqDCoMKgwqBuZXQgdXNlciA8dXNl
cm5hbWU+IC9ET01BSU4NCj4gDQo+IHVzZWQgdG8gcmV0dXJuIGZ1bGwgaW5mb3JtYXRpb24gYWJv
dXQgdGhlIHVzZXIsIG5vdyBpdCBqdXN0IHJldHVybnMgdXNlcm5hbWUNCj4gbm90IGZvdW5kLCB3
aGljaCBpcyB0aGUgYmVoYXZpb3VyDQo+IGlmIGl0IGlzIGludm9rZWQgd2l0aG91dCB0aGUgL0RP
TUFJTiBzd2l0Y2guIEkgaGF2ZSBzZWVuIHNpbWlsYXIgd2l0aCBvdGhlcg0KPiBjb21tYW5kcywg
YW4gZXZlbiBzaW1wbGVyIGV4YW1wbGUgd291bGQgYmUNCj4gwqDCoCBjbWQgL2MgZGlyDQo+IA0K
PiBUaGlzIHNob3VsZCBydW4gdGhlIERPUyBkaXIgY29tbWFuZCwgYnV0IGFsbCBpdCBkb2VzIGlz
IGludm9rZSBjbWQuZXhlDQo+IMKgaW50ZXJhY3RpdmVseQ0KDQptc3lzIHRyYW5zbGF0ZXMgYW55
dGhpbmcgdGhhdCBsb29rcyBsaWtlIGEgdW5peCBwYXRoLiB0cnkgZG91YmxpbmcgYWxsIGluaXRp
YWwNCnNsYXNoZXMsIGkuZS4gY21kIC8vYyBkaXINCg0KWW91IG1pZ2h0IGhhdmUgYmV0dGVyIGx1
Y2sgd2l0aCBXaW5kb3dzIHNwZWNpZmllIHF1ZXN0aW9ucyBpbiBvbmUgb2YgdGhlDQptc3lzZ2l0
IGZvcnVtcyB0aGFuIGhlcmUuDQoNCi0tIHJvYmluDQo=
