From: "Schulze, Stefan" <Stefan.Schulze@ckc.de>
Subject: AW: Moving commits from one branch to another
Date: Wed, 23 Jan 2013 16:44:00 +0100
Message-ID: <1897BAB9F1563C4BBBF69D9E554ECAA50A45C40559@horus>
References: <000a01cdf961$bcf773d0$36e65b70$@de>
 <20130123121203.GM7498@serenity.lan> <000b01cdf973$cc685fc0$65391f40$@de>
 <20130123144941.GO7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 16:44:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty2Uz-0001In-3m
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 16:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab3AWPoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 10:44:02 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:61337 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab3AWPoA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 10:44:00 -0500
Received: from mailgate1.ckc.de ([62.154.226.26])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0Mf6wH-1UMbeI3Ziz-00OXmW; Wed, 23 Jan 2013 16:43:59 +0100
Received: by mailgate1.ckc.de (Postfix, from userid 1001)
	id DFD17542D3; Wed, 23 Jan 2013 16:43:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailgate1.ckc.de (Postfix) with ESMTP id C5C52542D2
	for <git@vger.kernel.org>; Wed, 23 Jan 2013 16:43:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ckc.de
Received: from mailgate1.ckc.de ([127.0.0.1])
	by localhost (mailgate1.ckc.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pML1zddbZaem for <git@vger.kernel.org>;
	Wed, 23 Jan 2013 16:43:58 +0100 (CET)
Received: from horus.ckc.de (horus.ckc.de [192.168.10.8])
	by mailgate1.ckc.de (Postfix) with ESMTP id AF7A4542CE
	for <git@vger.kernel.org>; Wed, 23 Jan 2013 16:43:58 +0100 (CET)
Received: from horus.ckc.de ([127.0.0.1]) by horus ([127.0.0.1]) with mapi;
 Wed, 23 Jan 2013 16:43:59 +0100
Thread-Topic: Moving commits from one branch to another
Thread-Index: Ac35eOgig4Se+VJ6SLKVwld4NZZR7gAB1sjg
In-Reply-To: <20130123144941.GO7498@serenity.lan>
Accept-Language: de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: de-DE
X-Provags-ID: V02:K0:o5XleMt/luk48RrT823oDRAtAGKxbd8BemEwRWv8Nh5
 Lufk9jPX8DGG3CjkXT4GZ8Hqg9l6s63xzt1ixBr/XdCujDUPUX
 ZqWPTkm4xp6VwCXJXHwLy+0QEVnJ8S91RKQpCDamV9biDqc43I
 3UpzYtKLVaJsJphNUnLqdQEWKGseivX+Tph7JOVZ5apKCf7cng
 rVhE+GPHq8np+GNkaPBFAH9YfNYPjRX+SqayDYJn+6ZqEhAfs1
 XxTfoj/OhN8kSFy5l9UmZc0cJDzvf50OKgOwVuNvFg19u0m+eM
 LIT+aMFkf/5SkYqJE0kqdfiSVAbTQKLfP/3IE+ujzWTsphtTTI
 bXbU13VMpQpUKo7UTdWSeuoJUGWCAQSAwk8fS3Lw2J3UWVU58j
 TKQrw1qSkK7GA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214329>

PiBnaXQgcmViYXNlIC0tb250byBzdm5icmFuY2ggcHVibGlzaGVkVG9Tdm4gbWFzdGVyXjANCj4g
Z2l0IGNoZWNrb3V0IC1CIHN2bmJyYW5jaCBIRUFEDQoNCkdyZWF0ISBUaGlzIGRvZXMgZXhhY3Rs
eSB3aGF0IEkgd2FudCENCg0KVGhhbmtzIGZvciB5b3VyIHN1cHBvcnQsDQogIFN0ZWZhbiBTY2h1
bHplDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpja2MgYWcNClNpdHo6DQpBbSBBbHRl
biBCYWhuaG9mIDEzDQozODEyMiBCcmF1bnNjaHdlaWcNCg0KVGVsZWZvbiArNDkgKDApNTMxIC8g
ODAgMTEwIDANClRlbGVmYXggKzQ5ICgwKTUzMSAvIDgwIDExMCAxODQ0NA0KaHR0cDovL3d3dy5j
a2MtZ3JvdXAuZGUNCg0KQW10c2dlcmljaHQgQnJhdW5zY2h3ZWlnDQpIUkIgNTQwNQ0KDQpWb3Jz
dGFuZDoNCkguLUcuIENocmlzdGlhbiBLcmVudGVsDQooVm9yc2l0emVuZGVyKQ0KS2Fyc3RlbiBL
aXNzZXINCg0KQXVmc2ljaHRzcmF0Og0KRHIuIEhlaW56LVdlcm5lciBXZWlucmljaA0KKFZvcnNp
dHplbmRlcikNCkplbnMgRm9rdWhsDQooc3RlbGx2LiBWb3JzaXR6ZW5kZXIpDQpQcm9mLiBEci4g
UmVpbmhvbGQgSGF1eA0KQ8Okc2FyIEphd29yc2tpDQpEci4gUml0YSBTY2h1bHoNClRob3JzdGVu
IFNwb25ob2x6DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
