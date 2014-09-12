From: "Rom Walton" <romw-egxtZiWXYP1AfugRpC6u6w@public.gmane.org>
Subject: Re: (local ?) BOINC repo broken again -or- how to act
	on the CR/LF changes made upstream
Date: Fri, 12 Sep 2014 15:10:06 -0400
Message-ID: <1BAFA9B4D550C347962F76F2E03B3BBB22C5FB@romw-mail.romwnet.org>
References: <541336D6.3050803@gmx.de>
	<1BAFA9B4D550C347962F76F2E03B3BBB22C5F9@romw-mail.romwnet.org>
	<54133C3A.4080700@gmx.de>
	<1BAFA9B4D550C347962F76F2E03B3BBB22C5FA@romw-mail.romwnet.org>
	<541343BC.1050503@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
To: =?utf-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster-Mmb7MZpHnFY@public.gmane.org>,
	<git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org Fri Sep 12 21:10:17 2014
Return-path: <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
Envelope-to: gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from mailapps1.ssl.berkeley.edu ([128.32.13.237])
	by plane.gmane.org with smtp (Exim 4.69)
	(envelope-from <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>)
	id 1XSWEX-0006za-8t
	for gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Fri, 12 Sep 2014 21:10:13 +0200
Received: from mailapps1.ssl.berkeley.edu (localhost [127.0.0.1])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id 4A1552FEA63;
	Fri, 12 Sep 2014 12:10:11 -0700 (PDT)
X-Original-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Delivered-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Received: from mail2.ssl.berkeley.edu (mail2.ssl.berkeley.edu [128.32.13.252])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id 5C87B2FEA4D
	for <boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org>;
	Fri, 12 Sep 2014 12:10:09 -0700 (PDT)
Received: from mailwall2.ssl.berkeley.edu (mailwall2.ssl.berkeley.edu
	[128.32.147.8])
	by mail2.ssl.berkeley.edu (8.13.8/8.13.8) with ESMTP id s8CJA90D001016
	for <boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>; Fri, 12 Sep 2014 12:10:09 -0700
X-ASG-Debug-ID: 1410549008-04b397145f29ee60001-LQ66t1
Received: from mho-01-ewr.mailhop.org (mho-03-ewr.mailhop.org [204.13.248.66])
	by mailwall2.ssl.berkeley.edu with ESMTP id 3x7dYsAj2NnEZmhR
	for <boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>;
	Fri, 12 Sep 2014 12:10:08 -0700 (PDT)
X-Barracuda-Envelope-From: romw-egxtZiWXYP1AfugRpC6u6w@public.gmane.org
X-Barracuda-Apparent-Source-IP: 204.13.248.66
Received: from 173-160-3-53-naples.hfc.comcastbusiness.net ([173.160.3.53]
	helo=mail.romwnet.org)
	by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.72) (envelope-from <romw-egxtZiWXYP1AfugRpC6u6w@public.gmane.org>)
	id 1XSWES-000H1S-C0; Fri, 12 Sep 2014 19:10:08 +0000
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 173.160.3.53
X-Report-Abuse-To: abuse-yJRlmlznMY/QT0dZR+AlfA@public.gmane.org (see
	http://www.dyndns.com/services/sendlabs/outbound_abuse.html for
	abuse reporting information)
X-MHO-User: U2FsdGVkX19SU3VpUbIelxKVH4+0KyKofl/pb9F7AqI=
X-ASG-Orig-Subj: RE: [boinc_dev] (local ?) BOINC repo broken again -or- how to
	act on the CR/LF changes made upstream
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [boinc_dev] (local ?) BOINC repo broken again -or- how to act on
	the CR/LF changes made upstream
Thread-Index: Ac/OvHi5Itf20a+aT5StoZ0yKcUUogAAKVJg
X-Barracuda-Connect: mho-03-ewr.mailhop.org[204.13.248.66]
X-Barracuda-Start-Time: 1410549008
X-Barracuda-URL: http://mailwall2.ssl.berkeley.edu:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ssl.berkeley.edu
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score-Disabled: per user
X-BeenThere: boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: BOINC development <boinc_dev.ssl.berkeley.edu>
List-Unsubscribe: <http://lists.ssl.berkeley.edu/mailman/options/boinc_dev>,
	<mailto:boinc_dev-request-C9EgComYM8RUAgJt6FLh2g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ssl.berkeley.edu/pipermail/boinc_dev/>
List-Post: <mailto:boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
List-Help: <mailto:boinc_dev-request-C9EgComYM8RUAgJt6FLh2g@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ssl.berkeley.edu/mailman/listinfo/boinc_dev>,
	<mailto:boinc_dev-request-C9EgComYM8RUAgJt6FLh2g@public.gmane.org?subject=subscribe>
Errors-To: boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
Sender: "boinc_dev" <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256944>

