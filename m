From: =?utf-8?B?TcO8bGxlciAgS2lyaWxs?= <kirill.mueller@ivt.baug.ethz.ch>
Subject: Re: [PATCH v3] checkout: add --ignore-skip-worktree-bits in sparse
 checkout mode
Date: Tue, 14 May 2013 09:27:14 +0000
Message-ID: <1368523634.10814.3.camel@vpl-thinkpad10>
References: <1364637753-18785-1-git-send-email-pclouds@gmail.com>
	 <1365808328-4191-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 11:33:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcBbt-0005Z8-GO
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 11:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617Ab3ENJdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 05:33:25 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:35294 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756701Ab3ENJdY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 05:33:24 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 May 2013 05:33:24 EDT
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 May
 2013 11:27:14 +0200
Received: from MBX23.d.ethz.ch ([fe80::68b6:1e46:3e74:b8fd]) by
 CAS22.d.ethz.ch ([fe80::dd0e:466a:b055:c090%10]) with mapi id 14.02.0298.004;
 Tue, 14 May 2013 11:27:14 +0200
Thread-Topic: [PATCH v3] checkout: add --ignore-skip-worktree-bits in sparse
 checkout mode
Thread-Index: AQHON9M15iX6Vr0zC0uBsaYOgNfAR5kEeUIA
In-Reply-To: <1365808328-4191-1-git-send-email-pclouds@gmail.com>
Accept-Language: de-DE, de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [129.132.96.98]
Content-ID: <76489AAE7DE2DB40B4B7FE797DD8B30F@intern.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224296>

VGhhbmsgeW91LCB0aGlzIGxvb2tzIG5pY2UuIFdoYXQgbmVlZHMgdG8gYmUgZG9uZSB0aGF0IHRo
aXMgd2lsbA0KZXZlbnR1YWxseSByZWFjaCB0aGUgZ2l0IGluIG15IGZhdm9yaXRlIGRpc3RyaWJ1
dGlvbj8gV2hpY2ggdmVyc2lvbiBvZg0KR2l0IHdpbGwgdGhpcyBiZT8NCg0KDQpDaGVlcnMNCg0K
S2lyaWxsDQoNCg0KT24gU2F0LCAyMDEzLTA0LTEzIGF0IDA5OjEyICsxMDAwLCBOZ3V54buFbiBU
aMOhaSBOZ+G7jWMgRHV5IHdyb3RlOg0KPiAiZ2l0IGNoZWNrb3V0IC0tIDxwYXRocz4iIGlzIHVz
dWFsbHkgdXNlZCB0byByZXN0b3JlIGFsbCBtb2RpZmllZA0KPiBmaWxlcyBpbiA8cGF0aHM+LiBJ
biBzcGFyc2UgY2hlY2tvdXQgbW9kZSwgdGhpcyBjb21tYW5kIGlzIG92ZXJsb2FkZWQNCj4gd2l0
aCBhbm90aGVyIG1lYW5pbmc6IHRvIGFkZCBiYWNrIGFsbCBmaWxlcyBpbiA8cGF0aHM+IHRoYXQg
YXJlDQo+IGV4Y2x1ZGVkIGJ5IHNwYXJzZSBwYXR0ZXJucy4NCj4gDQo+IEFzIHRoZSBmb3JtZXIg
bWFrZXMgbW9yZSBzZW5zZSBmb3IgZGF5LXRvLWRheSB1c2UuIFN3aXRjaCBpdCB0byB0aGUNCj4g
ZGVmYXVsdCBhbmQgdGhlIGxhdHRlciBlbmFibGVkIHdpdGggLS1pZ25vcmUtc2tpcC13b3JrdHJl
ZS1iaXRzLg0KDQo=
