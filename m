From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [PATCH stgit] revised patch for importing series from tarball
Date: Thu, 23 Oct 2008 21:53:09 -0500
Message-ID: <20081023215309.2dc07e6e@gmail.com>
References: <20081019141613.05cbd93e@gmail.com>
	<20081024011708.GA20369@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: base64
Cc: Git Mailing List <git@vger.kernel.org>
To: Karl =?ISO-8859-1?B?SGFzc2Vsc3Ry9m0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 04:54:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtCov-0004cO-CL
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 04:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbYJXCxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 22:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbYJXCxY
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 22:53:24 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:35937 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbYJXCxY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 22:53:24 -0400
Received: by qw-out-2122.google.com with SMTP id 3so317739qwe.37
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 19:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=AspcvZUKW3fwJt3qE51zwyRIhgUBX19Lfi0uPaKW3zU=;
        b=UvM5EACux5+AO0AMbDNAvBcltF0yOP5secRvAsCRvNtbA3gu8bDslJJnl+7RSLvJ1I
         YhzDlfmGfDEZXLX1Tg85IaP7hwDyuVJutNe6kakCawvHsrS3v4nFOGEOF7xDmm+VvEba
         /y6A8sM6vGU//tnsBHVyUeZCgUTnWrO74y4Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=vDr7hHZEvf3Nxg4FT5UyJNGC6w4g9S4Xhwn+HDVgGwbYlh8CAzyXLQ40pPFPjgIsgN
         qNzIOpedCn2HimWqOUHZNWYGSaDCOcN82T4zgdL+hw66lVBc5nAtEZA11I4P8teAN258
         o1z9c29bPT/loLhKrwVcN3lmP2D7EYA/V3po8=
Received: by 10.214.243.1 with SMTP id q1mr90078qah.351.1224816801965;
        Thu, 23 Oct 2008 19:53:21 -0700 (PDT)
Received: from localhost.localdomain (user-1120rse.dsl.mindspring.com [66.32.111.142])
        by mx.google.com with ESMTPS id 6sm7547534qwk.1.2008.10.23.19.53.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Oct 2008 19:53:21 -0700 (PDT)
