From: Quintin Ronan <ronan.quintin@sopragroup.com>
Subject: RE: Unable to compile Git on HP-UX B.11.31 U ia64
Date: Wed, 14 Nov 2012 11:31:02 +0000
Message-ID: <30295_1352892663_50A380F7_30295_18481_1_67156E3FC2DDE6479DE35C159B9C2B582C59CEF4@wptxexmbx03.ptx.fr.sopra>
References: <30295_1352891883_50A37DEB_30295_18278_1_67156E3FC2DDE6479DE35C159B9C2B582C59CEE6@wptxexmbx03.ptx.fr.sopra>
 <50A37FAD.1030901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 12:31:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYbBi-00014P-Br
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 12:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab2KNLbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 06:31:07 -0500
Received: from mailgw2.z-ptx-11.fr.sopragroup.com ([81.80.239.194]:52630 "EHLO
	mailgw2.z-ptx-11.fr.sopragroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752454Ab2KNLbF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2012 06:31:05 -0500
Received: from mailgw2.z-ptx-11.fr.sopragroup.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id E4DF9D0198;
	Wed, 14 Nov 2012 12:31:03 +0100 (CET)
Thread-Topic: Unable to compile Git on HP-UX B.11.31 U ia64
Thread-Index: AQHNwlrChqDOWdlURHOTeAXCDr55mJfpMZ1A
In-Reply-To: <50A37FAD.1030901@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.180.118]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209712>

