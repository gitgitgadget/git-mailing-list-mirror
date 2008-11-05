From: "Suraj N. Kurapati" <sunaku@gmail.com>
Subject: Re: [PATCH/RFC v2] git-add--interactive.perl: Answer questions with a single keypress
Date: Tue, 4 Nov 2008 22:31:19 -0800
Message-ID: <200811042231.19124.sunaku@gmail.com>
References: <200811042215.31147.sunaku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 07:32:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxbwY-0005EJ-7U
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 07:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbYKEGbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 01:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbYKEGbW
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 01:31:22 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:10238 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbYKEGbV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 01:31:21 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3767227rvb.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 22:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7wSKMMgyEao3ZQyPjMbo9PTKFP1G5v+CSB+5sNbsGD4=;
        b=MerDzk8AR6gGTlfmrxialn/tHIwBXPmL58KLnX+ZDZs7uKQvGkk93as9jY8s9cmOnn
         /xtHRg+DKjn5dAWrufcyoOba+zzuUYSnJhFuWb8Iha3/DClH/1KEHh/iq7OeMQnkHHkI
         Cu2g90d84ylgVKq8Jlz+fW1++05fRby+Jmwys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=sR2MEmhQldKrEzA9qqcn45aBqvYdTlJLMYGl/3/fbivxNIZE+pb+xX+BHPcO2oSyoZ
         szPaY4Kai4b1b5D/CvNtnHNEDdzykTlKTHCPXUwWQQ/ODMNawmGy2EsD1Q0ILMHc67Re
         iEL0qDhAECehrSZ2owwMj0l6s1qhgb6Dui4Sk=
Received: by 10.141.106.14 with SMTP id i14mr167551rvm.27.1225866680597;
        Tue, 04 Nov 2008 22:31:20 -0800 (PST)
Received: from yantram.localnet (adsl-76-221-202-142.dsl.pltn13.sbcglobal.net [76.221.202.142])
        by mx.google.com with ESMTPS id k2sm6252806rvb.1.2008.11.04.22.31.19
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Nov 2008 22:31:20 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.27-ARCH; KDE/4.1.2; i686; ; )
In-Reply-To: <200811042215.31147.sunaku@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100147>

QWxsb3dzIHRoZSB1c2VyIHRvIGFuc3dlciAnU3RhZ2UgdGhpcyBodW5rJyBxdWVzdGlvbnMgd2l0
aCBhCnNpbmdsZSBrZXlwcmVzcywganVzdCBsaWtlIGluIERhcmNzLiAgUHJldmlvdXNseSwgdGhl
IHVzZXIgd2FzCmZvcmNlZCB0byBwcmVzcyB0aGUgUmV0dXJuIGtleSBhZnRlciBldmVyeSBjaG9p
Y2UgdGhleSBtYWRlLgpUaGlzIHF1aWNrbHkgYmVjb21lcyB0aXJpbmcsIGJ1cmRlbnNvbWUgd29y
ayBmb3IgdGhlIGZpbmdlcnMuCgpTaWduZWQtb2ZmLWJ5OiBTdXJhaiBOLiBLdXJhcGF0aSA8c3Vu
YWt1QGdtYWlsLmNvbT4KLS0tCiBnaXQtYWRkLS1pbnRlcmFjdGl2ZS5wZXJsIHwgICAgNSArKysr
LQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZ2l0LWFkZC0taW50ZXJhY3RpdmUucGVybCBiL2dpdC1hZGQtLWludGVyYWN0aXZl
LnBlcmwKaW5kZXggYjAyMjNjMy4uYTgyNDk4NCAxMDA3NTUKLS0tIGEvZ2l0LWFkZC0taW50ZXJh
Y3RpdmUucGVybAorKysgYi9naXQtYWRkLS1pbnRlcmFjdGl2ZS5wZXJsCkBAIC04NzcsNiArODc3
LDggQEAgc3ViIHBhdGNoX3VwZGF0ZV9maWxlIHsKIAkkbnVtID0gc2NhbGFyIEBodW5rOwogCSRp
eCA9IDA7CiAKKwlyZXF1aXJlIFRlcm06OlJlYWRLZXk7CisJVGVybTo6UmVhZEtleTo6UmVhZE1v
ZGUoJ3JhdycpOwogCXdoaWxlICgxKSB7CiAJCW15ICgkcHJldiwgJG5leHQsICRvdGhlciwgJHVu
ZGVjaWRlZCwgJGkpOwogCQkkb3RoZXIgPSAnJzsKQEAgLTkyMCw3ICs5MjIsNyBAQCBzdWIgcGF0
Y2hfdXBkYXRlX2ZpbGUgewogCQkJcHJpbnQ7CiAJCX0KIAkJcHJpbnQgY29sb3JlZCAkcHJvbXB0
X2NvbG9yLCAiU3RhZ2UgdGhpcyBodW5rIFt5L24vYS9kJG90aGVyLz9dPyAiOwotCQlteSAkbGlu
ZSA9IDxTVERJTj47CisJCW15ICRsaW5lID0gVGVybTo6UmVhZEtleTo6UmVhZEtleSgwKTsKIAkJ
aWYgKCRsaW5lKSB7CiAJCQlpZiAoJGxpbmUgPX4gL155L2kpIHsKIAkJCQkkaHVua1skaXhde1VT
RX0gPSAxOwpAQCAtOTk4LDYgKzEwMDAsNyBAQCBzdWIgcGF0Y2hfdXBkYXRlX2ZpbGUgewogCQkJ
fQogCQl9CiAJfQorCVRlcm06OlJlYWRLZXk6OlJlYWRNb2RlKCdyZXN0b3JlJyk7CiAKIAlteSAk
bl9sb2ZzID0gMDsKIAlteSBAcmVzdWx0ID0gKCk7Ci0tIAoxLjYuMC4zCgoACg==
