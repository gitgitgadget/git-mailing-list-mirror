From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Document git-blame triple -C option
Date: Sat, 9 Jan 2010 00:28:52 +0530
Message-ID: <f3271551001081058l4fffa51t7ec52e9ce2f3166e@mail.gmail.com>
References: <f3271551001080610p62ef6abfge1c96648d1ea948f@mail.gmail.com> 
	<4B47510E.7040802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636284a3699501a047cabc821
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 19:59:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTK3S-00057Q-C8
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 19:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab0AHS7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 13:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753845Ab0AHS7V
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 13:59:21 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:45877 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab0AHS7U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 13:59:20 -0500
Received: by ywh6 with SMTP id 6so19748777ywh.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 10:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+tE+4LSzlPh8HisXBw9raUfLbKYz9pTsJ8/UDHW93q4=;
        b=ut9uWJy9YIfihq8KqziZg1XDOWlDk1f2P6pkwAWMkjVTc/8Jxxs5KPWpZFaAW9TJLr
         iLI6vYDYQ+MPG/3vlmd4scp5HmvaU4s8y7sgmijfW8Ap4r9z216Tku2BLLdnIc3SrVVe
         5iqfUbCq2NWYg1APjxEZxwQQE4CO6r06Pf1hA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Hc0Qamb4NJSUvChr7Ng3SWGqqRT96hOYkreNd0jssU0+Mve9HXqdrZu8zmSX8+usW0
         EdgUwkwAnTmRgrEkA+3DwX/pBF1NxC42/sixZTgh6B4G3DrIJRjxndJDffAP34OSMYF7
         2NluPgja8bqbSoj6QyACUnVGtrwJEPcfRULYA=
Received: by 10.90.195.3 with SMTP id s3mr2587293agf.104.1262977153327; Fri, 
	08 Jan 2010 10:59:13 -0800 (PST)
In-Reply-To: <4B47510E.7040802@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136464>

--001636284a3699501a047cabc821
Content-Type: text/plain; charset=ISO-8859-1

> Above you see why it is difficult to comment on attached patches.
> They're not included!

I'm sorry, but I'm behind a HTTP proxy, and GMail mangles up patches.
I'm left with no choice but to attach the patches.

> You re-wrapped the existing documentation. Please don't do that, because
> it makes it difficult to spot what you really changed.

Okay. Corrected.

> It seems you added one sentence. Please don't use "thrice" for "three
> times", that is very old English and sounds funny.

Okay. I've also modified the second line (what happens when the option
is given twice) for clarity.

--001636284a3699501a047cabc821
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Document-git-blame-triple-C-option.patch"
Content-Disposition: attachment; 
	filename="0001-Document-git-blame-triple-C-option.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g47bpgrp0

