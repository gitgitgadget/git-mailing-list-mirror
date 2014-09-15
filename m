From: "Rom Walton" <romw-egxtZiWXYP1AfugRpC6u6w@public.gmane.org>
Subject: Re: (local ?) BOINC repo broken again -or- how to act
	on the CR/LF changes made upstream
Date: Mon, 15 Sep 2014 17:51:13 -0400
Message-ID: <1BAFA9B4D550C347962F76F2E03B3BBB22C5FE@romw-mail.romwnet.org>
References: <541336D6.3050803@gmx.de>
	<1BAFA9B4D550C347962F76F2E03B3BBB22C5F9@romw-mail.romwnet.org>
	<54155708.7090508@web.de> <54155A1D.8040504@gmx.de>
	<54157AA6.7000801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
To: =?utf-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi-S0/GAf8tV78@public.gmane.org>,
	=?utf-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster-Mmb7MZpHnFY@public.gmane.org>,
	<git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org Mon Sep 15 23:51:23 2014
Return-path: <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
Envelope-to: gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from mailapps1.ssl.berkeley.edu ([128.32.13.237])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>)
	id 1XTeB7-0001IX-88
	for gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Mon, 15 Sep 2014 23:51:21 +0200
Received: from mailapps1.ssl.berkeley.edu (localhost [127.0.0.1])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id 321662FEC54;
	Mon, 15 Sep 2014 14:51:19 -0700 (PDT)
X-Original-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Delivered-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Received: from mail2.ssl.berkeley.edu (mail2.ssl.berkeley.edu [128.32.13.252])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id 173282FEC19
	for <boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org>;
	Mon, 15 Sep 2014 14:51:17 -0700 (PDT)
Received: from mailwall2.ssl.berkeley.edu (mailwall2.ssl.berkeley.edu
	[128.32.147.8])
	by mail2.ssl.berkeley.edu (8.13.8/8.13.8) with ESMTP id s8FLpH9Y001051
	for <boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>; Mon, 15 Sep 2014 14:51:17 -0700
X-ASG-Debug-ID: 1410817876-04b39714612e9830001-LQ66t1
Received: from mho-01-ewr.mailhop.org (mho-03-ewr.mailhop.org [204.13.248.66])
	by mailwall2.ssl.berkeley.edu with ESMTP id aMwVHEC9SGG9OznZ
	for <boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>;
	Mon, 15 Sep 2014 14:51:16 -0700 (PDT)
X-Barracuda-Envelope-From: romw-egxtZiWXYP1AfugRpC6u6w@public.gmane.org
X-Barracuda-Apparent-Source-IP: 204.13.248.66
Received: from 173-160-3-53-naples.hfc.comcastbusiness.net ([173.160.3.53]
	helo=mail.romwnet.org)
	by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.72) (envelope-from <romw-egxtZiWXYP1AfugRpC6u6w@public.gmane.org>)
	id 1XTeB2-000NXu-4R; Mon, 15 Sep 2014 21:51:16 +0000
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 173.160.3.53
X-Report-Abuse-To: abuse-yJRlmlznMY/QT0dZR+AlfA@public.gmane.org (see
	http://www.dyndns.com/services/sendlabs/outbound_abuse.html for
	abuse reporting information)
X-MHO-User: U2FsdGVkX1/Otb3QbwG6TcNabc7tTOe35h7y9r4u14I=
X-ASG-Orig-Subj: RE: [boinc_dev] (local ?) BOINC repo broken again -or- how to
	act on the CR/LF changes made upstream
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [boinc_dev] (local ?) BOINC repo broken again -or- how to act on
	the CR/LF changes made upstream
Thread-Index: Ac/QDlIjEIwguiDcTemaA6li43KW0wBILBXw
X-Barracuda-Connect: mho-03-ewr.mailhop.org[204.13.248.66]
X-Barracuda-Start-Time: 1410817876
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257084>

T3VyIHNlcnZlciBydW5zIGFuIG9sZGVyIHZlcnNpb24gb2YgZ2l0Lg0KDQoxLjcuMQ0KDQpXZSBh
cmUgaW4gdGhlIHByb2Nlc3Mgb2YgbWlncmF0aW5nIHRvIGEgbmV3IHNlcnZlciB3aGljaCBydW5z
IGEgbW9yZSB1cC10by1kYXRlIGRpc3Ryby4NCg0KLS0tLS0gUm9tDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBUb3JzdGVuIELDtmdlcnNoYXVzZW4gW21haWx0bzp0Ym9lZ2lA
d2ViLmRlXSANClNlbnQ6IFN1bmRheSwgU2VwdGVtYmVyIDE0LCAyMDE0IDc6MjMgQU0NClRvOiBU
b3JhbGYgRsO2cnN0ZXI7IFRvcnN0ZW4gQsO2Z2Vyc2hhdXNlbjsgUm9tIFdhbHRvbjsgZ2l0QHZn
ZXIua2VybmVsLm9yZw0KQ2M6IGJvaW5jX2RldkBzc2wuYmVya2VsZXkuZWR1DQpTdWJqZWN0OiBS
ZTogW2JvaW5jX2Rldl0gKGxvY2FsID8pIEJPSU5DIHJlcG8gYnJva2VuIGFnYWluIC1vci0gaG93
IHRvIGFjdCBvbiB0aGUgQ1IvTEYgY2hhbmdlcyBtYWRlIHVwc3RyZWFtDQoNCk9uIDA5LzE0LzIw
MTQgMTA6NTEgQU0sIFRvcnN0ZW4gQsO2Z2Vyc2hhdXNlbiB3cm90ZToNCj4+IEl0IG1heSBiZSB0
aGF0IHRoZXJlIGlzIGEgYnVnIGluIHRoZSB0b29scyB5b3UgYXJlIHVzaW5nLg0KPiBJIHVzZSBn
aXQgMi4xLjANCj4NClRoZSBxdWVzdGlvbiB3YXMgaG93IHRoZSBjb21taXQgaGFkIGJlZW4gcHJv
ZHVjZWQ6DQpSb20sICB3aGF0IGFyZSB5b3UgdXNpbmcgPw0KDQoNCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYm9pbmNfZGV2IG1haWxpbmcgbGlzdApi
b2luY19kZXZAc3NsLmJlcmtlbGV5LmVkdQpodHRwOi8vbGlzdHMuc3NsLmJlcmtlbGV5LmVkdS9t
YWlsbWFuL2xpc3RpbmZvL2JvaW5jX2RldgpUbyB1bnN1YnNjcmliZSwgdmlzaXQgdGhlIGFib3Zl
IFVSTCBhbmQKKG5lYXIgYm90dG9tIG9mIHBhZ2UpIGVudGVyIHlvdXIgZW1haWwgYWRkcmVzcy4=