SSBmb3VuZCB0aGlzOg0KaHR0cDovL3N0YWNrb3ZlcmZsb3cuY29tL3F1ZXN0aW9ucy8xNzIyMzUy
Ny9ob3ctZG8taS1mb3JjZS1naXQtdG8tY2hlY2tvdXQtdGhlLW1hc3Rlci1icmFuY2gtYW5kLXJl
bW92ZS1jYXJyaWFnZS1yZXR1cm5zLWFmdA0KDQpUaGF0IG1pZ2h0IGhlbHAgaW4gdGhlIGZ1dHVy
ZS4NCg0KLS0tLS0gUm9tDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBUb3Jh
bGYgRsO2cnN0ZXIgW21haWx0bzp0b3JhbGYuZm9lcnN0ZXJAZ214LmRlXSANClNlbnQ6IEZyaWRh
eSwgU2VwdGVtYmVyIDEyLCAyMDE0IDM6MDQgUE0NClRvOiBSb20gV2FsdG9uOyBnaXRAdmdlci5r
ZXJuZWwub3JnDQpDYzogYm9pbmNfZGV2QHNzbC5iZXJrZWxleS5lZHUNClN1YmplY3Q6IFJlOiBb
Ym9pbmNfZGV2XSAobG9jYWwgPykgQk9JTkMgcmVwbyBicm9rZW4gYWdhaW4gLW9yLSBob3cgdG8g
YWN0IG9uIHRoZSBDUi9MRiBjaGFuZ2VzIG1hZGUgdXBzdHJlYW0NCg0KT24gMDkvMTIvMjAxNCAw
ODo1NSBQTSwgUm9tIFdhbHRvbiB3cm90ZToNCj4gQ3J1ZC4uLg0KPiANCj4gV2VsbCwgcGVyc29u
YWxseSwgSSB3b3VsZCBkZWxldGUgdGhlIGxvY2FsZSBkaXJlY3RvcnkgYW5kIHRoZSB0d28gdHJh
bnNsYXRpb24gZmlsZXMgaW4gaHRtbC4NCj4gDQo+IERvIHRoZSAnZ2l0IHB1bGwnLCBhbmQgdGhl
biBzd2l0Y2ggYmV0d2VlbiBtYXN0ZXIgYW5kIHNvbWUgb3RoZXIgYnJhbmNoLg0KPiANCj4gbGlr
ZToNCj4gZ2l0IGNoZWNrb3V0IC1mIGNsaWVudF9yZWxlYXNlLzcvNy40DQo+IGdpdCBjaGVja291
dCAtZiBtYXN0ZXINCj4gDQo+IEl0IGlzIHJvdW5kIGFib3V0LCBidXQgaXQgc2hvdWxkIGdldCB0
aGUgam9iIGRvbmUuDQoNClJlLWNsb25pbmcgc2VlbXMgdG8gYmUgdGhlIG9ubHkgd2F5LCBiL2Mg
Og0KDQp0Zm9lcnN0ZUBuMjIgfi9kZXZlbC9ib2luYy12MiAkIGdpdCBjaGVja291dCAtZiBjbGll
bnRfcmVsZWFzZS83LzcuNCBCcmFuY2ggY2xpZW50X3JlbGVhc2UvNy83LjQgc2V0IHVwIHRvIHRy
YWNrIHJlbW90ZSBicmFuY2ggY2xpZW50X3JlbGVhc2UvNy83LjQgZnJvbSBvcmlnaW4uDQpTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ2NsaWVudF9yZWxlYXNlLzcvNy40Jw0KDQp0Zm9lcnN0ZUBu
MjIgfi9kZXZlbC9ib2luYy12MiAkIGdpdCBjaGVja291dCAtZiBtYXN0ZXIgQ2hlY2tpbmcgb3V0
IGZpbGVzOiAxMDAlICgyMzQvMjM0KSwgZG9uZS4NClN3aXRjaGVkIHRvIGJyYW5jaCAnbWFzdGVy
Jw0KWW91ciBicmFuY2ggaXMgYmVoaW5kICdvcmlnaW4vbWFzdGVyJyBieSA3IGNvbW1pdHMsIGFu
ZCBjYW4gYmUgZmFzdC1mb3J3YXJkZWQuDQogICh1c2UgImdpdCBwdWxsIiB0byB1cGRhdGUgeW91
ciBsb2NhbCBicmFuY2gpDQoNCnRmb2Vyc3RlQG4yMiB+L2RldmVsL2JvaW5jLXYyICQgZ2l0IHB1
bGwgVXBkYXRpbmcgY2U5N2U4NS4uZDJlNTU4Mg0KZXJyb3I6IFlvdXIgbG9jYWwgY2hhbmdlcyB0
byB0aGUgZm9sbG93aW5nIGZpbGVzIHdvdWxkIGJlIG92ZXJ3cml0dGVuIGJ5IG1lcmdlOg0KLi4u
DQo8c2FtZSBwaWN0dXJlIGFzIGJlZm9yZT4NCg0KLS0NClRvcmFsZg0KcGdwIGtleTogMDA3NiBF
OTRFDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmJv
aW5jX2RldiBtYWlsaW5nIGxpc3QKYm9pbmNfZGV2QHNzbC5iZXJrZWxleS5lZHUKaHR0cDovL2xp
c3RzLnNzbC5iZXJrZWxleS5lZHUvbWFpbG1hbi9saXN0aW5mby9ib2luY19kZXYKVG8gdW5zdWJz
Y3JpYmUsIHZpc2l0IHRoZSBhYm92ZSBVUkwgYW5kCihuZWFyIGJvdHRvbSBvZiBwYWdlKSBlbnRl
ciB5b3VyIGVtYWlsIGFkZHJlc3Mu
