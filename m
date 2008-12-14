From: "Li Frank" <lznuaa@gmail.com>
Subject: Re: Announce: TortoiseGit 0.1 preview version
Date: Sun, 14 Dec 2008 20:27:09 +0800
Message-ID: <1976ea660812140427y498d52edy6791eedad8a97585@mail.gmail.com>
References: <1976ea660812130033m2d54cc57tfe134fab0d687d71@mail.gmail.com>
	 <c115fd3c0812130621p5df742ffs98d69cd922ebc972@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: base64
To: "Tim Visher" <tim.visher@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 13:28:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBq5G-00049s-A2
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 13:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbYLNM1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 07:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYLNM1M
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 07:27:12 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:53888 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbYLNM1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 07:27:11 -0500
Received: by yx-out-2324.google.com with SMTP id 8so963122yxm.1
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 04:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eIoe5F7MNHqfqL2KkT34tKnQvq7c8fsKEv76iPiBTA4=;
        b=LqX8k0sD36KtI2EccTeIO/bwdo9ChN5PN6Tzh+ZfWvyv6BqX7z4Fe8dT6yjci+KMmS
         uUMIwC0PNYxrqO/sUw7LkxiCJ3s5o5Zxh6DZE2mi+fOKRJX+Zad3Dz9+3OGNEUA342qY
         1xCVHJY7sF4gAOXVXtl3T9OayV+CMwadCdzE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JwKMqJJGBSw0soePQokBE5/BJoqpGGlHbkxiVcze4dXlENKnbUU2SvzPQH83kgdeEq
         oGNLNouvr5Nbp2XWR5LpuaRmSd+kLqQKqIzqXZ42nulPD07C6GCE3jTlKORSqQ3eDcys
         duhMlgie9p1M8/tV1DuzeDwDrDjRfrzpu3Aw4=
Received: by 10.150.155.13 with SMTP id c13mr10414763ybe.122.1229257629870;
        Sun, 14 Dec 2008 04:27:09 -0800 (PST)
Received: by 10.151.134.2 with HTTP; Sun, 14 Dec 2008 04:27:09 -0800 (PST)
In-Reply-To: <c115fd3c0812130621p5df742ffs98d69cd922ebc972@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103076>

VGhhbmsgeW91IGZvciBpbnRlcmVzdGluZyB0aGlzIHByb2plY3QuIFRoaXMgcmVsZWFzZSBpcyB2
ZXJ5IGVhcmx5IHN0YWdlLgpXZWNsb21lIGNvbnRyaWJ1dGUgYW55dGhpbmcsIGluY2x1ZGluZyBj
b2RpbmcsIHRlc3RpbmcsIGRvY3VtZW50IGFuZCBzbyBvbi4KCjIwMDgvMTIvMTMgVGltIFZpc2hl
ciA8dGltLnZpc2hlckBnbWFpbC5jb20+Ogo+IE9uIFNhdCwgRGVjIDEzLCAyMDA4IGF0IDM6MzMg
QU0sIMDu1scgPGx6bnVhYUBnbWFpbC5jb20+IHdyb3RlOgo+Cj4+IFRvcnRvaXNlR2l0IGlzIHBv
cnRpbmcgZnJvbSBUb3J0b2lzZVNWTi4KPgo+IFRoYW5rcyBzbyBtdWNoIGZvciB0aGlzIQo+Cj4g
TXkgdGVhbSBhbmQgSSB3ZXJlIGp1c3QgdGFsa2luZyBhYm91dCBob3cgdGhlIGJpZ2dlc3QgYmFy
cmllciB0byBlbnRyeQo+IGF0IHRoaXMgcG9pbnQgZm9yIF9zb21lXyBvZiB1cyBoYXMgYmVlbiB0
aGUgbGFjayBvZiBhIGdyZWF0IHRvb2wgbGlrZQo+IFRvcnRvaXNlIGZvciBHaXQuICBNeSBvcGlu
aW9uIHdhcyB0aGF0IHNvbWVvbmUgd291bGQgc29vbiB3cml0ZSBpdC4KPiBBbmQgbG8tYW5kLWJl
aG9sZCwgaGVyZSBpdCBpcyEKPgo+IEknbGwgbG9vayBmb3J3YXJkIHRvIHdhdGNoaW5nIHRoaXMg
cHJvZ3Jlc3MsIGFuZCBjb250aW51ZSBoYXBwaWx5Cj4gdXNpbmcgbXkgY2xpIHZlcnNpb24gdGhl
IHNhbWUuCj4KPiAtLQo+Cj4gSW4gQ2hyaXN0LAo+Cj4gVGltbXkgVi4KPgo+IGh0dHA6Ly9idXJu
aW5nb25lcy5jb20vCj4gaHR0cDovL2ZpdmUuc2VudGVuYy5lcy8gLSBTcGVuZCBsZXNzIHRpbWUg
b24gZS1tYWlsCj4K
