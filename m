From: "Deskin Miller" <deskinm@umich.edu>
Subject: Re: git svn bug?
Date: Thu, 2 Oct 2008 10:59:44 -0400
Message-ID: <86d4c5e00810020759n6f64f0acx575a1dede5d7aba8@mail.gmail.com>
References: <36C9BCCC-875A-4C65-98E2-0AD486FF8F61@gmail.com>
	 <20081002144916.GA3644@atjola.homenet>
Reply-To: deskinm@umich.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Ark Xu" <ark.work@gmail.com>, git@vger.kernel.org
To: "=?UTF-8?Q?Bj=C3=B6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 02 17:04:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPfp-0006Mu-8Z
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 17:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbYJBO7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbYJBO7r
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:59:47 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:58901 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbYJBO7q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:59:46 -0400
Received: by gxk9 with SMTP id 9so1447565gxk.13
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :sender:to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=srmTo7cojeZdBJPZYm0nld90TVLBUV7VpYJy3APy5OA=;
        b=C2goU/7XMDyO/rYEQUEMfrn76an7awV1QNWCDMznt+bCgRXk6GwVu2FiHy8yZo5vWD
         Qz6bUEZHeMlKwlgId7kLRHyrI91JOIJWGp2TFDlb9wohxSW5S2CPRMjsfYxfuXVoV9wn
         lvVXir8ApTNyVMm7KYSOBz1X2uSGdrhDH0rLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references:x-google-sender-auth;
        b=FypYhSQw3wI5/nY78KlnQGKhcZW8HeHG6fog6l5JlN/8oCGCZxjN4v72DN6dxyLA5P
         Q10tiYlzrd7/VTwbiV2NcqNTq7GMj0ncXnZ6hzeloopcSt6BQQHP1JRj+c5AU9S8DLTx
         QJ1REqfCBpR6PPTusbLGkOZB/GU3YCqyruaVU=
Received: by 10.142.238.9 with SMTP id l9mr3935385wfh.20.1222959584149;
        Thu, 02 Oct 2008 07:59:44 -0700 (PDT)
