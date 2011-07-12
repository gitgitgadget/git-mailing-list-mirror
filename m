From: "Holding, Lawrence" <Lawrence.Holding@cubic.com>
Subject: RE: repository in different directories
Date: Wed, 13 Jul 2011 07:29:04 +1200
Message-ID: <A5E8E180685CEF45AB9E737A0107998009CB9B@cdnz-ex1.corp.cubic.cub>
References: <CABU6SG5uLXAsu0yXa1cmPAmte3WnsjaHN0r_D4c8C7W2tKJDHw@mail.gmail.com> <CACwv2A=d44+txUGGDxJRFHVps-eT5g_mWyA-WaKTXyyUFgix7g@mail.gmail.com> <CABU6SG4=UiuM7Q1RkXxR1oJKP72Sk69Awq09+64VOra3ds5hmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Cc: <git@vger.kernel.org>
To: "Carlo Trimarchi" <mr.spoon21@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 21:44:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgit6-0004Vd-Dm
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 21:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab1GLTov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 15:44:51 -0400
Received: from exprod6og115.obsmtp.com ([64.18.1.35]:47437 "HELO
	exprod6og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754215Ab1GLTov (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 15:44:51 -0400
X-Greylist: delayed 942 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jul 2011 15:44:51 EDT
Received: from bb-corp-outmail1.corp.cubic.com ([149.63.70.140]) (using TLSv1) by exprod6ob115.postini.com ([64.18.5.12]) with SMTP
	ID DSNKThykMg0wSmtNPMAs5aPwzY0rN3GFNDKd@postini.com; Tue, 12 Jul 2011 12:44:51 PDT
Received: from bb-corp-ex4.corp.cubic.cub ([149.63.2.70])
	by bb-corp-outmail1.corp.cubic.com (8.13.1/8.13.1) with ESMTP id p6CJT8lb026831;
	Tue, 12 Jul 2011 12:29:08 -0700
Received: from cdnz-ex1.corp.cubic.cub ([172.19.33.136]) by bb-corp-ex4.corp.cubic.cub with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 12 Jul 2011 12:29:07 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <CABU6SG4=UiuM7Q1RkXxR1oJKP72Sk69Awq09+64VOra3ds5hmA@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: repository in different directories
Thread-Index: Acw/0+M9vowyN9ULQJWf4yxQ4mvSwQA9U8Yw
X-OriginalArrivalTime: 12 Jul 2011 19:29:07.0946 (UTC) FILETIME=[F7F3DCA0:01CC40C9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176972>

T24geW91ciBtYWNoaW5lIGFuZCB0aGUgc2VydmVyIG1ha2UgaGFyZCBsaW5rcyBmcm9tIHRoZSBm
b2xkZXJzIGluIHRoZSByZXBvc2l0b3J5IHRvIHRoZSBkZXN0aW5hdGlvbiBmb2xkZXJzLCB0aGF0
IHdheSB3aGVuIHlvdSBjaGVjayBvdXQgdGhlIGxhdGVzdCB2ZXJzaW9uIHRoZW4gYm90aCBsb2Nh
dGlvbnMgYXJlIHVwZGF0ZWQuDQoNClNvIGhhdmUgDQovaG9tZS9jYXJsby9kZXYucmVwby8uZ2l0
DQovaG9tZS9jYXJsby9kZXYucmVwby9wdWJsaWNfaHRtbC8gbGlua2VkIHRvIC9ob21lL2Nhcmxv
L3B1YmxpY19odG1sLw0KL2hvbWUvY2FybG8vZGV2LnJlcG8vYXBwbGljYXRpb25zLyBsaW5rZWQg
dG8gL2hvbWUvY2FybG8vY2kvYXBwbGljYXRpb24NCg0KeW91IGNhbiB0aGVuIHdvcmsgaW4gdGhl
IHNhbWUgcGxhY2UgYXMgdXN1YWwsIGJ1dCBkbyB5b3VyIGNvbW1pdHMgZnJvbSB0aGUgZGV2LnJl
cG8gZm9sZGVyLg0KDQpNeSAkMC4wMiBzb2x1dGlvbi4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IGdpdC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpnaXQtb3duZXJA
dmdlci5rZXJuZWwub3JnXSBPbiBCZWhhbGYgT2YgQ2FybG8gVHJpbWFyY2hpDQpTZW50OiBUdWVz
ZGF5LCAxMiBKdWx5IDIwMTEgMDI6MDcNClRvOiBBbGxlbiBGb2dsZXNvbg0KQ2M6IGdpdEB2Z2Vy
Lmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiByZXBvc2l0b3J5IGluIGRpZmZlcmVudCBkaXJlY3Rv
cmllcw0KDQpPbiAxMSBKdWx5IDIwMTEgMTY6MDEsIEFsbGVuIEZvZ2xlc29uIDxhZm9nbGVzb25A
Z21haWwuY29tPiB3cm90ZToNCj4gV2h5IG5vdCBqdXN0IG1ha2UgL2hvbWUvY2FybG8gdGhlIHJl
cG9zaXRvcnksIGl0IGhhcyBhbGwgdGhlIHJpZ2h0IGZvbGRlcg0KPiBzdHJ1Y3R1cmUsIHRoZW4g
ZnJvbSB0aGUgc2VydmVyIHlvdSBjYW4gcHVsbCwgb3IgeW91IGNhbiBnaXQgYXJjaGl2ZSB3aGVu
DQo+IHJlYWR5IHRvIHJlbGVhc2UgYW5kIHVuYXJjaGl2ZSBvbiB0aGUgc2VydmVyDQoNCmJlY2F1
c2UgSSdtIHdvcmtpbmcgb24gZGlmZmVyZW50IGFwcGxpY2F0aW9ucyBhbmQgSSBuZWVkIGEgcmVw
b3NpdG9yeQ0KZm9yIGVhY2ggb25lIG9mIHRoZW0NCg0KU3RldmUgTXVhZGliDQo+QWgsIGFuZCBm
b3Igd3Jvbmc6IGhvdyBhYm91dCB1c2luZyBvbmUgcmVwb3NpdG9yeSBhbmQgc2V0dGluZyB1cA0K
PmEgY29tbWl0IGhvb2sgdG8gbW92ZSBmaWxlcyB0byBmaW5hbCBwbGFjZXM/DQoNCnRoZSBjb21t
aXQgaG9vayBzaG91bGQgc3RheSBpbiB0aGUgbG9jYWwgb3IgdGhlIHJlbW90ZSBtYWNoaW5lPw0K
LS0NClRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNj
cmliZSBnaXQiIGluDQp0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2Vy
bmVsLm9yZw0KTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9t
YWpvcmRvbW8taW5mby5odG1sDQo=
