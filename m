From: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@bitplanet.net>
Subject: Re: CGit and repository list
Date: Sun, 14 Sep 2008 13:22:12 -0400
Message-ID: <59ad55d30809141022r6973155fh933976d25ef4cf01@mail.gmail.com>
References: <19449377.post@talk.nabble.com>
	 <20080912145804.GF10544@machine.or.cz>
	 <8c5c35580809120810s69e8ec4fnf2a629d4cf575901@mail.gmail.com>
	 <200809121812.40920.johan@herland.net>
	 <20080912224817.GF10360@machine.or.cz>
	 <59ad55d30809141014x2160d50dqb8ac20b4c108b4e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Lars Hjemli" <hjemli@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Sep 14 19:23:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KevKD-0003ds-PC
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 19:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbYINRWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 13:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbYINRWO
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 13:22:14 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:2435 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbYINRWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 13:22:13 -0400
Received: by an-out-0708.google.com with SMTP id d40so164580and.103
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=xzpabJGm7/3+iNFxLZNPf4E6ouJrV9my6pmTkWEO82k=;
        b=QUR9M9mHLeSe4INpiBnrZ06C9TqrKsyDk5Jj3J5jpNL/QyMcvbiW66sxVWC2UCxugc
         28bKpjoph2DS2bnLx5OU0KqgbRo3FfzFXf+aX29eTy9XZqtL5f9Y6JJFYEgKUd+ODDTy
         4jtFL8CJLbEuKE2uzUDQw9dwtdLJrxpfRJdpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=HbwgfcXZvFR2KOJjuAp6aym8D2u7fkXDI9p2arU7tij/BVv7ObASxVwUNOZrCMD2La
         91ktzc8x9gqihIJJ8THCLItXtlS4fgWcHE2Lm3lMIL/wZ2hG+RyBBdT/rXKEqgHzO9Ua
         RqLR5fAda8/1vAimyFGZgVc+KvJfRt9fDdsug=
Received: by 10.100.111.5 with SMTP id j5mr7441087anc.102.1221412932154;
        Sun, 14 Sep 2008 10:22:12 -0700 (PDT)
Received: by 10.100.109.2 with HTTP; Sun, 14 Sep 2008 10:22:12 -0700 (PDT)
In-Reply-To: <59ad55d30809141014x2160d50dqb8ac20b4c108b4e1@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: bea179134b46ef92
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95849>

T24gU3VuLCBTZXAgMTQsIDIwMDggYXQgMToxNCBQTSwgS3Jpc3RpYW4gSMO4Z3NiZXJnIDxrcmhA
Yml0cGxhbmV0Lm5ldD4gd3JvdGU6Cj4gVGhlIHNjcmlwdCB3ZSdyZSB1c2luZyBvbiBmcmVlZGVz
a3RvcC5vcmcgaXMgc29tZXRoaW5nIGxpa2UgdGhpczoKPgo+ICBodHRwOi8vcGVvcGxlLmZyZWVk
ZXNrdG9wLm9yZy9+a3JoL2ZpbmQtcmVwb3Muc2gKPgo+IHdoaWNoIGlzbid0IHRvbyBzY2FyeS4g
IFdlIHJ1biBpdCBmcm9tIGEgY3JvbiBzY3JpcHQsIGV2ZXJ5IHRlbgo+IG1pbnV0ZXMgb3Igc28u
ICBJdCdzIG11Y2ggYmV0dGVyIHRoYW4gIHJlc2Nhbm5pbmcgYWxsIHRoZSBkaXJzIGV2ZXJ5Cj4g
dGltZSBzb21lYm9keSByZXF1ZXN0cyB0aGUgcmVwbyBsaXN0aW5nICh3ZSBoYXZlIGEgbG90IG9m
IHJlcG9zLCBjaGVjawo+IGNnaXQuZnJlZWRlc2t0b3Aub3JnKS4gIFdlIGhhdmUgbm8gbmVlZCBm
b3IgY2dpdCB0byB0byB0aGlzCj4gYXV0b21hdGljYWxseSBvbiBldmVyeSByZXF1ZXN0LCBhbmQg
SSBkb24ndCBzZWUgdXMgdXNpbmcgdGhhdCBmZWF0dXJlCj4gaWYgaXQgZ2V0cyBpbXBsZW1lbnRl
ZC4KCkEgZmVhdHVyZSB0aGF0IHdvdWxkIGJlIHVzZWZ1bCwgdGhvdWdoLCB3b3VsZCBiZSBzdXBw
b3J0IGZvciBsaXN0aW5nIGEKc3ViLXNldCBvZiByZXBvcy4uLiBmb3IgZXhhbXBsZSwgY2dpdC5m
cmVlZGVza3RvcC5vcmcvfmtyaCB3b3VsZCBsaXN0Cmp1c3QgbXkgcmVwb3MgYW5kIGNnaXQuZnJl
ZWRlc2t0b3Aub3JnL3hvcmcvZHJpdmVyIHdvdWxkIGxpc3QgYWxsIHRoZQpYLm9yZyBkcml2ZXIg
cmVwb3MuICBBbm90aGVyIGlkZWEgaXMgYSBqYXZhc2NyaXB0L2NzcyBmcm9udHBhZ2UgdGhhdApz
dXBwb3J0cyBmb2xkaW5nIHJlcG9zIGF3YXkgYWNjb3JkaW5nIHRvIHRoZSBncm91cHMgYW5kIHBv
c3NpYmx5CmNvbW1vbiBwYXRoIGVsZW1lbnRzIGluIHRoZSB1cmwuICBGb3IgZXhhbXBsZToKCiAg
WytdIEZyZWVkZXNrdG9wIFJlcG9zaXRvcmllcwogIFstXSBVc2VyIHJlcG9zaXRvcmllcwogICAg
ICBbK10gfmFnZGY1CiAgICAgIFsrXSB+YWh1aWxsZXQKICAgICAgLi4uCiAgICAgIFstXSB+a3Jo
CiAgICAgICAgICAgfmtyaC9ha2FtYXJ1CiAgICAgICAgICAgfmtyaC9idWd6aWxsYQogICAgICAg
ICAgIH5rcmgvY29tcGl6CiAgICAgIFstXSB+a3lsZQoKZXRjLgoKSnVzdCB0aHJvd2luZyBvdXQg
YSBjb3VwbGUgb2YgaWRlYXMuCgpjaGVlcnMsCktyaXN0aWFuCg==
