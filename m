From: "Peter Waller" <peter.waller@gmail.com>
Subject: Re: Merging repositories and their histories
Date: Thu, 21 Aug 2008 16:53:51 -0500
Message-ID: <d3d284ca0808211453r2e1f1f1ak5e0a0b1ea7329a2@mail.gmail.com>
References: <19035412.post@talk.nabble.com> <48ADE2A6.2020407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 23:54:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWI7N-0005pD-7k
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 23:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721AbYHUVxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 17:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbYHUVxx
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 17:53:53 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:40857 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbYHUVxw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 17:53:52 -0400
Received: by gxk9 with SMTP id 9so809089gxk.13
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 14:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uqJtW7iXgs16o1E3SxXMGEeSmOcXMDAaIu87IWYYTFs=;
        b=TW/JoxJqqZ7fEj7caYxEyWdUYEqWxrCeyIeuWMUcNkEAhI5D1t090uMgm+KkJkyERH
         Rzp7qG7cUjXKqbGMxtOjT17XbzKuESkSPzye3l5vewyv80YykaDP7XKYX6Re5BatY+Y3
         1pDojsGOcvbksxC1z0nPgcU/TlLsZgMzqfXGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rvVSHeTWkoAKpvVQyTbYQIWYD4jDQN5KsycVkYflDY++PB9aa71DQOBkJm07zR0prH
         QIM/WQGFLRvePZwEjxjHfbkvvbqTTAoCccHWjsAnsj13hXa4hqLH/hQbh20bQOLHBjvn
         ZqlPfd04O+jhRHn8IKt/mQgCMZsAYnWD+y80k=
Received: by 10.151.12.1 with SMTP id p1mr578822ybi.1.1219355631370;
        Thu, 21 Aug 2008 14:53:51 -0700 (PDT)
Received: by 10.151.39.13 with HTTP; Thu, 21 Aug 2008 14:53:51 -0700 (PDT)
In-Reply-To: <48ADE2A6.2020407@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93218>

TmFiYmxlIGtlcHQgdGVsbGluZyBtZSB0aGF0IG15IHBvc3Qgd2FzIG5vdCBzdWJtaXR0ZWQsIHdo
aWNoIEkgZm91bmQKdmVyeSBjb25mdXNpbmcsIHNvIEkgZW5kZWQgdXAgdHJ5aW5nIHRvIHJlc3Vi
bWl0IHRoZSBwb3N0LiBTb3JyeSBmb3IKdGhlIHNwYW0uIFRoaXMgaXMgbm93IHNvcnRlZC4KCkNo
ZWVycyBmb3IgdGhlIGtlZW4tbmVzcyB0byBoZWxwISA6LSkKCi0gUGV0ZQoKMjAwOC84LzIxIE1h
cmN1cyBHcmllcCA8bmVvZWluc3RlaW5AZ21haWwuY29tPgo+Cj4gUGV0ZXIgV2FsbGVyIHdyb3Rl
Ogo+ID4gSSBoYXZlIHRocmVlIHJlcG9zaXRvcmllcywgQSwgQiBhbmQgQy4gSSB3aXNoIHRvIGJy
aW5nIHRoZW0gdG9nZXRoZXIgdG8gb25seQo+ID4gb25lIHJlcG9zaXRvcnkgKC4pLCB3aGVyZSB0
aGV5IGFyZSBpbiBhIGRpcmVjdG9yeSBjYWxsZWQgLi9BcmNoaXZlLCBzby4uCj4gPiAuL0FyY2hp
dmUve0EsQixDfS4gVGhlbiBJIHBsYW4gYXQgYSBsYXRlciBkYXRlIHRvIG1vdmUgZmlsZXMgYXJi
aXRyYXJpbHkKPiA+IGZyb20gLi9BcmNoaXZlL3tBL0IvQ30vU29tZXRoaW5nIGFuZCBpbnRvIC4v
U29tZXRoaW5ne0EvQi9DfS4gKEEgbGFtZQo+ID4gZXhhbXBsZSwgYnV0IGlsbHVzdHJhdGVzIHdo
YXQgSSB3YW50IHRvIGRvKS4KPgo+IFBldGVyIFdhbGxlciBhbHNvIHdyb3RlOgo+ID4gVGhhbmtz
LCBpdCB3b3JrZWQuCj4gPgo+ID4gMjAwOC84LzE4IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFp
bC5jb20+Ogo+ID4gPiA+IFBldGVyIFdhbGxlciwgTW9uLCBBdWcgMTgsIDIwMDggMjA6MTU6NTIg
KzAyMDA6Cj4gPiA+PiA+PiAyMDA4LzgvMTggQWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNv
bT4KPiA+ID4+ID4+Cj4gPiA+Pj4gPj4gPiBQZXRlciBXYWxsZXIsIE1vbiwgQXVnIDE4LCAyMDA4
IDE4OjQ2OjE0ICswMjAwOgo+ID4gPj4+PiA+PiA+ID4KPiA+ID4+Pj4gPj4gPiA+IChUaGUgc2Ft
ZSB0aGluZyBhcyBhYm92ZSkKPgo+IERpZCBpdCBhY3R1YWxseSBub3Qgd29yaz8KPgo+IC0tCj4g
TWFyY3VzIEdyaWVwCj4gR1BHIEtleSBJRDogMHg1RTk2ODE1Mgo+IOKAlOKAlAo+IGh0dHA6Ly93
d3cuYm9vaGF1bnQubmV0Cj4g15DXqi7PiM6/wrQKPgo=
