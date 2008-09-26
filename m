From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: gitk: Turn short SHA1 names into links too
Date: Fri, 26 Sep 2008 10:21:45 +0200
Message-ID: <237967ef0809260121w1c7cc516tceb3be2cbebb85bc@mail.gmail.com>
References: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org>
	 <alpine.LFD.1.10.0809251729440.3265@nehalem.linux-foundation.org>
	 <BD7D0F18-32BD-4059-9190-A2C1B101B4C1@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 10:25:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj8bX-0000iz-AM
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 10:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbYIZIVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 04:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752973AbYIZIVt
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 04:21:49 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:6780 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbYIZIVr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 04:21:47 -0400
Received: by ey-out-2122.google.com with SMTP id 6so273641eyi.37
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 01:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=55ed1IMiOba8cXdJpGjaBZanX5JedQdoayjK9O7jCDs=;
        b=YIoBk0SFVl+96YFdcujALhO6CEj57y526WKJ7I4+dB7awbSzNoSxJeH7m950FKMJRH
         HL+AjzXLyodQitJePVZ5NwSi843PQbFahlcSmRRtmCyFTHQjMNMJ0I20EHwQgwOFY3Sg
         yR4SXRw2xy18QPdWcmSGJZCgF5kbHVffRJIO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Vh2m39IbqTZk97acDV2CQQR0Daed1F/e2+CVPopKwnLZYBRWYojmCXYtSF/elrzYA8
         gH/gWGT8hKZKrEFXgrykCh/lhlLcdtyF4lsWIubfRwZbSs3eqRhx8/IEoCYuDYZrnaTl
         M86BWlZFKsJZy1eZBBnXVWjfSagnwON2S6T/Q=
Received: by 10.210.37.16 with SMTP id k16mr1063744ebk.155.1222417305200;
        Fri, 26 Sep 2008 01:21:45 -0700 (PDT)
Received: by 10.210.19.20 with HTTP; Fri, 26 Sep 2008 01:21:45 -0700 (PDT)
In-Reply-To: <BD7D0F18-32BD-4059-9190-A2C1B101B4C1@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96839>

