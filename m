From: "Rom Walton" <romw-egxtZiWXYP1AfugRpC6u6w@public.gmane.org>
Subject: Re: (local ?) BOINC repo broken again -or- how to act
	on the CR/LF changes made upstream
Date: Fri, 12 Sep 2014 14:55:20 -0400
Message-ID: <1BAFA9B4D550C347962F76F2E03B3BBB22C5FA@romw-mail.romwnet.org>
References: <541336D6.3050803@gmx.de>
	<1BAFA9B4D550C347962F76F2E03B3BBB22C5F9@romw-mail.romwnet.org>
	<54133C3A.4080700@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
To: =?utf-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster-Mmb7MZpHnFY@public.gmane.org>,
	<git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org Fri Sep 12 20:55:28 2014
Return-path: <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
Envelope-to: gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from mailapps1.ssl.berkeley.edu ([128.32.13.237])
	by plane.gmane.org with smtp (Exim 4.69)
	(envelope-from <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>)
	id 1XSW0D-0007Ng-88
	for gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Fri, 12 Sep 2014 20:55:25 +0200
Received: from mailapps1.ssl.berkeley.edu (localhost [127.0.0.1])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id A97AD2FEA48;
	Fri, 12 Sep 2014 11:55:23 -0700 (PDT)
X-Original-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Delivered-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Received: from mail2.ssl.berkeley.edu (mail2.ssl.berkeley.edu [128.32.13.252])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id EA1052FEA40
	for <boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org>;
	Fri, 12 Sep 2014 11:55:22 -0700 (PDT)
Received: from mailwall2.ssl.berkeley.edu (mailwall2.ssl.berkeley.edu
	[128.32.147.8])
	by mail2.ssl.berkeley.edu (8.13.8/8.13.8) with ESMTP id s8CItMlB032563
	for <boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>; Fri, 12 Sep 2014 11:55:22 -0700
X-ASG-Debug-ID: 1410548122-04b397145f29e2a0001-LQ66t1
Received: from mho-01-ewr.mailhop.org (mho-03-ewr.mailhop.org [204.13.248.66])
	by mailwall2.ssl.berkeley.edu with ESMTP id mqn3cQSII9AXQRWk
	for <boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>;
	Fri, 12 Sep 2014 11:55:22 -0700 (PDT)
X-Barracuda-Envelope-From: romw-egxtZiWXYP1AfugRpC6u6w@public.gmane.org
X-Barracuda-Apparent-Source-IP: 204.13.248.66
Received: from 173-160-3-53-naples.hfc.comcastbusiness.net ([173.160.3.53]
	helo=mail.romwnet.org)
	by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.72) (envelope-from <romw-egxtZiWXYP1AfugRpC6u6w@public.gmane.org>)
	id 1XSW09-00080m-Vp; Fri, 12 Sep 2014 18:55:22 +0000
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 173.160.3.53
X-Report-Abuse-To: abuse-yJRlmlznMY/QT0dZR+AlfA@public.gmane.org (see
	http://www.dyndns.com/services/sendlabs/outbound_abuse.html for
	abuse reporting information)
X-MHO-User: U2FsdGVkX1/M8suBWglvS3N4klN9a88ntKuiyS5/XrE=
X-ASG-Orig-Subj: RE: [boinc_dev] (local ?) BOINC repo broken again -or- how to
	act on the CR/LF changes made upstream
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [boinc_dev] (local ?) BOINC repo broken again -or- how to act on
	the CR/LF changes made upstream
Thread-Index: Ac/Ot+8445asMC5xT1mWHHb+KVYbEAAAiYXw
X-Barracuda-Connect: mho-03-ewr.mailhop.org[204.13.248.66]
X-Barracuda-Start-Time: 1410548122
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256939>