RnJvbSAzNzE3MDVmNjQ1NzZmZjdiOGRjODJiZWExOWM3MTRjZTMyMDA5N2I5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1rdW1hciBSYW1hY2hhbmRyYSA8YXJ0YWdub25AZ21haWwu
Y29tPgpEYXRlOiBTYXQsIDkgSmFuIDIwMTAgMDA6MTg6MDcgKzA1MzAKU3ViamVjdDogW1BBVENI
IHYyXSBEb2N1bWVudCBnaXQtYmxhbWUgdHJpcGxlIC1DIG9wdGlvbgoKZ2l0LWJsYW1lIC1DQ0Mg
aXMgZXhwbGFpbmVkIGluIGJ1aWxpbi1ibGFtZS5jIGxpbmUgMjE3MSwgYnV0IGlzCnVuZXhwbGFp
bmVkIGluIHRoZSBkb2N1bWVudGF0aW9uLiBUaGlzIHBhdGNoIGZpeGVzIHRoYXQuCgpTaWduZWQt
b2ZmLWJ5OiBSYW1rdW1hciBSYW1hY2hhbmRyYSA8YXJ0YWdub25AZ21haWwuY29tPgotLS0KIERv
Y3VtZW50YXRpb24vYmxhbWUtb3B0aW9ucy50eHQgfCAgICA2ICsrKystLQogRG9jdW1lbnRhdGlv
bi9naXQtYmxhbWUudHh0ICAgICB8ICAgIDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYmxhbWUt
b3B0aW9ucy50eHQgYi9Eb2N1bWVudGF0aW9uL2JsYW1lLW9wdGlvbnMudHh0CmluZGV4IDE2MjVm
ZmMuLjQ4MzNjYWMgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vYmxhbWUtb3B0aW9ucy50eHQK
KysrIGIvRG9jdW1lbnRhdGlvbi9ibGFtZS1vcHRpb25zLnR4dApAQCAtOTgsOCArOTgsMTAgQEAg
Y29tbWl0LgogCWZpbGVzIHRoYXQgd2VyZSBtb2RpZmllZCBpbiB0aGUgc2FtZSBjb21taXQuICBU
aGlzIGlzCiAJdXNlZnVsIHdoZW4geW91IHJlb3JnYW5pemUgeW91ciBwcm9ncmFtIGFuZCBtb3Zl
IGNvZGUKIAlhcm91bmQgYWNyb3NzIGZpbGVzLiAgV2hlbiB0aGlzIG9wdGlvbiBpcyBnaXZlbiB0
d2ljZSwKLQl0aGUgY29tbWFuZCBhZGRpdGlvbmFsbHkgbG9va3MgZm9yIGNvcGllcyBmcm9tIGFs
bCBvdGhlcgotCWZpbGVzIGluIHRoZSBwYXJlbnQgZm9yIHRoZSBjb21taXQgdGhhdCBjcmVhdGVz
IHRoZSBmaWxlLgorCXRoZSBjb21tYW5kIGFkZGl0aW9uYWxseSBsb29rcyBmb3IgY29waWVzIGZy
b20gb3RoZXIKKwlmaWxlcyBpbiB0aGUgY29tbWl0IHRoYXQgY3JlYXRlcyB0aGUgZmlsZS4gV2hl
biB0aGlzCisJb3B0aW9uIGlzIGdpdmVuIHRocmVlIHRpbWVzLCB0aGUgY29tbWFuZCBhZGRpdGlv
bmFsbHkKKwlsb29rcyBmb3IgY29waWVzIGZyb20gb3RoZXIgZmlsZXMgaW4gYW55IGNvbW1pdC4K
ICsKIDxudW0+IGlzIG9wdGlvbmFsIGJ1dCBpdCBpcyB0aGUgbG93ZXIgYm91bmQgb24gdGhlIG51
bWJlciBvZgogYWxwaGFudW1lcmljIGNoYXJhY3RlcnMgdGhhdCBnaXQgbXVzdCBkZXRlY3QgYXMg
bW92aW5nCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2dpdC1ibGFtZS50eHQgYi9Eb2N1bWVu
dGF0aW9uL2dpdC1ibGFtZS50eHQKaW5kZXggOGM3YjdiMC4uYjc4NjQ3MSAxMDA2NDQKLS0tIGEv
RG9jdW1lbnRhdGlvbi9naXQtYmxhbWUudHh0CisrKyBiL0RvY3VtZW50YXRpb24vZ2l0LWJsYW1l
LnR4dApAQCAtOSw3ICs5LDcgQEAgU1lOT1BTSVMKIC0tLS0tLS0tCiBbdmVyc2VdCiAnZ2l0IGJs
YW1lJyBbLWNdIFstYl0gWy1sXSBbLS1yb290XSBbLXRdIFstZl0gWy1uXSBbLXNdIFstcF0gWy13
XSBbLS1pbmNyZW1lbnRhbF0gWy1MIG4sbV0KLSAgICAgICAgICAgIFstUyA8cmV2cy1maWxlPl0g
Wy1NXSBbLUNdIFstQ10gWy0tc2luY2U9PGRhdGU+XQorCSAgICBbLVMgPHJldnMtZmlsZT5dIFst
TV0gWy1DXSBbLUNdIFstQ10gWy0tc2luY2U9PGRhdGU+XQogCSAgICBbPHJldj4gfCAtLWNvbnRl
bnRzIDxmaWxlPiB8IC0tcmV2ZXJzZSA8cmV2Pl0gWy0tXSA8ZmlsZT4KIAogREVTQ1JJUFRJT04K
LS0gCjEuNi41Cgo=
--001636284a3699501a047cabc821--
