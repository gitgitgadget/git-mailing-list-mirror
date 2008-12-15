From: "Li Frank" <lznuaa@gmail.com>
Subject: Re: Announce: TortoiseGit 0.1 preview version
Date: Mon, 15 Dec 2008 22:19:35 +0800
Message-ID: <1976ea660812150619y713da734n23b687dc9ae4d94f@mail.gmail.com>
References: <1976ea660812130033m2d54cc57tfe134fab0d687d71@mail.gmail.com>
	 <m3d4fuewe0.fsf@localhost.localdomain>
	 <1976ea660812140529k1499b410u4437645be0dc7dfc@mail.gmail.com>
	 <200812151456.27750.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: base64
To: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 15:21:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCEKE-0001HR-6C
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 15:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbYLOOTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 09:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755453AbYLOOTi
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 09:19:38 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:50857 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbYLOOTh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 09:19:37 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1104906yxm.1
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 06:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vFjRRMgP/Q8oB4vjDON52BTH/nRg5/PcGhtahAW1UNA=;
        b=ewlIjEAyno/eujd+yCo1fygu14svNYnlNVJXmtWF2t6AYQB410NlRUcjvwL6+2nQdF
         lSMPJQUXDsOo9TRmlIiX9gMEABOUOa6PUjDDsByRDSMI7NDeQPuRXXpNgfxTKl9bk9Hz
         NURsJ6Pv4X7SMsL6BlnfB7wu/quWngxoPDS30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jaZISfKsw71U72oUDSxfUn0/2Hv2BFb6EyE0Dig2q6fr8yvJFZMJXUr8hk4TFwKUhj
         U4UtSevfv+8MvVNq4wqwe/9bNMZKDTVDylvz257EB+P7S87d5lMywvc5+M+Ji60rzFbj
         sS6mEy7g7XJRPae+opalZhogi+1OHPBW5sfss=
Received: by 10.150.123.16 with SMTP id v16mr5963077ybc.232.1229350776000;
        Mon, 15 Dec 2008 06:19:36 -0800 (PST)
Received: by 10.151.134.2 with HTTP; Mon, 15 Dec 2008 06:19:35 -0800 (PST)
In-Reply-To: <200812151456.27750.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103168>

