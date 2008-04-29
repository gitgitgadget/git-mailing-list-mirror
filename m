From: "Russ Dill" <russ.dill@gmail.com>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 09:21:19 -0700
Message-ID: <f9d2a5e10804290921y5c961fc5g88d718c40a5ff037@mail.gmail.com>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
	 <alpine.LNX.1.00.0804281515480.19665@iabervon.org>
	 <200804282329.21336.henrikau@orakel.ntnu.no> <4816C26D.9010304@op5.se>
	 <f9d2a5e10804290009p17d291d5wf14e2bb58bedca63@mail.gmail.com>
	 <481718AF.8090000@docte.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: base64
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Henrik Austad" <henrikau@orakel.ntnu.no>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "=?ISO-8859-2?Q?Jurko_Gospodneti=E6?=" <jurko.gospodnetic@docte.hr>
X-From: git-owner@vger.kernel.org Tue Apr 29 18:30:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqsiL-0004yD-Gu
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 18:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758076AbYD2Q2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 12:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757621AbYD2Q2x
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 12:28:53 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:9241 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757484AbYD2Q2w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 12:28:52 -0400
Received: by yw-out-2324.google.com with SMTP id 5so49816ywh.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KSSYN+C4ksjtI7AUJltXZpdkjMRQwoe6g6dVXiIl9uI=;
        b=k5ZlLquvNTdnlMSXCHG6XCTyRCAMZw8BxuiXvknWODaXKMq3jsEvYTokDWSgXTmL/kj84gisH8UOUNrMVL05pF2fRDfA7+fguA3kdmPazWCRoDs3dEN0B2kPf6vG3f4FtpMogMqIzIpBpHl0Ct/bpQ2jO//21fZHu6fEFrFVxWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ag3K4/KF1lPw8ufH8hCiOwm26kx909n9Kqse3wyAJi+1NFR6D5cbk9EJxbQwIRDcmSCPqqu+7IGvA18htscLSiCurMInvpkusfu39CDJCI4DzdKQrnNNMocQcUFblB9X9Fx51000PcYbg5CwKwZIn7HvZspfjCTsuepkGo449wo=
Received: by 10.150.58.2 with SMTP id g2mr5279890yba.79.1209486080178;
        Tue, 29 Apr 2008 09:21:20 -0700 (PDT)
Received: by 10.150.228.20 with HTTP; Tue, 29 Apr 2008 09:21:19 -0700 (PDT)
In-Reply-To: <481718AF.8090000@docte.hr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80702>

T24gVHVlLCBBcHIgMjksIDIwMDggYXQgNTo0NiBBTSwgSnVya28gR29zcG9kbmV0aeYKPGp1cmtv
Lmdvc3BvZG5ldGljQGRvY3RlLmhyPiB3cm90ZToKPgo+ID4gSSB0aGluayB5b3UgYXJlIG1pc3Np
bmcgdGhlIHBvaW50LiBPbmUgb2YgdGhlIHBsdXNlcyBiZWhpbmQgb3JpZ2luYWxseQo+ID4gdXNp
bmcgU0hBLTEgYW5kIHRoZSBzaWduZWQgdGFncyBpcyB0aGF0IHRoZSBzeXN0ZW0gYXMgYSB3aG9s
ZSBpcwo+ID4gY3J5cHRvZ3JhcGhpY2FsbHkgc2VjdXJlLiBZb3UgY2FuIHZlcmlmeSBmcm9tIHRo
ZSBwdWJsaWMga2V5IG9mCj4gPiB3aG9ldmVyIG1hZGUgdGhlIHRhZyB0aGF0IHllcywgdGhpcyBy
ZWFsbHkgaXMgdGhlIHNvdXJjZSBhbmQgaGlzdG9yeQo+ID4gdGhleSB0YWdnZWQuCj4gPgo+Cj4g
ICBJIGFtIG5vdCByZWFsbHkgc3VyZSBJIGZvbGxvdyB0aGlzLi4uLiBob3cgY2FuIHlvdSAndmVy
aWZ5IGZyb20gdGhlIHB1YmxpYwo+IGtleSBvZiB3aG9ldmVyIG1hZGUgdGhlIHRhZycgdGhhdCB0
aGUgU0hBLTEgaGFzaCBpcyBjb3JyZWN0IT8gU0hBLTEgZG9lcyBub3QKPiBoYXZlIGFueXRoaW5n
IGRvIHdpdGggYW55IGV4dGVybmFsbHkgcHJvdmlkZWQga2V5cyBvciBoYXZlIEkgbWFuYWdlZCB0
byBnZXQKPiBzb21ldGhpbmcgY29uZnVzZWQgaGVyZT8KPgoKU29ycnkgZm9yIHRoZSBjb25mdXNp
b24sIGl0cyBhYm91dCB1c2luZyB0aGUgc2lnbmVkIHRhZyBhbmQgdGhlIFNIQS0xCm9mIHRoZSBw
YXJlbnQgY29tbWl0cywgYWxvbmcgd2l0aCB0aGVpciBhc3NvY2lhdGVkIHRyZWVzIGFuZCBibG9i
cyB0bwp2ZXJpZnkgdGhlIHNvdXJjZSBhbmQgaGlzdG9yeS4gSWYgeW91IGNhbid0IHRydXN0IHRo
ZSBzaWduZWQgdGFnLCBvcgphbGwgb2YgdGhlIFNIQS0xJ3MsIHlvdSBjYW4ndCB0cnVzdCB0aGUg
c291cmNlIGFuZCBoaXN0b3J5LgoKSG93ZXZlciwgYXMgbWFueSBzYWlkLCBJIGRvbid0IHRoaW5r
IHRoZXJlIGlzIGFueSByZWFzb24gdG8gbm90IHRydXN0ClNIQS0xIGlzIHRoZSBjb250ZXh0IG9m
IHNvdXJjZSBjb250cm9sLgo=