In-Reply-To: <20081024011708.GA20369@diana.vm.bytemark.co.uk>
X-Mailer: Claws Mail 3.6.0 (GTK+ 2.14.4; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99002>

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMQ0KDQpPbiBGcmks
IDI0IE9jdCAyMDA4IDAzOjE3OjA4ICswMjAwDQpLYXJsIEhhc3NlbHN0cvZtIDxraGFAdHJlc2th
bC5jb20+IHdyb3RlOg0KDQo+IE9uIDIwMDgtMTAtMTkgMTQ6MTY6MTMgLTA1MDAsIENsYXJrIFdp
bGxpYW1zIHdyb3RlOg0KPiANCj4gPiBJIGFkZGVkIGEgc2ltcGxlIHRlc3QgdG8gdGhlIHRlc3Qg
aGFybmVzcyBmb3IgaW1wb3J0IGFzIHdlbGwuDQo+IA0KPiBHcmVhdCENCj4gDQo+ID4gT2ggYW5k
IEkgYWRkZWQgJyouZWxjJyB0byB0aGUgLmdpdGlnbm9yZSBmaWxlLiBNYXkgbm90IGJlIHRoYXQg
bWFueQ0KPiA+IGZvbGtzIHVzaW5nIGVtYWNzIHdpdGggc3RnaXQsIGJ1dCBoZXksIEkgYW0hIDop
DQo+IA0KPiBNZSB0b28gKGJ1dCBJIGhhdmUgKi5lbGMgaW4gbXkgcGVyc29uYWwgaWdub3JlIGZp
bGUsIHNvIEkgbmV2ZXIgc2F3DQo+IGl0KS4gSG93ZXZlciwgdGhpcyBpcyBhbiB1bnJlbGF0ZWQg
Y2hhbmdlLCBhbmQgd2UgZG9uJ3QgbmVlZCB0byBpZ25vcmUNCj4gLmVsYyBmaWxlcyBhdCB0aGUg
dG9wIGxldmVsLCBvbmx5IGluIGNvbnRyaWIuIEkndmUgdGFrZW4gdGhlIGxpYmVydHkNCj4gb2Yg
c3BsaXR0aW5nIHRoaXMgb3V0IHRvIGEgc2VwYXJhdGUgY29tbWl0IGFuZCBmb3JnaW5nIHlvdXIg
c2lnbmF0dXJlDQo+IG9uIGl0IC0tIGxldCBtZSBrbm93IGlmIHRoYXQncyBPSyBhbmQgSSdsbCBw
dXNoIGl0IG91dC4NCj4gDQoNClllcywgdGhhdCdzIGZpbmUuDQoNCj4gPiBwYXRjaCB0byBhbGxv
dyBpbXBvcnRpbmcgYSBzZXJpZXMgZnJvbSBhIHRhciBhcmNoaXZlDQo+IA0KPiBJIHR1cm5lZCB0
aGlzIGludG8gYSBjb21wbGV0ZSBzZW50ZW5jZSwgYW5kIHJlbW92ZWQgInBhdGNoIiBzaW5jZSBp
dCdzDQo+IGVudGlyZWx5IHJlZHVuZGFudC4NCj4gDQo+ID4gLS0tIGEvLmdpdGlnbm9yZQ0KPiA+
ICsrKyBiLy5naXRpZ25vcmUNCj4gPiBAQCAtNiwzICs2LDQgQEAgcGF0Y2hlcy0qDQo+ID4gIHJl
bGVhc2Uuc2gNCj4gPiAgc2V0dXAuY2ZnLnJwbQ0KPiA+ICBzbmFwc2hvdC5zaA0KPiA+ICsqLmVs
Yw0KPiANCj4gQXMgSSBzYWlkLCBJIHB1dCB0aGlzIGluIGEgc2VwYXJhdGUgcGF0Y2gsIGFuZCBw
dXQgdGhhdCBpZ25vcmUgcGF0dGVybg0KPiBpbiBjb250cmliLmdpdGlnbm9yZSBpbnN0ZWFkLg0K
PiANClRoYW5rcw0KDQo+ID4gICAgICAgICAgICAgbWFrZV9vcHRpb24oJy0tY29tbWVtYWlsJywN
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBoZWxwID0gJ3VzZSBDT01NRU1BSUwgYXMgdGhl
IGNvbW1pdHRlciBlLW1haWwnKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGhlbHAgPSAn
dXNlIENPTU1FTUFJTCBhcyB0aGUgY29tbWl0dGVyIGUtbWFpbCcpLA0KPiA+ICAgICAgICAgICAg
IF0gKyBtYWtlX3NpZ25fb3B0aW9ucygpDQo+IA0KPiBUaGlzIGlzIGp1c3QgYSBub2lzZSBjaGFu
Z2UgX2FuZF8gZGlkbid0IGFwcGx5LCBzbyBJIGRyb3BwZWQgaXQuDQo+IA0KDQpBZ3JlZWQuIA0K
DQpUaGFua3MgZm9yIHRoZSB1cGRhdGUuDQoNCkNsYXJrDQoNCi0tLS0tQkVHSU4gUEdQIFNJR05B
VFVSRS0tLS0tDQpWZXJzaW9uOiBHbnVQRyB2Mi4wLjkgKEdOVS9MaW51eCkNCg0KaUVZRUFSRUNB
QVlGQWtrQk9KMEFDZ2tRcUE0SlZiNjFiOWU2U2dDZU9aMFlyQi91U3J2U3FnTGt4bkxqaVFwMg0K
QVd3QW9LSWVJUVVPV0VnaEVPV0JnT0RuVG9qQTJvNXENCj1COWR6DQotLS0tLUVORCBQR1AgU0lH
TkFUVVJFLS0tLS0NCg==