Q3J1ZC4uLg0KDQpXZWxsLCBwZXJzb25hbGx5LCBJIHdvdWxkIGRlbGV0ZSB0aGUgbG9jYWxlIGRp
cmVjdG9yeSBhbmQgdGhlIHR3byB0cmFuc2xhdGlvbiBmaWxlcyBpbiBodG1sLg0KDQpEbyB0aGUg
J2dpdCBwdWxsJywgYW5kIHRoZW4gc3dpdGNoIGJldHdlZW4gbWFzdGVyIGFuZCBzb21lIG90aGVy
IGJyYW5jaC4NCg0KbGlrZToNCmdpdCBjaGVja291dCAtZiBjbGllbnRfcmVsZWFzZS83LzcuNA0K
Z2l0IGNoZWNrb3V0IC1mIG1hc3Rlcg0KDQpJdCBpcyByb3VuZCBhYm91dCwgYnV0IGl0IHNob3Vs
ZCBnZXQgdGhlIGpvYiBkb25lLg0KDQotLS0tLSBSb20NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IFRvcmFsZiBGw7Zyc3RlciBbbWFpbHRvOnRvcmFsZi5mb2Vyc3RlckBnbXgu
ZGVdIA0KU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMTQgMjozMiBQTQ0KVG86IFJvbSBX
YWx0b247IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBib2luY19kZXZAc3NsLmJlcmtlbGV5LmVk
dQ0KU3ViamVjdDogUmU6IFtib2luY19kZXZdIChsb2NhbCA/KSBCT0lOQyByZXBvIGJyb2tlbiBh
Z2FpbiAtb3ItIGhvdyB0byBhY3Qgb24gdGhlIENSL0xGIGNoYW5nZXMgbWFkZSB1cHN0cmVhbQ0K
DQpPbiAwOS8xMi8yMDE0IDA4OjE5IFBNLCBSb20gV2FsdG9uIHdyb3RlOg0KPiBUcnk6DQo+IGdp
dCBjaGVja291dCAtZiBtYXN0ZXINCj4gZ2l0IHB1bGwgb3JpZ2luDQo+IA0KPiBJIGNvbW1pdHRl
ZCBmaXhlcyBmb3IgdGhhdCBzdHVmZiB0aGlzIG1vcm5pbmcuDQoNCmRvZXNuJ3QgaGVscGVkIDoN
Cg0KdGZvZXJzdGVAbjIyIH4vZGV2ZWwvYm9pbmMtdjIgJCBnaXQgY2hlY2tvdXQgLWYgbWFzdGVy
IEFscmVhZHkgb24gJ21hc3RlcicNCllvdXIgYnJhbmNoIGlzIGJlaGluZCAnb3JpZ2luL21hc3Rl
cicgYnkgNyBjb21taXRzLCBhbmQgY2FuIGJlIGZhc3QtZm9yd2FyZGVkLg0KICAodXNlICJnaXQg
cHVsbCIgdG8gdXBkYXRlIHlvdXIgbG9jYWwgYnJhbmNoKQ0KDQp0Zm9lcnN0ZUBuMjIgfi9kZXZl
bC9ib2luYy12MiAkIGdpdCBwdWxsIG9yaWdpbiBVcGRhdGluZyBjZTk3ZTg1Li5kMmU1NTgyDQpl
cnJvcjogWW91ciBsb2NhbCBjaGFuZ2VzIHRvIHRoZSBmb2xsb3dpbmcgZmlsZXMgd291bGQgYmUg
b3ZlcndyaXR0ZW4gYnkgbWVyZ2U6DQogICAgICAgIGh0bWwvbGFuZ3VhZ2VzL3RyYW5zbGF0aW9u
cy9odS5wbw0KICAgICAgICBodG1sL2xhbmd1YWdlcy90cmFuc2xhdGlvbnMvbmwucG8NCiAgICAg
ICAgbG9jYWxlL2JnL0JPSU5DLVdlYi5wbw0KICAgICAgICBsb2NhbGUvZGEvQk9JTkMtV2ViLnBv
DQogICAgICAgIGxvY2FsZS9lbC9CT0lOQy1XZWIucG8NCiAgICAgICAgbG9jYWxlL2ZyL0JPSU5D
LVdlYi5wbw0KICAgICAgICBsb2NhbGUvaHIvQk9JTkMtV2ViLnBvDQogICAgICAgIGxvY2FsZS9o
dS9CT0lOQy1Qcm9qZWN0LUdlbmVyaWMucG8NCiAgICAgICAgbG9jYWxlL2h1L0JPSU5DLVdlYi5w
bw0KICAgICAgICBsb2NhbGUvaXRfSVQvQk9JTkMtUHJvamVjdC1HZW5lcmljLnBvDQogICAgICAg
IGxvY2FsZS9sdi9CT0lOQy1XZWIucG8NCiAgICAgICAgbG9jYWxlL25sL0JPSU5DLVByb2plY3Qt
R2VuZXJpYy5wbw0KICAgICAgICBsb2NhbGUvbmwvQk9JTkMtV2ViLnBvDQogICAgICAgIGxvY2Fs
ZS9wbC9CT0lOQy1XZWIucG8NCiAgICAgICAgbG9jYWxlL3B0X0JSL0JPSU5DLVdlYi5wbw0KICAg
ICAgICBsb2NhbGUvcm8vQk9JTkMtV2ViLnBvDQogICAgICAgIGxvY2FsZS9zay9CT0lOQy1XZWIu
cG8NCiAgICAgICAgbG9jYWxlL3poX1RXL0JPSU5DLVdlYi5wbw0KUGxlYXNlLCBjb21taXQgeW91
ciBjaGFuZ2VzIG9yIHN0YXNoIHRoZW0gYmVmb3JlIHlvdSBjYW4gbWVyZ2UuDQpBYm9ydGluZw0K
DQotLQ0KVG9yYWxmDQpwZ3Aga2V5OiAwMDc2IEU5NEUNCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYm9pbmNfZGV2IG1haWxpbmcgbGlzdApib2luY19k
ZXZAc3NsLmJlcmtlbGV5LmVkdQpodHRwOi8vbGlzdHMuc3NsLmJlcmtlbGV5LmVkdS9tYWlsbWFu
L2xpc3RpbmZvL2JvaW5jX2RldgpUbyB1bnN1YnNjcmliZSwgdmlzaXQgdGhlIGFib3ZlIFVSTCBh
bmQKKG5lYXIgYm90dG9tIG9mIHBhZ2UpIGVudGVyIHlvdXIgZW1haWwgYWRkcmVzcy4=
