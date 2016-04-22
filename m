From: <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Fri, 22 Apr 2016 12:45:24 +0200
Message-ID: <3b57e4f4-afba-bb94-2c59-a9ff5765748d@atlas-elektronik.com>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <gitster@pobox.com>
To: <larsxschneider@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 12:45:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atYan-00010e-4l
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 12:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbcDVKpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 06:45:40 -0400
Received: from mail96.atlas.de ([194.156.172.86]:25554 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbcDVKpj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 06:45:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id A77CE10196;
	Fri, 22 Apr 2016 12:45:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HKKlxH8nf2po; Fri, 22 Apr 2016 12:45:26 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Fri, 22 Apr 2016 12:45:25 +0200 (CEST)
Received: from MSEXSRV1.atlas.de (webmail-seb.atlas.de [10.200.102.56])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 9FC6227123;
	Fri, 22 Apr 2016 12:45:25 +0200 (CEST)
Received: from MSSRVS3.atlas.de (10.200.101.73) by MSEXSRV1.atlas.de
 (10.200.102.56) with Microsoft SMTP Server (TLS) id 14.3.248.2; Fri, 22 Apr
 2016 12:45:24 +0200
Received: from MSSRVS4.atlas.de ([10.200.97.74]) by MSSRVS3.atlas.de
 ([10.200.101.73]) with mapi; Fri, 22 Apr 2016 12:45:25 +0200
Thread-Topic: [PATCH v1] travis-ci: build documentation
Thread-Index: AdGchBMymIcrEkIJQBKCciGYVjnIgw==
In-Reply-To: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
Accept-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
acceptlanguage: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292183>

QW0gMjIuMDQuMjAxNiB1bSAxMDozNCBzY2hyaWViIGxhcnN4c2NobmVpZGVyQGdtYWlsLmNvbToN
Cj4gRnJvbTogTGFycyBTY2huZWlkZXIgPGxhcnN4c2NobmVpZGVyQGdtYWlsLmNvbT4NCj4gDQo+
IFJ1biAibWFrZSBkb2MiIHRvIGNoZWNrIGlmIGFsbCBkb2N1bWVudGF0aW9uIGNhbiBiZSBidWls
ZCB3aXRob3V0IGVycm9ycy4NCg0Kcy9idWlsZC9idWlsdC8NCg0KDQo+IFNpbmNlIHRoZSBkb2N1
bWVudGF0aW9uIGlzIHRoZSBzYW1lIG9uIGV2ZXJ5IHBsYXRmb3JtL2NvbXBpbGVyLCB0aGUgY2hl
Y2sNCj4gaXMgb25seSBwZXJmb3JtZWQgYXMgcGFydCBvZiB0aGUgTGludXgvR0NDIGJ1aWxkIGpv
YiB0byBtYWludGFpbiBhIGZhc3QNCj4gQ0kgcHJvY2Vzcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IExhcnMgU2NobmVpZGVyIDxsYXJzeHNjaG5laWRlckBnbWFpbC5jb20+DQo+IC0tLQ0KPiANCj4g
UGF0Y2ggYXMgcHJvbWlzZWQgaW4gaHR0cDovL2FydGljbGUuZ21hbmUub3JnL2dtYW5lLmNvbXAu
dmVyc2lvbi1jb250cm9sLmdpdC8yOTE3MjYNCj4gDQo+IENoZWVycywNCj4gTGFycw0KPiANCj4g
IC50cmF2aXMueW1sIHwgMTMgKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS8udHJhdmlzLnlt
bCBiLy50cmF2aXMueW1sDQo+IGluZGV4IGMzYmY5YzYuLjZjYTdmYjIgMTAwNjQ0DQo+IC0tLSBh
Ly50cmF2aXMueW1sDQo+ICsrKyBiLy50cmF2aXMueW1sDQo+IEBAIC0xMiw2ICsxMiw4IEBAIGFk
ZG9uczoNCj4gICAgYXB0Og0KPiAgICAgIHBhY2thZ2VzOg0KPiAgICAgIC0gbGFuZ3VhZ2UtcGFj
ay1pcw0KPiArICAgIC0gYXNjaWlkb2MNCj4gKyAgICAtIHhtbHRvDQo+IA0KPiAgZW52Og0KPiAg
ICBnbG9iYWw6DQo+IEBAIC03MCw3ICs3MiwxNiBAQCBiZWZvcmVfaW5zdGFsbDoNCj4gDQo+ICBi
ZWZvcmVfc2NyaXB0OiBtYWtlIC0tam9icz0yDQo+IA0KPiAtc2NyaXB0OiBtYWtlIC0tcXVpZXQg
dGVzdA0KPiArc2NyaXB0Og0KPiArICAtID4NCj4gKyAgICAgIG1ha2UgLS1xdWlldCB0ZXN0ICYm
DQo+ICsgICAgICBpZiBbWyAiJFRSQVZJU19PU19OQU1FIiA9IGxpbnV4IF1dICYmIFtbICIkQ0Mi
ID0gZ2NjIF1dOw0KPiArICAgICAgICAgIHRoZW4NCj4gKyAgICAgICAgICBlY2hvICIiDQo+ICsg
ICAgICAgICAgZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIiAmJg0KPiArICAgICAgICAgIGVjaG8gIiQo
dHB1dCBzZXRhZiAyKUJ1aWxkaW5nIGRvY3VtZW50YXRpb24uLi4kKHRwdXQgc2dyMCkiICYmDQo+
ICsgICAgICAgICAgbWFrZSAtLXF1aWV0IGRvYw0KPiArICAgICAgZmk7DQo+IA0KPiAgYWZ0ZXJf
ZmFpbHVyZToNCj4gICAgLSA+DQoNClN0ZWZhbg0KLS0gDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQovZGV2L3JhbmRvbSBz
YXlzOiBUaGUgY2F0IHRoYXQgYXRlIHRoZSBiYWxsIG9mIHlhcm4uLi4uaGFkIG1pdHRlbnMhDQpw
eXRob24gLWMgInByaW50ICc3Mzc0NjU2NjYxNmUyZTZlNjE2NTc3NjU0MDYxNzQ2YzYxNzMyZDY1
NmM2NTZiNzQ3MjZmNmU2OTZiMmU2MzZmNmQnLmRlY29kZSgnaGV4JykiIA0KR1BHIEtleSBmaW5n
ZXJwcmludCA9IDJERjUgRTAxQiAwOUMzIDc1MDEgQkNBOSAgOTY2NiA4MjlCIDQ5QzUgOTIyMSAy
N0FGDQo=
