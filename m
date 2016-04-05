From: <stefan.naewe@atlas-elektronik.com>
Subject: Re: support block comments in gitconfig
Date: Tue, 5 Apr 2016 14:53:52 +0200
Message-ID: <5703B560.8070902@atlas-elektronik.com>
References: <CANri+ExqdM-TTibWK07B2VFns6fQ09fmbqbCKC1VWET1tgRFNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: <timothee.cour2@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 14:55:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anQVo-0001ko-Uh
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 14:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758679AbcDEMzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 08:55:10 -0400
Received: from mail96.atlas.de ([194.156.172.86]:25707 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752AbcDEMym (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 08:54:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id DDD64108CD;
	Tue,  5 Apr 2016 14:54:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RMnixuugvRpi; Tue,  5 Apr 2016 14:54:29 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Tue,  5 Apr 2016 14:54:29 +0200 (CEST)
Received: from MSEXSRV3.atlas.de (msexsrv3.atlas.de [10.200.102.58])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 41BD927122;
	Tue,  5 Apr 2016 14:54:29 +0200 (CEST)
Received: from MSSRVS1.atlas.de (10.200.101.71) by MSEXSRV3.atlas.de
 (10.200.102.58) with Microsoft SMTP Server (TLS) id 14.3.248.2; Tue, 5 Apr
 2016 14:54:18 +0200
Received: from MSSRVS4.atlas.de ([10.200.97.74]) by MSSRVS1.atlas.de
 ([10.200.101.71]) with mapi; Tue, 5 Apr 2016 14:53:53 +0200
Thread-Topic: support block comments in gitconfig
Thread-Index: AdGPOjTNu/bnYb+SQJS77N3BAmOQ3w==
In-Reply-To: <CANri+ExqdM-TTibWK07B2VFns6fQ09fmbqbCKC1VWET1tgRFNA@mail.gmail.com>
Accept-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
acceptlanguage: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290779>

QW0gMDUuMDQuMjAxNiB1bSAwNDoxOSBzY2hyaWViIFRpbW90aGVlIENvdXI6DQo+IENvdWxkIHdl
IGhhdmUgYmxvY2sgY29tbWVudHMgaW4gZ2l0Y29uZmlnPw0KPiBJdCdzIGEgbmljZS10by1oYXZl
IHN1cHBvcnRlZCBpbiBtb3N0IGxhbmd1YWdlcy4NCj4gZWc6DQo+IA0KPiAjew0KPiBjb21tZW50
ZWQgb3V0IGJsb2NrDQo+ICN9DQo+IA0KPiBvciBvdGhlciBpbnR1aXRpdmUgc3ludGF4DQoNCk1h
eWJlIG5vdCB3aGF0IHlvdSdyZSBsb29raW5nIGZvciwgYnV0IGNvdWxkbid0IHlvdSB1c2UNCnRo
ZSBpbmNsdWRlIGZ1bmN0aW9uYWxpdHkgb2YgZ2l0Y29uZmlnOg0KDQpbaW5jbHVkZV0NCiAgcGF0
aCA9IH4vLmFub3RoZXIuZ2l0Y29uZmlnDQoNCj8/DQoNClRoYXQgd2F5IHlvdSBjYW4gY29tbWVu
dCBvdXQgYSBsb3Qgb2YgY29uZmlndXJhdGlvbiB3aXRoIG9uZSAnIycuDQoNCkp1c3QgbXkg4oKs
MC4wMg0KDQpTdGVmYW4NCi0tIA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KL2Rldi9yYW5kb20gc2F5czogQWlyIGNvbmRp
dGlvbmVkIGVudmlyb25tZW50IC0gRG8gbm90IG9wZW4gV2luZG93cy4NCnB5dGhvbiAtYyAicHJp
bnQgJzczNzQ2NTY2NjE2ZTJlNmU2MTY1Nzc2NTQwNjE3NDZjNjE3MzJkNjU2YzY1NmI3NDcyNmY2
ZTY5NmIyZTYzNmY2ZCcuZGVjb2RlKCdoZXgnKSIgDQpHUEcgS2V5IGZpbmdlcnByaW50ID0gMkRG
NSBFMDFCIDA5QzMgNzUwMSBCQ0E5ICA5NjY2IDgyOUIgNDlDNSA5MjIxIDI3QUYNCg==
