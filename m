From: Robert Watson <robert.oo.watson@gmail.com>
Subject: Re: git-diff(1) broken
Date: Thu, 22 Sep 2005 12:40:49 +0100
Message-ID: <72499e3b0509220440f18dd13@mail.gmail.com>
References: <72499e3b05092203023413f778@mail.gmail.com>
	 <20050922100640.GG21019@pasky.or.cz>
Reply-To: Robert Watson <robert.oo.watson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5173_10163656.1127389249528"
X-From: git-owner@vger.kernel.org Thu Sep 22 13:41:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIPRi-0004pM-Np
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 13:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVIVLkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 07:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbVIVLkv
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 07:40:51 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:21359 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030262AbVIVLku (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 07:40:50 -0400
Received: by qproxy.gmail.com with SMTP id v40so43940qbe
        for <git@vger.kernel.org>; Thu, 22 Sep 2005 04:40:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:references;
        b=WSel4liPkCnVTATOZLcpVOSxCdq9qnsQiIkJp7lDiM8wbRpgbWHn2uA8FsJi+KFQUCwubD+q5y/w8gHFj1H5LpxykNzpXZ44iX1R/44ZKO9RIQFHm0AkilGhRmGElCvqPc45qO+j+/yXwO94YxhmOjAloskklsbg5kIvDFc0XFk=
Received: by 10.64.249.12 with SMTP id w12mr160599qbh;
        Thu, 22 Sep 2005 04:40:49 -0700 (PDT)
Received: by 10.64.203.14 with HTTP; Thu, 22 Sep 2005 04:40:49 -0700 (PDT)
To: pasky@suse.cz, git@vger.kernel.org
In-Reply-To: <20050922100640.GG21019@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9109>

------=_Part_5173_10163656.1127389249528
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 9/22/05, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Thu, Sep 22, 2005 at 12:02:00PM CEST, I got a letter
> where Robert Watson <robert.oo.watson@gmail.com> told me that...
> > Hi,
>
> Hi,
>
> > It looks like the man page of git-diff(1) is very broken.
>
> it was not very informative in 0.99.6, but it looks fine in the latest
> GIT. Could you please be more specific about what is broken on it?
>

Please see attached git-diff.1 file.  The table is not shown correctly.

Robertoo

------=_Part_5173_10163656.1127389249528
Content-Type: application/octet-stream; name="git-diff.1"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="git-diff.1"

LlwiR2VuZXJhdGVkIGJ5IGRiMm1hbi54c2wuIERvbid0IG1vZGlmeSB0aGlzLCBtb2RpZnkgdGhl
IHNvdXJjZS4KLmRlIFNoIFwiIFN1YnNlY3Rpb24KLmJyCi5pZiB0IC5TcAoubmUgNQouUFAKXGZC
XFwkMVxmUgouUFAKLi4KLmRlIFNwIFwiIFZlcnRpY2FsIHNwYWNlICh3aGVuIHdlIGNhbid0IHVz
ZSAuUFApCi5pZiB0IC5zcCAuNXYKLmlmIG4gLnNwCi4uCi5kZSBJcCBcIiBMaXN0IGl0ZW0KLmJy
Ci5pZSBcXG4oLiQ+PTMgLm5lIFxcJDMKLmVsIC5uZSAzCi5JUCAiXFwkMSIgXFwkMgouLgouVEgg
IkdJVC1ESUZGIiAxICIiICIiICIiCi5TSCBOQU1FCmdpdC1kaWZmIFwtIFNob3cgY2hhbmdlcyBi
ZXR3ZWVuIGNvbW1pdHMsIGNvbW1pdCBhbmQgd29ya2luZyB0cmVlLCBldGMuCi5TSCAiU1lOT1BT
SVMiCgoKXGZJZ2l0XC1kaWZmXGZSIFsgXC1cLWRpZmZcLW9wdGlvbnMgXSA8ZW50PnswLDJ9IFs8
cGF0aD4uLi5dCgouU0ggIkRFU0NSSVBUSU9OIgoKClNob3cgY2hhbmdlcyBiZXR3ZWVuIHR3byBl
bnRzLCBhbiBlbnQgYW5kIHRoZSB3b3JraW5nIHRyZWUsIGFuIGVudCBhbmQgdGhlIGluZGV4IGZp
bGUsIG9yIHRoZSBpbmRleCBmaWxlIGFuZCB0aGUgd29ya2luZyB0cmVlXCYuIFRoZSBjb21iaW5h
dGlvbiBvZiB3aGF0IGlzIGNvbXBhcmVkIHdpdGggd2hhdCBpcyBkZXRlcm1pbmVkIGJ5IHRoZSBu
dW1iZXIgb2YgZW50cyBnaXZlbiB0byB0aGUgY29tbWFuZFwmLgoKICAgIE51bWJlciBvZiBlbnRz
CiAgICAKICAgIE9wdGlvbnMKICAgIAogICAgV2hhdCdzIENvbXBhcmVkCiAgICAKICAgIFVuZGVy
bHlpbmcgY29tbWFuZAogICAgCiAgICAwCiAgICAKICAgIFwtCiAgICAKICAgIGluZGV4IGZpbGUg
YW5kIHdvcmtpbmcgdHJlZQogICAgCiAgICBnaXRcLWRpZmZcLWZpbGVzCiAgICAKICAgIDEKICAg
IAogICAgXC1cLWNhY2hlZAogICAgCiAgICBlbnQgYW5kIGluZGV4IGZpbGUKICAgIAogICAgZ2l0
XC1kaWZmXC1pbmRleAogICAgCiAgICAxCiAgICAKICAgIFwtCiAgICAKICAgIGVudCBhbmQgd29y
a2luZyB0cmVlCiAgICAKICAgIGdpdFwtZGlmZlwtaW5kZXgKICAgIAogICAgMgogICAgCiAgICBc
LQogICAgCiAgICB0d28gZW50cwogICAgCiAgICBnaXRcLWRpZmZcLXRyZWUKICAgIAouU0ggIk9Q
VElPTlMiCgouVFAKXC1cLWRpZmZcLW9wdGlvbnMKIFxmSVwtXC1kaWZmXC1vcHRpb25zXGZSIGFy
ZSBwYXNzZWQgdG8gdGhlIGdpdFwtZGlmZlwtZmlsZXMsIGdpdFwtZGlmZlwtaW5kZXgsIGFuZCBn
aXRcLWRpZmZcLXRyZWUgY29tbWFuZHNcJi4gU2VlIHRoZSBkb2N1bWVudGF0aW9uIGZvciB0aGVz
ZSBjb21tYW5kcyBmb3IgZGVzY3JpcHRpb25cJi4KCi5UUAo8cGF0aD4uLi4KVGhlIDxwYXRoPiBh
cmd1bWVudHMgYXJlIGFsc28gcGFzc2VkIHRvIGdpdFwtZGlmZlwtKiBjb21tYW5kc1wmLgoKLlNI
ICJBVVRIT1IiCgoKV3JpdHRlbiBieSBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAb3NkbFwmLm9y
Zz4KCi5TSCAiRE9DVU1FTlRBVElPTiIKCgpEb2N1bWVudGF0aW9uIGJ5IEp1bmlvIEMgSGFtYW5v
IGFuZCB0aGUgZ2l0XC1saXN0IDxnaXRAdmdlclwmLmtlcm5lbFwmLm9yZz5cJi4KCi5TSCAiR0lU
IgoKClBhcnQgb2YgdGhlIFxmQmdpdFxmUig3KSBzdWl0ZQoK
------=_Part_5173_10163656.1127389249528--
