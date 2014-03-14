From: =?GBK?B?yfKz0Lb3?= <ubuntu2012@126.com>
Subject: Re:Re: [PATCH] microproject for GSOC
Date: Sat, 15 Mar 2014 02:13:07 +0800 (CST)
Message-ID: <41f601c6.a3.144c1cc2f20.Coremail.ubuntu2012@126.com>
References: <1394815367-9706-1-git-send-email-ubuntu2012@126.com>
 <vpq4n30aeou.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 14 19:13:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOWbg-0003Ay-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 19:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbaCNSNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 14:13:16 -0400
Received: from m15-19.126.com ([220.181.15.19]:57944 "EHLO m15-19.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754789AbaCNSNP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 14:13:15 -0400
X-Greylist: delayed 1704 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Mar 2014 14:13:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=W8rjW
	QfpPlG/zOtAX/Os8Mcx7FwOvp6UAtdVI4gV690=; b=dxB+ziow2hfDKSlkJbFmz
	lr9OTbFZn08h5o1Zcvvid/OR6Xiks7ryBg5eI+nBnETa0pwHKbbLIaqoUS52Guce
	pt3jHl72Hi+R2fIAzOm3rsPavp0y40FuF6EuuAZz8IAL0EMt/glOZthnYdnO48yT
	FetgdoMHeS+drtseBZBPNY=
Received: from ubuntu2012$126.com ( [125.71.195.57] ) by
 ajax-webmail-wmsvr19 (Coremail) ; Sat, 15 Mar 2014 02:13:07 +0800 (CST)
X-Originating-IP: [125.71.195.57]
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20131204(24406.5820.5783) Copyright (c) 2002-2014 www.mailtech.cn 126com
In-Reply-To: <vpq4n30aeou.fsf@anie.imag.fr>
X-CM-TRANSID: E8qowGCJekG1RiNTKhcNAA--.38938W
X-CM-SenderInfo: hxex03jxsqija6rslhhfrp/1tbi1AFOqEsK460BhgADs4
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244101>

VGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLkkgd2lsbCBhbWVuZCB0aG9zZSBpc3N1ZXMgLkFz
IGEgQ2hpbmVzZSBzdHVkZW50LHdoYXQgbmFtZSBzaG91bGQgSSB1c2U/TXkgQ2hpbmVzZSBuYW1l
IGlzIG9rPwpJIGFtIHZlcnkgaW50ZXJlc3QgaW4gT3BlbiBzb3VyY2UuV2hhdCBjYW4gSSBkbyB0
byBpbmNyZWFzZSBteSBjaGFuY2U/CkF0IDIwMTQtMDMtMTUgMDE6MTA6NTcsIk1hdHRoaWV1IE1v
eSIgPE1hdHRoaWV1Lk1veUBncmVub2JsZS1pbnAuZnI+IHdyb3RlOgo+SGksDQo+DQo+V2VsY29t
ZSB0byB0aGUgR2l0IGNvbW11bml0eSwgYW5kIHdlbGNvbWUgdG8gdGhlIEdTT0MgcHJvZ3JhbS4g
QmVsb3cgYXJlDQo+c29tZSBjb21tZW50cyB0byBnaXZlIHlvdSBhIHRhc3RlIG9mIHdoYXQgYSBy
ZXZpZXcgbG9va3MgbGlrZSBvbiB0aGlzDQo+bGlzdC4gRG8gdGFrZSB0aGUgY29tbWVudHMgc2Vy
aW91c2x5ICh0aGV5IHNob3VsZCBiZSBhZGRyZXNzZWQpLCBidXQNCj5kb24ndCB0YWtlIHRoZW0g
YmFkbHk6IGNyaXRpYyBpcyBtZWFudCB0byBiZSBjb25zdHJ1Y3RpdmUuDQo+DQo+dWJ1bnR1NzMz
IDx1YnVudHUyMDEyQDEyNi5jb20+IHdyaXRlczoNCj5eXl5eXl5eXl4NCj4NCj5QbGVhc2UsIHVz
ZSBhIHJlYWwgbmFtZSB3aGVuIHlvdSBjb250cmlidXRlIHRvIEdpdC4NCj4NCj4+IEFwcGx5IGZv
ciBHU09DLlRoZSBtaWNyb3Byb2plY3RzIGlzIHJld3JpdGVyIGRpZmYtaW5kZXguYw0KPg0KPlRo
aXMgcGFydCBvZiB5b3VyIG1lc3NhZ2Ugd2lsbCBiZWNvbWUgdGhlIGNvbW1pdCBtZXNzYWdlIChp
LmUuIGNhc3QgaW4NCj5zdG9uZSBmb3JldmVyIGluIGdpdC5naXQncyBoaXN0b3J5KS4gVGhlIHBv
aW50IGlzIG5vdCB0aGF0IHlvdSB3YW50IHRvDQo+YXBwbHkgZm9yIEdTT0MsIGJ1dCB3aGF0IHRo
ZSBwYXRjaCBkb2VzIGFuZCBtb3JlIGltcG9ydGFudGx5IHdoeSBpdCBkb2VzDQo+aXQuDQo+DQo+
PiArI2RlZmluZSBSRU1PVkUgMQ0KPg0KPklmIHRoZSBjb2RlIGlzIHRvIGJlIHJlbW92ZWQsIHRo
ZW4gcmVtb3ZlIGl0LiBUaGF0J3Mgd2h5IHdlIHVzZSBhDQo+dmVyc2lvbiBjb250cm9sIHN5c3Rl
bSA7LSkuDQo+DQo+PiAtCXdoaWxlICgoZSA9IHJlYWRkaXIoZGlyKSkpDQo+PiAtCQlpZiAoc3Ry
Y21wKCIuIiwgZS0+ZF9uYW1lKSAmJiBzdHJjbXAoIi4uIiwgZS0+ZF9uYW1lKSkNCj4+IC0JCQlz
dHJpbmdfbGlzdF9pbnNlcnQobGlzdCwgZS0+ZF9uYW1lKTsNCj4+IC0NCj4+ICsJd2hpbGUgKChl
ID0gcmVhZGRpcihkaXIpKSkgew0KPj4gKwkJd2hpbGUoaXNfZG90X29yX2RvdGRvdChlLT5kX25h
bWUpKQ0KPg0KPk1pc3Npbmcgc3BhY2UgYmV0d2VlbiAid2hpbGUiIGFuZCAiKCIuDQo+DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPg0KPkJyb2tlbiBpbmRlbnRhdGlvbiAoaW5k
ZW50IHdpdGggc3BhY2UpLg0KPg0KPlRoaXMgd2hpbGUgKC4uLikgYnJlYWs7IHNlZW1zIHJlYWxs
eSB3ZWlyZCB0byBtZTogaWYgdGhlIGNvbmRpdGlvbiBpcw0KPmZhbHNlLCB0aGVuIHlvdSBleGl0
IHRoZSBsb29wIGJlY2F1c2UgaXQncyBhIHdoaWxlIGxvb3AsIGFuZCBpZiB0aGUNCj5jb25kaXRp
b24gaXMgdHJ1ZSwgeW91IGV4aXQgdGhlIGxvb3AgYmVjYXVzZSBvZiB0aGUgYnJlYWsuIElzbid0
IHRoYXQgYQ0KPm5vLW9wPw0KPg0KPj4gKwkJc3RyaW5nX2xpc3RfaW5zZXJ0KGxpc3QsIGUtPmRf
bmFtZSk7DQo+PiArICAgICAgICAgICAgICB9DQo+DQo+QnJva2VuIGluZGVudGF0aW9uIChtaXNw
bGFjZWQgfSkuDQo+DQo+LS0gDQo+TWF0dGhpZXUgTW95DQo+aHR0cDovL3d3dy12ZXJpbWFnLmlt
YWcuZnIvfm1veS8NCg==
