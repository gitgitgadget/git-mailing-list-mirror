From: <stefan.naewe@atlas-elektronik.com>
Subject: Fwd: Re: Git config not working correctly with included
 configurations
Date: Tue, 12 Apr 2016 13:58:20 +0200
Message-ID: <570CE2DC.90602@atlas-elektronik.com>
References: <570CE289.2000808@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 12 13:58:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apwxs-0002bo-Ds
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 13:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbcDLL6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 07:58:37 -0400
Received: from mail96.atlas.de ([194.156.172.86]:34614 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755868AbcDLL6g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 07:58:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 6E1741091B
	for <git@vger.kernel.org>; Tue, 12 Apr 2016 13:58:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XxQ8IFei4l_9 for <git@vger.kernel.org>;
	Tue, 12 Apr 2016 13:58:22 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Tue, 12 Apr 2016 13:58:22 +0200 (CEST)
Received: from MSEXSRV1.atlas.de (webmail.atlas.de [10.200.102.56])
	by mgsrv01.atlas.de (Postfix) with ESMTP id AFF8B27122
	for <git@vger.kernel.org>; Tue, 12 Apr 2016 13:58:22 +0200 (CEST)
Received: from MSSRVS1.atlas.de (10.200.101.71) by MSEXSRV1.atlas.de
 (10.200.102.56) with Microsoft SMTP Server (TLS) id 14.3.248.2; Tue, 12 Apr
 2016 13:58:21 +0200
Received: from MSSRVS4.atlas.de ([10.200.97.74]) by MSSRVS1.atlas.de
 ([10.200.101.71]) with mapi; Tue, 12 Apr 2016 13:58:22 +0200
Thread-Topic: Re: Git config not working correctly with included
 configurations
Thread-Index: AdGUspvwETnyztF2T+GOo/HH+JrZXw==
In-Reply-To: <570CE289.2000808@atlas-elektronik.com>
Accept-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
x-forwarded-message-id: <570CE289.2000808@atlas-elektronik.com>
acceptlanguage: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291256>

U29ycnksIEkgdGhvdWdodCB0aGlzIGxpc3QgaGFzICdyZXBseSB0byBhbGwnIHNldCBieSBkZWZh
dWx0Li4uDQoNClN0ZWZhbg0KDQotLS0tLS0tLSBXZWl0ZXJnZWxlaXRldGUgTmFjaHJpY2h0IC0t
LS0tLS0tDQpCZXRyZWZmOiBSZTogR2l0IGNvbmZpZyBub3Qgd29ya2luZyBjb3JyZWN0bHkgd2l0
aCBpbmNsdWRlZCBjb25maWd1cmF0aW9ucw0KRGF0dW06IFR1ZSwgMTIgQXByIDIwMTYgMTM6NTY6
NTcgKzAyMDANClZvbjogTsOkd2UsIFN0ZWZhbiA8c3RlZmFuLm5hZXdlQGF0bGFzLWVsZWt0cm9u
aWsuY29tPg0KQW46IFJ1ZGluZWkgR29pIFJvZWNrZXIgPHJ1ZGluZWlnckBpdGZsZXguY29tLmJy
Pg0KDQpBbSAxMi4wNC4yMDE2IHVtIDEzOjI1IHNjaHJpZWIgUnVkaW5laSBHb2kgUm9lY2tlcjoN
Cj4gSSdtIGhhdmluZyBhIHByb2JsZW0gd2l0aCBpbmNsdWRlZCBjb25maWd1cmF0aW9ucyBpbiB+
Ly5naXRjb25maWcsIHdoZW4NCj4gdXNpbmcgdGhpcyBjb21tYW5kOg0KPiANCj4gZ2l0IGNvbmZp
ZyAtLWdsb2JhbCB1c2VyLmVtYWlsDQo+IA0KPiBJdCBkb2Vzbid0IHJldHVybiBhbnl0aGluZywg
aW4gY29tbWl0cyBpdCB3b3JrcyBhcyBpbnRlbmRlZC4gVGhlDQo+IGNvbmZpZ3VyYXRpb24gbG9v
a3MgbGlrZSB0aGlzOg0KPiANCj4gfi8uZ2l0Y29uZmlnDQo+IFtpbmNsdWRlXQ0KPiAgICBwYXRo
ID0gLmdpdGNvbmZpZy51c2VyDQoNCk1heWJlIHlvdSB3YW50IHRvIHVzZQ0KDQogICAgIHBhdGgg
PSB+Ly5naXRjb25maWcudXNlcg0KDQpoZXJlLg0KDQo+ICMgLi4uIG1vcmUgY29uZmlndXJhdGlv
bnMNCj4gDQo+IH4vLmdpdGNvbmZpZy51c2VyDQo+IFt1c2VyXQ0KPiAgICBuYW1lID0gTXkgRnVs
bCBOYW1lDQo+ICAgIGVtYWlsID0gbXllbWFpbEBleGFtcGxlLmNvbQ0KDQpIVEgsDQogIFN0ZWZh
bg0KLS0gDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQovZGV2L3JhbmRvbSBzYXlzOiBDVVJTT1I6IFdoYXQgeW91IGJlY29t
ZSB3aGVuIHlvdXIgc3lzdGVtIGNyYXNoZXMuDQpweXRob24gLWMgInByaW50ICc3Mzc0NjU2NjYx
NmUyZTZlNjE2NTc3NjU0MDYxNzQ2YzYxNzMyZDY1NmM2NTZiNzQ3MjZmNmU2OTZiMmU2MzZmNmQn
LmRlY29kZSgnaGV4JykiIA0KR1BHIEtleSBmaW5nZXJwcmludCA9IDJERjUgRTAxQiAwOUMzIDc1
MDEgQkNBOSAgOTY2NiA4MjlCIDQ5QzUgOTIyMSAyN0FGDQoNCg==
