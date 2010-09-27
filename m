From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-checkout(1) Manual Page
Date: Mon, 27 Sep 2010 12:18:09 -0700
Message-ID: <AANLkTi=on_oo9ipZQJXd1tmyS+1nf5L5_02e+3Atwyxq@mail.gmail.com>
References: <29C9CE22-0DB6-4B81-AD9E-E3F185A0201A@krankikom.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016363b87c6f4058404914297bc
To: Rainer Standke <rainer.standke@krankikom.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 21:18:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0JDh-0007az-Rd
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 21:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933415Ab0I0TSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 15:18:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48544 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933311Ab0I0TSb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 15:18:31 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o8RJIUVx018520
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 27 Sep 2010 12:18:30 -0700
Received: by iwn5 with SMTP id 5so4956894iwn.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 12:18:30 -0700 (PDT)
Received: by 10.231.183.134 with SMTP id cg6mr9453554ibb.197.1285615110063;
 Mon, 27 Sep 2010 12:18:30 -0700 (PDT)
Received: by 10.231.209.201 with HTTP; Mon, 27 Sep 2010 12:18:09 -0700 (PDT)
In-Reply-To: <29C9CE22-0DB6-4B81-AD9E-E3F185A0201A@krankikom.de>
X-Spam-Status: No, hits=-2.857 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157365>

--0016363b87c6f4058404914297bc
Content-Type: text/plain; charset=ISO-8859-1

Junio,
 as reported by Rainer.. Trivial patch attached if you want to use
that, or just do it yourself.

                         Linus

On Mon, Sep 27, 2010 at 11:37 AM, Rainer Standke
<rainer.standke@krankikom.de> wrote:
> Hello Mr. Torvalds,
>
> I am wondering if you might need to add 'does' to the following line in the manual:
> "When <paths> or --patch are given, git checkout not switch branches."
>
> It might then read:
> "When <paths> or --patch are given, git checkout does not switch branches."
>
> Respectfully,
>
> Rainer Standke

--0016363b87c6f4058404914297bc
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Fix-missing-does-in-man-page-for-git-checkout.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-missing-does-in-man-page-for-git-checkout.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gelpzjko0

RnJvbSA4Mzk2N2I5NWRkODJmYTBiZGNjNzJhODAxYzkzZTU5MWQwNTYwZTJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IE1vbiwgMjcgU2VwIDIwMTAgMTI6MTQ6NTcgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBGaXggbWlzc2luZyAnZG9lcycgaW4gbWFuLXBhZ2UgZm9yICdnaXQgY2hlY2tvdXQn
CgpSZXBvcnRlZC1ieTogUmFpbmVyIFN0YW5ka2UgPHJhaW5lci5zdGFuZGtlQGtyYW5raWtvbS5k
ZT4KU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRp
b24ub3JnPgotLS0KIERvY3VtZW50YXRpb24vZ2l0LWNoZWNrb3V0LnR4dCB8ICAgMTYgKysrKysr
KystLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9naXQtY2hlY2tvdXQudHh0IGIvRG9jdW1l
bnRhdGlvbi9naXQtY2hlY2tvdXQudHh0CmluZGV4IGY4OGU5OTcuLjIyZDM2MTEgMTAwNjQ0Ci0t
LSBhL0RvY3VtZW50YXRpb24vZ2l0LWNoZWNrb3V0LnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL2dp
dC1jaGVja291dC50eHQKQEAgLTQ1LDE0ICs0NSwxNCBAQCBzdWNjZXNzZnVsLgogCiAnZ2l0IGNo
ZWNrb3V0JyBbLS1wYXRjaF0gWzx0cmVlLWlzaD5dIFstLV0gPHBhdGhzcGVjPi4uLjo6CiAKLQlX
aGVuIDxwYXRocz4gb3IgYC0tcGF0Y2hgIGFyZSBnaXZlbiwgJ2dpdCBjaGVja291dCcgKm5vdCog
c3dpdGNoCi0JYnJhbmNoZXMuICBJdCB1cGRhdGVzIHRoZSBuYW1lZCBwYXRocyBpbiB0aGUgd29y
a2luZyB0cmVlIGZyb20KLQl0aGUgaW5kZXggZmlsZSBvciBmcm9tIGEgbmFtZWQgPHRyZWUtaXNo
PiAobW9zdCBvZnRlbiBhIGNvbW1pdCkuICBJbgotCXRoaXMgY2FzZSwgdGhlIGAtYmAgYW5kIGAt
LXRyYWNrYCBvcHRpb25zIGFyZSBtZWFuaW5nbGVzcyBhbmQgZ2l2aW5nCi0JZWl0aGVyIG9mIHRo
ZW0gcmVzdWx0cyBpbiBhbiBlcnJvci4gVGhlIDx0cmVlLWlzaD4gYXJndW1lbnQgY2FuIGJlCi0J
dXNlZCB0byBzcGVjaWZ5IGEgc3BlY2lmaWMgdHJlZS1pc2ggKGkuZS4gY29tbWl0LCB0YWcgb3Ig
dHJlZSkKLQl0byB1cGRhdGUgdGhlIGluZGV4IGZvciB0aGUgZ2l2ZW4gcGF0aHMgYmVmb3JlIHVw
ZGF0aW5nIHRoZQotCXdvcmtpbmcgdHJlZS4KKwlXaGVuIDxwYXRocz4gb3IgYC0tcGF0Y2hgIGFy
ZSBnaXZlbiwgJ2dpdCBjaGVja291dCcgZG9lcyAqbm90KgorCXN3aXRjaCBicmFuY2hlcy4gIEl0
IHVwZGF0ZXMgdGhlIG5hbWVkIHBhdGhzIGluIHRoZSB3b3JraW5nIHRyZWUKKwlmcm9tIHRoZSBp
bmRleCBmaWxlIG9yIGZyb20gYSBuYW1lZCA8dHJlZS1pc2g+IChtb3N0IG9mdGVuIGEKKwljb21t
aXQpLiAgSW4gdGhpcyBjYXNlLCB0aGUgYC1iYCBhbmQgYC0tdHJhY2tgIG9wdGlvbnMgYXJlCisJ
bWVhbmluZ2xlc3MgYW5kIGdpdmluZyBlaXRoZXIgb2YgdGhlbSByZXN1bHRzIGluIGFuIGVycm9y
LiAgVGhlCisJPHRyZWUtaXNoPiBhcmd1bWVudCBjYW4gYmUgdXNlZCB0byBzcGVjaWZ5IGEgc3Bl
Y2lmaWMgdHJlZS1pc2gKKwkoaS5lLiAgY29tbWl0LCB0YWcgb3IgdHJlZSkgdG8gdXBkYXRlIHRo
ZSBpbmRleCBmb3IgdGhlIGdpdmVuCisJcGF0aHMgYmVmb3JlIHVwZGF0aW5nIHRoZSB3b3JraW5n
IHRyZWUuCiArCiBUaGUgaW5kZXggbWF5IGNvbnRhaW4gdW5tZXJnZWQgZW50cmllcyBiZWNhdXNl
IG9mIGEgcHJldmlvdXMgZmFpbGVkIG1lcmdlLgogQnkgZGVmYXVsdCwgaWYgeW91IHRyeSB0byBj
aGVjayBvdXQgc3VjaCBhbiBlbnRyeSBmcm9tIHRoZSBpbmRleCwgdGhlCi0tIAoxLjcuMwoK
--0016363b87c6f4058404914297bc--