SXQgaXMgY29ycmVjdCEgIFRoYW5rcwpCZXN0IHJlZ2FyZHMKRnJhbmsgTGkKCgoyMDA4LzEyLzE1
IEpha3ViIE5hcmVic2tpIDxqbmFyZWJAZ21haWwuY29tPjoKPiBPbiBTdW4sIDE0IERlYyAyMDA4
LCBMaSBGcmFuayB3cm90ZToKPgo+Pgo+PiAyMDA4LzEyLzE0IEpha3ViIE5hcmVic2tpIDxqbmFy
ZWJAZ21haWwuY29tPjoKPj4+ICLA7tbHIiA8bHpudWFhQGdtYWlsLmNvbT4gd3JpdGVzOgo+Pj4K
Pj4+PiBUb3J0b2lzZUdpdCBpcyBwb3J0aW5nIGZyb20gVG9ydG9pc2VTVk4uICBJdCBpcyBleHBs
b3JlIGV4dGVuc2lvbi4KPj4+PiBUaGlzIHZlcnNpb24ganVzdCBmaW5pc2ggYSBtaW5pbXVtIHNl
dCBvZiBUb3J0b2lzZVNWTiBwb3J0aW5nCj4+Pgo+Pj4gSG93IGl0IGRpZmZlcnMgZnJvbSBHaXRD
aGVldGFoIHByb2plY3Q/Cj4+IEdpdENoZWV0YWgganVzdCBzaG93IGdpdC1ndWkgJmdpdC1iYXNo
IGF0IGNvbnRleHQgbWVudSEKPj4KPj4gVG9ydG9pc2VHaXQgaXMgZnVsbCBwb3J0aW5nIGZyb20g
VG9ydG9pc2VTVk4uIE92ZXJsYXkgaWNvbiBjYW4gc2hvdwo+PiBtb2RpZmllZCBmaWxlLCBhZGQg
ZmlsZSBhbmQgY29uZmxpY3RlZCBmaWxlIHdoaXRoIGRpZmZlcmVudCBpY29uLgo+Pgo+PiBUb3J0
b2lzZUdpdCBjYW4gY29tbWl0IGNoYW5nZSwgc2hvdyBsb2csIGNoZWNrb3V0IC4uLiBhdCBDb250
ZXh0IG1lbnUhCj4+IEl0IGlzIGZ1bGwgZ2l0IGZvbnRlbmQuCj4KPj4+IFsuLi5dCj4+Pj4gUHJv
amVjdCBIb21lIFBhZ2UgYXQ6Cj4+Pj4gaHR0cDovL2NvZGUuZ29vZ2xlLmNvbS9wL3RvcnRvaXNl
Z2l0Lwo+Pj4+Cj4+Pj4gU291cmNlIGNvZGUgYXQKPj4+PiBodHRwOi8vcmVwby5vci5jei93L1Rv
cnRvaXNlR2l0LmdpdAo+Pj4+Cj4+Pj4gSXQgbmVlZCBtc3lzZ2l0IDEuNi4wLjIuCj4+Pgo+Pj4g
RG8geW91IGZlZWwgaXQgaXMgbWF0dXJlIGVub3VnaCB0byBiZSBhZGRlZCB0byBnaXQgd2lraSBw
YWdlCj4+PiAgaHR0cDovL2dpdC5vci5jei9naXR3aWtpL0ludGVyZmFjZXNGcm9udGVuZHNBbmRU
b29scwo+Pj4ganVzdCBhYm92ZSAiR2l0IEV4dGVuc2lvbnMiIGVudHJ5PyAgV291bGQgeW91IGRv
IGl0LCBvciBzaG91bGQKPj4+IEkgZG8gdGhpcz8KPj4KPj4gVG9ydG9pc2VHaXQgaXMgaW4gdmVy
eSBlYXJseSBzdGFnZS4gSSBqdXN0IGltcGxlbWVudCBtaW4gc2V0IGZlYXR1cmUKPj4gYW5kIG5v
dCBtYXR1cmUgLiBJIGhvcGUgdGhlcmUgYXJlIG1vcmUgYW5kIG1vcmUgcGVvcGxlIGludm9sdmUg
dGhpcwo+PiBwcm9qZWN0IGFuZCBtYWtlIGl0IG1hdHVyZSBhcyBUb3J0b2lzZVNWTi4KPgo+IEkg
aGF2ZSBhZGRlZCBpbmZvcm1hdGlvbiBhYm91dCBUb3J0b2lzZUdpdCB0byBnaXQgd2lraSBhdAo+
IGh0dHA6Ly9naXQub3IuY3ovZ2l0d2lraS9JbnRlcmZhY2VzRnJvbnRlbmRzQW5kVG9vbHMjaGVh
ZC04MDNmZjFlZWY3YTMyZmQxZDhmZTg2NzEzZGUzNDNhZjE4NjA1MDQ3Cj4KPiBQbGVhc2UgY29y
cmVjdCBpdCBpZiB0aGUgaW5mb3JtYXRpb24gdGhlcmUgKGNvcHkgYmVsb3cpIGlzIHdyb25nLgo+
IEZlZWwgZnJlZSB0byBleHRlbmQgdGhpcyBzaG9ydCBpbmZvLgo+Cj4gSG9wZWZ1bGx5IHRoaXMg
d2F5IG1vcmUgcGVvcGxlIHdvdWxkIGZpbmQgeW91ciBwcm9qZWN0LCBhbmQgYmUgYWJsZQo+IHRv
IGNvbnRyaWJ1dGUgdG8gaXQuCj4KPgo+ICA9PT0gVG9ydG9pc2VHaXQgPT09Cj4KPiAgVG9ydG9p
c2VHaXRbMV0gKGdpdHdlYlsyXSkgYnkgTGkgRnJhbmsgaXMgYSBwb3J0IG9mIFRvcnRvaXNlU1ZO
WzNdCj4gIHRvIEdpdC4gIEl0IGlzIE1pY3Jvc29mdCBXaW5kb3dzIHNoZWxsIChFeHBsb3Jlcikg
ZXh0ZW5zaW9uLCB3cml0dGVuCj4gIGluIEMrKy4gIFRvcnRvaXNlR2l0IGlzIGluIHZlcnkgZWFy
bHkgc3RhZ2VzIG9mIGRldmVsb3BtZW50LAo+ICBpbXBsZW1lbnRpbmcgY3VycmVudGx5IG9ubHkg
bWluaW1hbCBzZXQgb2YgZmVhdHVyZXMuCj4KPiAgWzFdIGh0dHA6Ly9jb2RlLmdvb2dsZS5jb20v
cC90b3J0b2lzZWdpdC8KPiAgWzJdIGh0dHA6Ly9yZXBvLm9yLmN6L3cvVG9ydG9pc2VHaXQuZ2l0
Cj4gIFszXSBodHRwOi8vdG9ydG9pc2Vzdm4udGlncmlzLm9yZy8KPgo+IC0tCj4gSmFrdWIgTmFy
ZWJza2kKPiBQb2xhbmQKPgo=