SGVsbG8gU3RlZmFubywNCg0KVGhhbmsgeW91IGZvciB5b3VyIHF1aWNrIGFuc3dlci4gWW91IGFy
ZSByaWdodCwgSFAtVVggaGF2ZSBhIGdtYWtlIGV4ZWN1dGFibGUgOg0KDQoNCiNnbWFrZSAtLXZl
cnNpb24NCkdOVSBNYWtlIDMuODENCkNvcHlyaWdodCAoQykgMjAwNiAgRnJlZSBTb2Z0d2FyZSBG
b3VuZGF0aW9uLCBJbmMuDQpUaGlzIGlzIGZyZWUgc29mdHdhcmU7IHNlZSB0aGUgc291cmNlIGZv
ciBjb3B5aW5nIGNvbmRpdGlvbnMuDQpUaGVyZSBpcyBOTyB3YXJyYW50eTsgbm90IGV2ZW4gZm9y
IE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBDQpQQVJUSUNVTEFSIFBVUlBPU0UuDQoN
ClRoaXMgcHJvZ3JhbSBidWlsdCBmb3IgaWE2NC1ocC1ocHV4MTEuMzENCg0KDQpJIHdpbGwgdHJ5
IHRvIHVzZSB0aGlzIGluc3RlYWQgb2YgbWFrZSANCg0KQ29yZGlhbGVtZW50LA0KDQpSb25hbiBR
VUlOVElODQpUTUEgRUFJIC0gRGl2aXNpb24gVGVsZWNvbSAmIE1lZGlhDQpTb3ByYSBncm91cC4N
CkNlbnRyZSBFc3BhY2UgUGVyZm9ybWFuY2UgLSBCYXRpbWVudCBTDQozNTc2OSBTdCBHcsOpZ29p
cmUNClBob25lIDogKzMzICgwKTIgMjMgMjUgMzQgNzENCnJvbmFuLnF1aW50aW5Ac29wcmFncm91
cC5jb20gLSB3d3cuc29wcmFncm91cC5jb20NCg0KQ2UgbWVzc2FnZSBwZXV0IGNvbnRlbmlyIGRl
cyBpbmZvcm1hdGlvbnMgY29uZmlkZW50aWVsbGVzIGRvbnQgbGEgZGl2dWxnYXRpb24gZXN0IMOg
IGNlIHRpdHJlIHJpZ291cmV1c2VtZW50IGludGVyZGl0ZSBlbiBsJ2Fic2VuY2UgZCdhdXRvcmlz
YXRpb24gZXhwbGljaXRlIGRlIGwnw6ltZXR0ZXVyLiBEYW5zIGwnaHlwb3Row6hzZSBvw7kgdm91
cyBhdXJpZXogcmXDp3UgcGFyIGVycmV1ciBjZSBtZXNzYWdlLCBtZXJjaSBkZSBsZSByZW52b3ll
ciDDoCBswpLDqW1ldHRldXIgZXQgZGUgZMOpdHJ1aXJlIHRvdXRlIGNvcGllLg0KDQrvgZDCoFBl
bnNleiDDoCBswpJlbnZpcm9ubmVtZW50IGF2YW50IGTCkmltcHJpbWVyLg0KDQoNCi0tLS0tTWVz
c2FnZSBkJ29yaWdpbmUtLS0tLQ0KRGXCoDogU3RlZmFubyBMYXR0YXJpbmkgW21haWx0bzpzdGVm
YW5vLmxhdHRhcmluaUBnbWFpbC5jb21dIA0KRW52b3nDqcKgOiBtZXJjcmVkaSAxNCBub3ZlbWJy
ZSAyMDEyIDEyOjI2DQrDgMKgOiBRdWludGluIFJvbmFuDQpDY8KgOiBnaXRAdmdlci5rZXJuZWwu
b3JnDQpPYmpldMKgOiBSZTogVW5hYmxlIHRvIGNvbXBpbGUgR2l0IG9uIEhQLVVYIEIuMTEuMzEg
VSBpYTY0DQoNCk9uIDExLzE0LzIwMTIgMTI6MTggUE0sIFF1aW50aW4gUm9uYW4gd3JvdGU6DQo+
IEhlbGxvLA0KPiANCj4gSeKAmW0gdHJ5aW5nIHRvIGNvbXBpbGUgZ2l0IDEuNyBvbiBhIEhQVVgg
c2VydmVyIHVzaW5nIG1ha2UuDQo+IFRoZSAuL2NvbmZpZ3VyZSB3b3JrZWQgd2VsbCA6DQo+DQo+
IFtTTklQXQ0KPiANCj4gQnV0IHdoZW4gaSBydW4gbWFrZSAod2l0aCDigJNkKSBpdCBzaW1wbHkg
ZG9lc27igJl0IHdvcmsgd2l0aCBhIG1lc3NhZ2UNCj4gd2hpY2ggaXNu4oCZdCByZWFsbHkgaGVs
cGZ1bGwgOg0KPiANCj4gICBbU05JUF0NCj4gICBNYWtlOiBsaW5lIDMxMzogc3ludGF4IGVycm9y
LiAgU3RvcC4NCj4gDQo+IENhbiB5b3UgaGVscCBtZSA/DQo+IA0KVGhlIEdpdCBidWlsZCBzeXN0
ZW0gcmVxdWlyZXMgR05VIG1ha2UsIGJ1dCBpdCBzZWVtcyB0byBtZSB5b3UgYXJlIHVzaW5nDQp5
b3VyIHN5c3RlbSBuYXRpdmUgbWFrZSBpbnN0ZWFkLiAgVGhhdCB3b24ndCB3b3JrLiAgSXQgbWln
aHQgYmUgdGhlIGNhc2UNCkdOVSBtYWtlIGlzIGluc3RhbGxlZCBvbiB5b3VyIHN5c3RlbSwgYnV0
IGlzIG5hbWVkIHNvbWV0aGluZyBsaWtlICdnbWFrZScNCm9yICdnbnVtYWtlJyByYXRoZXIgdGhh
biBqdXN0ICdtYWtlJy4gIFdoYXQgaGFwcGVucyBpZiB5b3UgcnVuIHRoZQ0KZm9sbG93aW5nPw0K
DQogICAkIGdtYWtlIC0tdmVyc2lvbg0KICAgJCBnbnVtYWtlIC0tdmVyc2lvbg0KDQpJZiBHTlUg
bWFrZSBpcyBub3QgaW5zdGFsbGVkIG9uIHlvdXIgc3lzdGVtLCB5b3UgY2FuIGRvd25sb2FkIHRo
ZSBsYXRlc3QNCnZlcnNpb24gZnJvbSBoZXJlOg0KDQogICAgPGh0dHA6Ly9mdHAuZ251Lm9yZy9n
bnUvbWFrZS9tYWtlLTMuODIudGFyLmd6Pg0KDQpGb3IgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCBH
TlUgbWFrZToNCg0KICAgIDxodHRwOi8vd3d3LmdudS5vcmcvc29mdHdhcmUvbWFrZS8+DQoNCkhU
SCwNCiAgU3RlZmFubw0K