MjAwOC85LzI2IFdpbmNlbnQgQ29sYWl1dGEgPHdpbkB3aW5jZW50LmNvbT46Cj4gRWwgMjYvOS8y
MDA4LCBhIGxhcyAyOjM3LCBMaW51cyBUb3J2YWxkcyBlc2NyaWJpw7M6Cj4KPj4gT24gVGh1LCAy
NSBTZXAgMjAwOCwgTGludXMgVG9ydmFsZHMgd3JvdGU6Cj4+Pgo+Pj4gQW5kIHRoZSB0aGluZyBJ
IHdhbnRlZCB0byB3b3JrIHdhcyB0byBoYXZlIHRoZSBhYmJyZXZpYXRlZCBTSEExJ3MgdGhhdAo+
Pj4gaGF2ZSBzdGFydGVkIHRvIGdldCBtb3JlIGNvbW1vbiBpbiB0aGUga2VybmVsIGNvbW1pdCBs
b2dzIHdvcmsgYXMgbGlua3MKPj4+IGluCj4+PiBnaXRrIHRvbywganVzdCB0aGUgd2F5IGEgZnVs
bCA0MC1jaGFyYWN0ZXIgU0hBMSBsaW5rIHdvcmtzLgo+Pgo+PiBGb3IgYSB0ZXN0LWNhc2UsIEkg
anVzdCBwdXNoZWQgb3V0IG15IGN1cnJlbnQgdG9wLW9mLXRyZWUgdGhhdCBmaW5hbGx5Cj4+IHB1
c2hlZCBtZSBvdmVyIHRoZSBlZGdlLiBJJ3ZlIHNlZW4gdGhpcyBiZWZvcmUsIGJ1dCBJIGNvdWxk
bid0IHJlYWxseQo+PiBmb3JjZSBtZSB0byBkbyBhbnl0aGluZyBhYm91dCBpdCB1bnRpbCBub3cu
Cj4+Cj4+IFNvIHRvIHNlZSB0aGlzIGluIGFjdGlvbiwgZG8KPj4KPj4gICAgICAgIGdpdGsgdjIu
Ni4yNi4uNmVmMTkwYwo+Pgo+PiBvbiB0aGUgY3VycmVudCBrZXJuZWwgcmVwbywgYW5kIG5vdGlj
ZSB0aGF0ICJDb21taXQgZWUxZTJjODIgKCJJUG9JQjoKPj4gUmVmcmVzaCBwYXRocyAuLiIgdGhp
bmcsIHdoZXJlIHdlIHdhbnQgdGhhdCAnZWUxZTJjODInIHRvIGJlIGEgbGluayBldmVuCj4+IHRo
b3VnaCBpdCdzIG5vdCBhIGZ1bGwgU0hBMS4KPj4KPj4gT2YgY291cnNlLCB0aGUgbWF0Y2hpbmcg
Y291bGQgYmUgYmV0dGVyLCBpdCB3aWxsIG5vdyBhY2NlcHQgYW55IHJhbmRvbSA2Kwo+PiBjaGFy
YWN0ZXIgc2VxdWVuY2Ugb2YgaGV4IGNoYXJhY3RlcnMsIGV2ZW4gaWYgdGhleSBhcmUgc3Vycm91
bmRlZCBieQo+PiBjaGFyYWN0ZXJzIHRoYXQgbWFrZSBpdCBjbGVhciB0aGF0IGl0J3Mgbm90IGEg
U0hBMSAoIkhhYWhhaGhhYWFhYWEhIgo+PiB3b3VsZCBmaW5kIHRoZSAnYWFhYWFhJyBhbmQgaWYg
eW91IGhhdmUgYSBjb21taXQgdGhhdCBzdGFydHMgd2l0aCB0aGF0LAo+PiBsaW5rIHRvIGl0IDsp
Cj4KPiBJIGtub3cgbm90aGluZyBhYm91dCB0Y2wvdGssIGJ1dCB3aWxsIGNvbW1lbnQgYW55d2F5
Ogo+Cj4gSXQncyBhIHNoYW1lIHRoYXQgdGNsL3RrIHJlZ3VsYXIgZXhwcmVzc2lvbnMgZG9uJ3Qg
YXBwZWFyIHRvIHN1cHBvcnQKPiBhbmNob3JpbmcgbWF0Y2hlcyBhZ2FpbnN0IHdvcmQgYm91bmRh
cmllcyAoaWUuICJcYiIpLgo+Cj4gSWYgc28sIGEgcmVnZXhwIGxpa2U6Cj4KPiAgW3JlZ2V4cCB7
XGJbMC05YS1mXXs0LDM5fVxifSAkaWRdCj4KPiB3b3VsZCBtb3N0bHkgZWxpbWluYXRlIHRoYXQg
a2luZCBvZiBmYWxzZSBwb3NpdGl2ZS4gQnV0IGZyb20gbXkgcmVhZGluZyBvZgo+IHRoZSB3aWtp
WzFdLCBsb29rcyBsaWtlIHRoZXJlJ3Mgbm8gIlxiIiBlc2NhcGUgc2VxdWVuY2UuIE5vciBkb2Vz
IGl0IGxvb2sKPiBsaWtlIHRjbC90ayBoYXMgc3VwcG9ydCBmb3IgbG9va2FoZWFkL2xvb2tiZWhp
bmQgYXNzZXJ0aW9ucyB3aGljaCBjb3VsZCBiZQo+IHVzZWQgdG8gdGhlIHNhbWUgZWZmZWN0LgoK
XHkgYXBwZWFycyB0byBhY2hpZXZlIHRoaXM7CgolIHJlZ2V4cCB7YWJjXHl9ICdhYmMnCjEKJSBy
ZWdleHAge2FiY1x5fSAnYWJjZCcKMAolIHJlZ2V4cCB7XHlhYmNceX0gJ3VhYmMsZCcKMAolIHJl
Z2V4cCB7XHlhYmNceX0gJ3UrYWJjLGQnCjEKCkkgaGF2ZSB0Y2wvdGsgOC41IHNvIEkgY2Fubm90
IHByb21pc2UgdGhhdCBpc24ndCBhIG5ldyBhZGRpdGlvbiwgSSBkaWRuJ3QKbG9vayBpdCB1cCBh
bnl3aGVyZSwgYnV0IGl0J3MgXHkgaW4gc29tZSBvdGhlciBpbXBsZW1lbnRhdGlvbnMgdG9vLCBz
byBJCnRyaWVkIGl0LgoKLS0gCk1pa2FlbCBNYWdudXNzb24K
