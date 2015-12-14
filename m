From: Jack McLear <mclear7@hotmail.co.uk>
Subject: Questions about GIT
Date: Mon, 14 Dec 2015 10:48:58 +0000
Message-ID: <HE1PR09MB044194E1689C460D0B1C7D06B1ED0@HE1PR09MB0441.eurprd09.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 11:54:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Qld-0006xL-SV
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 11:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbbLNKyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 05:54:05 -0500
Received: from dub004-omc4s25.hotmail.com ([157.55.2.100]:51613 "EHLO
	DUB004-OMC4S25.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932121AbbLNKyE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 05:54:04 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2015 05:54:03 EST
Received: from EUR01-DB5-obe.outbound.protection.outlook.com ([157.55.2.72]) by DUB004-OMC4S25.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Mon, 14 Dec 2015 02:48:59 -0800
Received: from HE1PR09MB0441.eurprd09.prod.outlook.com (10.161.121.19) by
 HE1PR09MB0442.eurprd09.prod.outlook.com (10.161.121.20) with Microsoft SMTP
 Server (TLS) id 15.1.355.16; Mon, 14 Dec 2015 10:48:59 +0000
Received: from HE1PR09MB0441.eurprd09.prod.outlook.com ([10.161.121.19]) by
 HE1PR09MB0441.eurprd09.prod.outlook.com ([10.161.121.19]) with mapi id
 15.01.0355.012; Mon, 14 Dec 2015 10:48:58 +0000
Thread-Topic: Questions about GIT
Thread-Index: AQHRNl0Jmb8+VP8LM0GkeSshARzvxw==
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hotmail.co.uk;
x-ms-exchange-messagesentrepresentingtype: 1
x-microsoft-exchange-diagnostics: 1;HE1PR09MB0442;23:37XUIu5O/Z95TQ5KpnZXu9mWHBvneR1MFD8Hh4W4ch9wBugAsKSUZsNKlzk18Shxadnsd22FDlERmo1+oEklYTNYwMg2bHtQh0eiJWXLaVDNrKP61hFlvR01oDybrG9qGTdWZs2EK6NjuwtCyCiQtzOyuXpiPsIW1Use1fGEOolTmwI4cZ87RPM4ywelDJD0eP5GAUbHSNtNbcdgkka0pg==;5:tyuN2H8qH39f30jlQGU04XTwPwa4DY0p1f9zWvXWG08E6B8LmucDJDgKwkGSq4meOU2ePM8dhvdpvSx/ArLBnO6rS7tu+4TEK/oEBVjnB6rT28sYwhDR6VVXX57cEp3TuwgTjdCJwMKxuBFyKN99Qg==;24:6oc/ib4ZyOJf88KjJ3BqsskpnGPIL9073t4YESUJRtewpFcaCOOf2pXfjFO915uJWNwNco0HrUssg0KaT7z9HUvDEiY6c6nvjj7Cebxdz/c=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR09MB0442;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(432015012)(82015046);SRVR:HE1PR09MB0442;BCL:0;PCL:0;RULEID:;SRVR:HE1PR09MB0442;
x-forefront-prvs: 0790FB1F33
x-forefront-antispam-report: SFV:NSPM;SFS:(7070004)(98900002);DIR:OUT;SFP:1901;SCL:1;SRVR:HE1PR09MB0442;H:HE1PR09MB0441.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
Content-ID: <17368335F9B2A842AE3361DB973B7DDE@eurprd09.prod.outlook.com>
X-OriginatorOrg: sct-15-1-318-15-msonline-outlook-3d97b.templateTenant
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2015 10:48:58.6094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR09MB0442
X-OriginalArrivalTime: 14 Dec 2015 10:48:59.0591 (UTC) FILETIME=[09DECD70:01D1365D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282354>

SGkNCg0KSeKAmXZlIHJlY2VudGx5IGJlZW4gbWFkZSBhd2FyZSBvZiBHSVQgYW5kIGhhZCBhIGZl
dyBxdWVzdGlvbnMuDQpJ4oCZbSBjdXJyZW50bHkgd29ya2luZyBvbiBjcmVhdGluZyBhIG1pZGRs
ZXdhcmUgYmV0d2VlbiBGT1JBTiAoYSBDQUQgc3lzdGVtKSBhbmQgVGVhbWNlbnRlci4NCg0KRG8g
eW91IGtub3cgaWYgR0lUIHdvdWxkIHdvcmsgYmV0d2VlbiB0aGUgdHdvPw0KDQpXZeKAmXJlIGN1
cnJlbnRseSB1c2luZyBhIENlbnRyYWxpc2VkIHZlcnNpb24gY29udHJvbCBzeXN0ZW0uDQoNClNv
IHRvIGNoZWNrIG15IHVuZGVyc3RhbmRpbmcsIHVzaW5nIEdJVCB0byBjcmVhdGUgYSBkaXN0cmli
dXRlZCB2ZXJzaW9uIGNvbnRyb2wgd291bGQgaGF2ZSB0aGUgZm9sbG93aW5nIGJlbmVmaXRzDQpU
aGUgQ0FEIGRlc2lnbmVyIHdobyBoYXMgZGVzaWduIGEgcHVtcCBhc3NlbWJseSBmb3IgZXhhbXBs
ZSBjb3VsZCBjcmVhdGUgYW4gYWRkaXRpb25hbCBicmFuY2ggYW5kIOKAnHBsYXlzIGFyb3VuZOKA
nSB3aXRoIHRoZSBwdW1wIHRvIG1ha2UgaW1wcm92ZW1lbnRzIHdpdGhvdXQgZWRpdGluZyB0aGUg
bWFpbiBwdW1wIGJyYW5jaD8NCkNvdWxkIG1vcmUgdGhhbiBvbmUgdXNlciBjcmVhdGUgaW5kZXBl
bmRlbnQgYnJhbmNoZXM/DQpJZiBib3RoIHVzZXJzIHdhbnRlZCB0byBtZXJnZSB0aGVpciBpbmRl
cGVuZGVudCBicmFuY2ggd2l0aCB0aGUgbWFpbiBicmFuY2gsIHdoYXQgd291bGQgaGFwcGVuPyBX
b3VsZCBvbmUgdGFrZSBwcmlvcml0eT8NCg0KSXMgdGhhdCB0aGUgbWFpbiBiZW5lZml0IGluIHRl
cm1zIG9mIGEgQ0FEIHN5c3RlbSwgdGhlIGJyYW5jaGluZyBhYmlsaXR5Pw0KDQpUaGFua3MNCg0K
SmFjaw0KDQo=