Received: by 10.142.157.13 with HTTP; Thu, 2 Oct 2008 07:59:44 -0700 (PDT)
In-Reply-To: <20081002144916.GA3644@atjola.homenet>
Content-Disposition: inline
X-Google-Sender-Auth: 14c880ab425aa36c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gVGh1LCBPY3QgMiwgMjAwOCBhdCAxMDo0OSBBTSwgQmrDtnJuIFN0ZWluYnJpbmsgPEIuU3Rl
aW5icmlua0BnbXguZGU+IHdyb3RlOgo+IE9uIDIwMDguMTAuMDIgMTY6NTA6NDUgKzA4MDAsIEFy
ayBYdSB3cm90ZToKPj4gICBOb3cgSSBnb3QgYSB0b3VnaCBwcm9ibGVtIHdoaWNoIHN0b3BwaW5n
IG1lIGZvciBhbnkgc3ZuIHJlbGF0ZWQKPj4gb3BlcmF0aW9ucy4gVGhlcmUgaXMgYSBmaWxlIGxv
ZzRqLnhtbCB0aGF0IGlzIHNvbWVob3cgc3RyYW5nZSBiZWNhdXNlCj4+IHdoZW4gSSBmZXRjaCBp
dCwgaSBnb3QgdGhlIGZvbGxvd2luZyBtZXNzYWdlOgo+Pgo+PiB0bXMtc2VydmljZS9zcmMvdGVz
dC9yZXNvdXJjZXMvbG9nNGoueG1sIGhhcyBtb2RlIDEyMDAwMCBidXQgaXMgbm90IGEKPj4gbGlu
ayBhdCAvb3B0L2xvY2FsL2Jpbi9naXQtc3ZuIGxpbmUgMzIzMC4KPj4gTSAgICAgdG1zLXNlcnZp
Y2Uvc3JjL3Rlc3QvcmVzb3VyY2VzL2xvZzRqLnhtbAo+Pgo+PiAgIEFuZCB0aGVuLCBhbGwgdGhl
IG9wZXJhdGlvbiB3aWxsIGxlYWQgdG8gOgo+PiBDaGVja3N1bSBtaXNtYXRjaDogYnJhbmNoZXMv
NS4zL3Rtcy1zZXJ2aWNlL3NyYy90ZXN0L3Jlc291cmNlcy9sb2c0ai54bWwKPj4gNTEwMzFjYmIw
ZTFhMmU4NzhlNGEzODM2Y2YwYmFhOWI4MGEwMzdhNQo+PiBleHBlY3RlZDogZmFiNmRhZWY5ZmMz
NTViOTM0MmUyNjA0N2Y1ZDAxNDEKPj4gICAgICBnb3Q6IDBlN2U5MDgxZDYwOGM4MGQyZGUwMzQw
YmE1Y2QxNjAwCj4KPiBXaGljaCBnaXQgdmVyc2lvbj8gQW5kIGlzIHlvdXIgL3RtcCBsYXJnZSBl
bm91Z2ggdG8gc3RvcmUgdGhhdCBmaWxlPwoKSSd2ZSBoYWQgaXNzdWVzIHNpbWlsYXIgdG8gdGhp
cyB3aGVuIEkgZGlkIEN0cmwrQyBkdXJpbmcgZ2l0IHN2bgpmZXRjaC4gIFByaW9yIHRvIHRoZSBp
c3N1ZSB5b3UndmUgcG9pbnRlZCBvdXQgcG9wcGluZyB1cCwgdGhvdWdoLCBJCmNvdWxkIGNvbXBh
cmUgdGhlIHJlcG8gYWdhaW5zdCBhbm90aGVyIGdpdCBzdm4gZmV0Y2ggd2hpY2ggd2FzIG5vdApp
bnRlcnJ1cHRlZCwgYW5kIHRoZSBjb21taXRzIHdvdWxkIGRpdmVyZ2UgYXQgc29tZSBwb2ludC4g
IFdoZW4gSQpsb29rZWQgaW50byB0aGUgY29tbWl0IHdoaWNoIGRpdmVyZ2VkLCB0aGUgY29tbWl0
IG9iamVjdCB3YXMgcHJlc2VudAppbiBteSBpbnRlcnJ1cHRlZCByZXBvLCBidXQgdGhlIGRpZmYg
d2FzIGVtcHR5LCB3aGlsZSBpdCB3YXMgbm9uLWVtcHR5CmluIHRoZSBvdGhlciByZXBvLgoKSXQg
c2VlbXMgdGhlcmUncyBhbiBpc3N1ZSB3aXRoIGdpdCBzdm4gZmV0Y2ggYXRvbWljYWxseSBmZXRj
aGluZyBhbmQKdXBkYXRpbmcgaXRzIHJlZnMuICBJJ3ZlIG5vdCBoYWQgdGltZSB0byBpbnZlc3Rp
Z2F0ZSBmdXJ0aGVyLCBidXQgSQpjZXJ0YWlubHkgd2FudCB0by4KCkluIHRoZSBtZWFudGltZSwg
SSB3b3JrZWQgYXJvdW5kIGl0IG9uIGluaXRpYWwgZmV0Y2ggZnJvbSBhIGJpZyBzdm4KcmVwb3Np
dG9yeSBieSB1c2luZyBnaXQgc3ZuIGZldGNoIC1yMTpuICwgYW5kIGluY3JlYXNpbmcgbiBpbgpp
bmNyZW1lbnRzLCBzbyBpdCBjb3VsZCBydW4gdG8gY29tcGxldGlvbiB3aXRob3V0IG1lIGludGVy
cnVwdGluZyBpdC4KClRoaXMgd2FzIHNlZW4gdXNpbmcgZ2l0IDEuNS40LjMgZnJvbSBVYnVudHUu
CgpEZXNraW4gTWlsbGVyCg==
