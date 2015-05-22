From: <steve.norman@thomsonreuters.com>
Subject: RE: Troubleshoot clone issue to NFS.
Date: Fri, 22 May 2015 15:02:45 +0000
Message-ID: <7FAE15F0A93C0144AD8B5FBD584E1C551975B851@C111KXTEMBX51.ERF.thomson.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net>
 <7FAE15F0A93C0144AD8B5FBD584E1C551975ADA4@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8DMqj8sCowZ5f-QZMgrAMFjGOaWfYjZWHxs+jvBsDpp5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <peff@peff.net>, <git@vger.kernel.org>
To: <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 17:03:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvoTg-0008Al-0I
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 17:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757554AbbEVPDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 11:03:07 -0400
Received: from mailout2-trp.thomsonreuters.com ([163.231.6.26]:31667 "EHLO
	mailout2-trp.thomsonreuters.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757550AbbEVPDF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 11:03:05 -0400
Received: from trpusmneagrly02.int.westgroup.com (relay2 [163.231.22.113])
	by mailout2-trp.thomsonreuters.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id t4MF31EK002124
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Fri, 22 May 2015 15:03:02 GMT
Received: from EAGE-ERFPHUB02.ERF.thomson.com (EAGE-ERFPHUB02.erf.thomson.com [163.231.23.34])
	by trpusmneagrly02.int.westgroup.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id t4MF2oVH018085
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 22 May 2015 15:03:00 GMT
Received: from C111KXTEMBX51.ERF.thomson.com ([fe80::4999:4010:4bd1:ba61]) by
 EAGE-ERFPHUB02.ERF.thomson.com ([fe80::402b:12:41dc:62a1%12]) with mapi id
 14.03.0158.001; Fri, 22 May 2015 10:02:45 -0500
Thread-Topic: Troubleshoot clone issue to NFS.
Thread-Index: AdCTxW/SgCCnMnTuQvaf51AB2UW2tgAN1NmAAAA88gAACEcAsAAL7E0AAA6C3AAACBBrAP//7+AAgAACocA=
In-Reply-To: <CACsJy8DMqj8sCowZ5f-QZMgrAMFjGOaWfYjZWHxs+jvBsDpp5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.30.8]
x-tm-as-product-ver: SMEX-10.2.0.3308-7.500.1018-21560.006
x-tm-as-result: No--46.609600-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269727>

