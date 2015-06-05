From: <steve.norman@thomsonreuters.com>
Subject: RE: Troubleshoot clone issue to NFS.
Date: Fri, 5 Jun 2015 14:20:54 +0000
Message-ID: <7FAE15F0A93C0144AD8B5FBD584E1C5519776893@C111KXTEMBX51.ERF.thomson.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net>
 <CACsJy8Bb1O7QZtiPWdzYwYgOdV0dLDgD3Xu_YaWNUbsuTqJB5g@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C55197764FE@C111KXTEMBX51.ERF.thomson.com>
 <20150605121817.GA22125@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <pclouds@gmail.com>, <git@vger.kernel.org>
To: <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 05 16:21:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0sUi-0003EI-FT
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 16:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423480AbbFEOVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 10:21:05 -0400
Received: from mailout1-trp.thomsonreuters.com ([163.231.6.6]:26158 "EHLO
	mailout1-trp.thomsonreuters.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423475AbbFEOVC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 10:21:02 -0400
Received: from trpusmneagrly01.int.westgroup.com (relay1 [163.231.22.97])
	by mailout1-trp.thomsonreuters.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id t55EKtPK001861
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Fri, 5 Jun 2015 14:20:55 GMT
Received: from EAGH-ERFPHUB05.ERF.thomson.com (EAGH-ERFPHUB05.erf.thomson.com [163.231.29.164])
	by trpusmneagrly01.int.westgroup.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id t55EKsKu029858
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 5 Jun 2015 14:20:54 GMT
Received: from C111KXTEMBX51.ERF.thomson.com ([fe80::4999:4010:4bd1:ba61]) by
 EAGH-ERFPHUB05.ERF.thomson.com ([fe80::1c57:55a4:6bfc:4f11%11]) with mapi id
 14.03.0158.001; Fri, 5 Jun 2015 09:20:54 -0500
Thread-Topic: Troubleshoot clone issue to NFS.
Thread-Index: AdCTxW/SgCCnMnTuQvaf51AB2UW2tgAN1NmAAAA88gAACEcAsAAL7E0AAA6C3AAAaFyXAAJXRjmAAAsgcYAABtXxMA==
In-Reply-To: <20150605121817.GA22125@peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.30.5]
x-tm-as-product-ver: SMEX-10.2.0.3308-7.500.1018-21592.006
x-tm-as-result: No--39.292700-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270838>

T24gRnJpZGF5LCBKdW5lIDA1LCAyMDE1IEAgMToxOCBQTSBKZWZmIEtpbmcgW21haWx0bzpwZWZm
QHBlZmYubmV0XSBkaWQgc2NyaWJibGU6DQoNCj4gU29ycnksIEkgaGF2ZW4ndCBoYWQgYSBjaGFu
Y2UgdG8gbG9vayBhdCBpdCBmdXJ0aGVyLiBJdCBzdGlsbCBvbiBteSB0b2RvDQo+IGxpc3QuIE15
IHBsYW4gaXM6DQo+IA0KPiAgIDEuIERldmlzZSBzb21lIHRvcnR1cmUgdG8gdGVzdHMgdG8gc2Vl
IHdoZXRoZXIgbXkgcGF0Y2ggc2VyaWVzIGlzIGluDQo+ICAgICAgZmFjdCByYWN5IG9uIExpbnV4
Lg0KPiANCj4gICAyLiBBc3N1bWluZyBpdCBpcywgc2NyYXAgaXQgYW5kIG1ha2UgYSBoYXNfc2hh
MV9maWxlX3F1aWNrKCkgd2hpY2gNCj4gICAgICBtaWdodCBzb21ldGltZXMgcmV0dXJuIGEgZmFs
c2UgbmVnYXRpdmUgKGlmIHNvbWVib2R5IGVsc2UgaXMNCj4gICAgICByZXBhY2tpbmcpLiBVc2Ug
dGhhdCBpbiBpbmRleC1wYWNrIChhbmQgcG9zc2libHkgb3RoZXIgcGxhY2VzLCBidXQNCj4gICAg
ICB3ZSBjYW4gc3RhcnQgd2l0aCBpbmRleC1wYWNrKS4NCj4gDQo+IElmIHdlIHNraXAgc3RlcCAx
IG91dCBvZiBwZXNzaW1pc20gKHdoaWNoIEkgdGhpbmsgaXMgYSByZWFzb25hYmxlIHRoaW5nDQo+
IHRvIGRvKSwgdGhlbiBzdGVwIDIgc2hvdWxkIG5vdCBiZSBhbGwgdGhhdCBtdWNoIHdvcmsuIEkn
bSBnb2luZyB0byBiZQ0KPiBvZmZsaW5lIGZvciBhIGZldyBkYXlzLCB0aG91Z2gsIHNvIEkgd29u
J3QgZ2V0IHRvIGl0IHVudGlsIG5leHQgd2VlayBhdA0KPiB0aGUgZWFybGllc3QuIElmIHlvdSAo
b3Igc29tZW9uZSBlbHNlKSB3YW50cyB0byB0YWtlIGEgc3RhYiBhdCBpdCwNCj4gcGxlYXNlIGZl
ZWwgZnJlZS4NCg0KSSd2ZSBiZWVuIG9mZiBteXNlbGYgYW5kIHdhbnRlZCB0byBtYWtlIHN1cmUg
SSBoYWRuJ3QgbWlzc2VkIGFueXRoaW5nIGluIA0KdGhlIGVtYWlsIHRocmVhZHMgd2hpbGUgSSB3
YXMgYXdheSBhcyB0aGVyZSB3ZSByYXRoZXIgYSBsb3Qgb2YgdGhlbS4NCg0KTm90IGZlZWxpbmcg
Y29uZmlkZW50IGVub3VnaCB0byBtYWtlIHRoZSBjaGFuZ2VzIG15c2VsZiBhdCB0aGUgbW9tZW50
LiANCkkgdGhpbmsgd2hhdCB5b3UgYXJlIHNheWluZyBpcyB0aGF0IGhhc19zaGExX2ZpbGVfcXVp
Y2soKSB3b3VsZCBiZSB0aGUgdmVyc2lvbg0KZnJvbSBiZWZvcmUgeW91ciBjaGFuZ2UgaW4gNDVl
OGE3NC4gIEFuZCB0aGVuIHVzZSB0aGF0LCBidXQgSSBjb3VsZCBiZQ0KYmFya2luZyB1cCB0aGUg
d3JvbmcgdHJlZSBjb21wbGV0ZWx5Lg0KDQpUaGFua3MsDQoNClN0ZXZlDQo=
