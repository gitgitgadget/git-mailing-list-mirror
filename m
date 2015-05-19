From: "McHenry, Matt" <mmchenry@carnegielearning.com>
Subject: RE: recovering from "unordered stage entries in index" error
Date: Tue, 19 May 2015 12:51:14 -0400
Message-ID: <D377A9280DB18546A2471214D5CBB0E90859942B54@exchdb01>
References: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
 <CAPc5daUtrfWrVeKMdF5sAA5pt5owkyqoZ-b=BoO=Oms0rYF1ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 18:51:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yukjh-0000d7-1G
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 18:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbbESQvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 12:51:16 -0400
Received: from mail3.carnegielearning.com ([204.80.87.3]:21360 "EHLO
	mail3.carnegielearning.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325AbbESQvP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2015 12:51:15 -0400
X-ASG-Debug-ID: 1432054274-0424f512db3c73160001-QuoKaX
Received: from webmail.carnegielearning.com ([10.1.10.4]) by mail3.carnegielearning.com with ESMTP id 2wVI6FV75BjRXUQD (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Tue, 19 May 2015 12:51:14 -0400 (EDT)
X-Barracuda-Envelope-From: mmchenry@carnegielearning.com
X-Barracuda-RBL-Trusted-Forwarder: 10.1.10.4
Received: from exchdb01.carnegielearning.com ([127.0.0.1]) by exchdb01
 ([127.0.0.1]) with mapi; Tue, 19 May 2015 12:51:14 -0400
Thread-Topic: recovering from "unordered stage entries in index" error
X-ASG-Orig-Subj: RE: recovering from "unordered stage entries in index" error
Thread-Index: AdCSR0jWQhUM+zLYSxObYCj9A6Kk5QADDctw
In-Reply-To: <CAPc5daUtrfWrVeKMdF5sAA5pt5owkyqoZ-b=BoO=Oms0rYF1ag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
x-exclaimer-md-config: 4a2a7f2a-5ce0-45d8-a978-59e527d0c9d2
X-Barracuda-Connect: UNKNOWN[10.1.10.4]
X-Barracuda-Start-Time: 1432054274
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: https://10.1.10.29:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at carnegielearning.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0000
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_SA620b, MAILTO_TO_SPAM_ADDR
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.19094
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.00 MAILTO_TO_SPAM_ADDR    URI: Includes a link to a likely spammer email
	0.50 BSF_SC0_SA620b         Custom Rule SA620b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269372>

DQoJSSBoYWQgbmV2ZXIgaGVhcmQgb2YgdGhhdC4gIEdvb2dsZSBsZWQgbWUgdG8gdGhlIG1hbiBw
YWdlIGZvciAnZ2l0IHVwZGF0ZS1pbmRleCAtLXNwbGl0LWluZGV4JywgYW5kIGFmdGVyIHJlYWRp
bmcgaXQsIEkgdGhpbmsgdGhpcyBkZW1vbnN0cmF0ZXMgdGhhdCBJJ20gbm90IHVzaW5nIHRoYXQg
ZmVhdHVyZToNCg0KJCBscyAuZ2l0LyppbmRleCoNCi5naXQvaW5kZXgNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBqY2gyMzU1QGdtYWlsLmNvbSBbbWFpbHRvOmpjaDIz
NTVAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgSnVuaW8gQw0KPiBIYW1hbm8NCj4gU2VudDogVHVl
c2RheSwgTWF5IDE5LCAyMDE1IDExOjIwDQo+IFRvOiBNY0hlbnJ5LCBNYXR0DQo+IENjOiBnaXRA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiByZWNvdmVyaW5nIGZyb20gInVub3JkZXJl
ZCBzdGFnZSBlbnRyaWVzIGluIGluZGV4IiBlcnJvcg0KPiANCj4gT24gVHVlLCBNYXkgMTksIDIw
MTUgYXQgNjo0OCBBTSwgTWNIZW5yeSwgTWF0dA0KPiA8bW1jaGVucnlAY2FybmVnaWVsZWFybmlu
Zy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gICAgICAgICBJJ3ZlIGp1c3QgdXBncmFkZWQgbXkgZ2l0
IGZyb20gMi4wLjUgdG8gMi4zLjYsIGFuZCBJJ20gbm93DQo+IHVuYWJsZSB0byBydW4gJ2dpdCBz
dm4gZmV0Y2gnIGluIG9uZSBvZiBteSByZXBvc2l0b3JpZXM6DQo+ID4NCj4gPiAkIGdpdCBzdm4g
ZmV0Y2gNCj4gPiBmYXRhbDogdW5vcmRlcmVkIHN0YWdlIGVudHJpZXMgaW4gaW5kZXgNCj4gPiB3
cml0ZS10cmVlOiBjb21tYW5kIHJldHVybmVkIGVycm9yOiAxMjgNCj4gDQo+IEFyZSB5b3UgYnkg
YW55IGNoYW5jZSB1c2luZyB0aGUgc3BsaXQtaW5kZXggbW9kZSAod2hpY2ggSSB0aGluayBpcw0K
PiBicm9rZW4gaW4gMi4zLjYpPw0K