T24gRnJpZGF5LCBNYXkgMjIsIDIwMTUgQCAxMTowNiBBTSBEdXkgTmd1eWVuIGRpZCB3cml0ZToN
Cg0KPiBTdHJhbmdlLiBNYXliZSB0aGVyZSBpcyBzb21ldGhpbmcgZWxzZS4uLiBBbnl3YXkgc29t
ZSBudW1iZXJzIGZyb20gbWUuDQo+IFRoaXMgaXMgbmZzMyBob3N0ZWQgYnkgUmFzcGJlcnJ5IFBp
LCBhY2Nlc3NlZCBvdmVyIHdpcmVsZXNzLiBJIGp1c3QNCj4gcnVuIGluZGV4LXBhY2sgb24gZ2l0
LmdpdCBwYWNrIGluc3RlYWQgb2YgZnVsbCBjbG9uZS4NCj4gDQo+ICAtIHYxLjguNC4xIDM0cw0K
PiAgLSB2MS44LjQuMiA1MTlzIChvaC4uIHdpcmVsZXNzLi4pDQo+ICAtIHYxLjguNC4yIHdpdGhv
dXQgaGFzX3NoYTFfZmlsZSgpIGluIGluZGV4LXBhY2suYyAzM3MNCj4gIC0gdjEuOC40LjIgKyBK
ZWZmJ3MgbXRpbWUgcGF0Y2ggMzZzDQoNCkp1c3QgcmFuIHRoZSB0ZXN0IGFnYWluIGFuZCBpdCB3
YXMgMTIgc2Vjb25kcy4gICBUb28gbWFueSB2ZXJzaW9ucyBvZiBnaXQgYXZhaWxhYmxlIG9uIHRo
ZSANCm1hY2hpbmUgYW5kIEkgdGhpbmsgSSBtaWdodCBoYXZlIHJ1biB0aGUgd3Jvbmcgb25lOg0K
DQp+ICQgdGltZSBiaW4vZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNvbS9naXQvZ2l0IHRlc3QN
CkNsb25pbmcgaW50byAndGVzdCcuLi4NCnJlbW90ZTogQ291bnRpbmcgb2JqZWN0czogMTg2MDE1
LCBkb25lLg0KcmVtb3RlOiBDb21wcmVzc2luZyBvYmplY3RzOiAxMDAlICg4LzgpLCBkb25lLg0K
cmVtb3RlOiBUb3RhbCAxODYwMTUgKGRlbHRhIDgpLCByZXVzZWQgNyAoZGVsdGEgNyksIHBhY2st
cmV1c2VkIDE4NjAwMA0KUmVjZWl2aW5nIG9iamVjdHM6IDEwMCUgKDE4NjAxNS8xODYwMTUpLCA2
MS4zMyBNaUIgfCAzMC4zNSBNaUIvcywgZG9uZS4NClJlc29sdmluZyBkZWx0YXM6IDEwMCUgKDEz
NTUxMi8xMzU1MTIpLCBkb25lLg0KQ2hlY2tpbmcgY29ubmVjdGl2aXR5Li4uIGRvbmUuDQoNCnJl
YWwgICAgMG02LjkzMXMNCnVzZXIgICAgMG0xMC4wMTFzDQpzeXMgICAgIDBtMi42ODVzDQoNCn4g
JCB0aW1lIGJpbi9naXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL2dpdC9naXQgL3NhbWkvdGVz
dA0KQ2xvbmluZyBpbnRvICcvc2FtaS90ZXN0Jy4uLg0KcmVtb3RlOiBDb3VudGluZyBvYmplY3Rz
OiAxODYwMTUsIGRvbmUuDQpyZW1vdGU6IENvbXByZXNzaW5nIG9iamVjdHM6IDEwMCUgKDgvOCks
IGRvbmUuDQpyZW1vdGU6IFRvdGFsIDE4NjAxNSAoZGVsdGEgOCksIHJldXNlZCA3IChkZWx0YSA3
KSwgcGFjay1yZXVzZWQgMTg2MDAwDQpSZWNlaXZpbmcgb2JqZWN0czogMTAwJSAoMTg2MDE1LzE4
NjAxNSksIDYxLjMzIE1pQiB8IDI5LjkxIE1pQi9zLCBkb25lLg0KUmVzb2x2aW5nIGRlbHRhczog
MTAwJSAoMTM1NTEyLzEzNTUxMiksIGRvbmUuDQpDaGVja2luZyBjb25uZWN0aXZpdHkuLi4gZG9u
ZS4NCkNoZWNraW5nIG91dCBmaWxlczogMTAwJSAoMjc5NS8yNzk1KSwgZG9uZS4NCg0KcmVhbCAg
ICAwbTEzLjE2OXMNCnVzZXIgICAgMG05Ljk2MXMNCnN5cyAgICAgMG0zLjQ4MHMNCg0KU28gIEkg
d291bGQgc2F5IHRoYXQgd2FzIGluIGxpbmUgd2l0aCB0aGUgdGltaW5ncyBmb3IgdGhlIG90aGVy
IHZlcnNpb25zIEkgaGF2ZSB0ZXN0ZWQuDQoNCkFuZCBsb29raW5nIGJhY2sgYXQgdGhlIGVtYWls
IGZyb20gdGhlIG1vcm5pbmcgSSBkaWQgcnVuIHRoZSB3cm9uZyBiaW4vZ2l0LiAgIFNvcnJ5LCB0
b3RhbGx5IG15IGZhdWx0IG9uIHRoYXQuIA0KDQpJZiBJIGNhbiB0ZXN0IGFueXRoaW5nIGVsc2Ug
dGhlbiBsZXQgbWUga25vdy4NCg0KVGhhbmtzLA0KDQpTdGV2ZQ0KLS0NCg==
