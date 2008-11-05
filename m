From: "Suraj N. Kurapati" <sunaku@gmail.com>
Subject: Re: [PATCH/RFC v3] git add -i: Answer questions with a single keypress
Date: Wed, 5 Nov 2008 09:59:25 -0800
Message-ID: <200811050959.25824.sunaku@gmail.com>
References: <200811042215.31147.sunaku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 19:00:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxmgR-0004kG-5h
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 19:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbYKER7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 12:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbYKER7d
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 12:59:33 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:9885 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbYKER7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 12:59:32 -0500
Received: by rv-out-0506.google.com with SMTP id k40so121333rvb.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 09:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QbXX6CRsgvOYvCtGiTQFPBPGBzTKJ5s94SlivByq8uQ=;
        b=qSCiuBnN0dSM/h2MmQwY1THSEAyfDVmepPL6c70wRqUXgn3Mh49QrzKTQnTXqQ1lq/
         bSzIGUQUQZyC9Q3F2AWYN4MmT2KP6eA8gxmpbVSNmp0kLzoectpDSY3g2mvCAXUCZ3/G
         26AKEIN1d1z8UWx1V4yElpr4DECE6h9NrWyvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=PpThcvs5fSpd9PalbsLj1yDgEk4CvwZqV0/B48j/B/6XAzO9qYcA1n+Yf2LL1hn7uD
         l5Zk724HhAaXbVGndFGyszeXSDNwbMlktak08cjffgDgmsFHUxN6efQV/RzUdYeaEY7v
         dOcL2DRURXbC00df+O2ijpwQbueX0qi2dTR0o=
Received: by 10.141.162.1 with SMTP id p1mr565702rvo.293.1225907971887;
        Wed, 05 Nov 2008 09:59:31 -0800 (PST)
Received: from yantram.localnet (adsl-76-221-202-142.dsl.pltn13.sbcglobal.net [76.221.202.142])
        by mx.google.com with ESMTPS id l31sm469792rvb.2.2008.11.05.09.59.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 09:59:31 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.27-ARCH; KDE/4.1.2; i686; ; )
In-Reply-To: <200811042215.31147.sunaku@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100169>

QWxsb3dzIHRoZSB1c2VyIHRvIGFuc3dlciAnU3RhZ2UgdGhpcyBodW5rJyBxdWVzdGlvbnMgd2l0
aCBhCnNpbmdsZSBrZXlwcmVzcywganVzdCBsaWtlIGluIERhcmNzLiAgUHJldmlvdXNseSwgdGhl
IHVzZXIgd2FzCmZvcmNlZCB0byBwcmVzcyB0aGUgUmV0dXJuIGtleSBhZnRlciBldmVyeSBjaG9p
Y2UgdGhleSBtYWRlLgpUaGlzIHF1aWNrbHkgYmVjb21lcyB0aXJpbmcsIGJ1cmRlbnNvbWUgd29y
ayBmb3IgdGhlIGZpbmdlcnMuCgpTaWduZWQtb2ZmLWJ5OiBTdXJhaiBOLiBLdXJhcGF0aSA8c3Vu
YWt1QGdtYWlsLmNvbT4KLS0tCiBnaXQtYWRkLS1pbnRlcmFjdGl2ZS5wZXJsIHwgICAgNSArKysr
LQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZ2l0LWFkZC0taW50ZXJhY3RpdmUucGVybCBiL2dpdC1hZGQtLWludGVyYWN0aXZl
LnBlcmwKaW5kZXggYjAyMjNjMy4uYjcxOTA1ZSAxMDA3NTUKLS0tIGEvZ2l0LWFkZC0taW50ZXJh
Y3RpdmUucGVybAorKysgYi9naXQtYWRkLS1pbnRlcmFjdGl2ZS5wZXJsCkBAIC04NzcsNiArODc3
LDggQEAgc3ViIHBhdGNoX3VwZGF0ZV9maWxlIHsKIAkkbnVtID0gc2NhbGFyIEBodW5rOwogCSRp
eCA9IDA7CiAKKwlyZXF1aXJlIFRlcm06OlJlYWRLZXk7CisJVGVybTo6UmVhZEtleTo6UmVhZE1v
ZGUoJ2NicmVhaycpOwogCXdoaWxlICgxKSB7CiAJCW15ICgkcHJldiwgJG5leHQsICRvdGhlciwg
JHVuZGVjaWRlZCwgJGkpOwogCQkkb3RoZXIgPSAnJzsKQEAgLTkyMCw3ICs5MjIsNyBAQCBzdWIg
cGF0Y2hfdXBkYXRlX2ZpbGUgewogCQkJcHJpbnQ7CiAJCX0KIAkJcHJpbnQgY29sb3JlZCAkcHJv
bXB0X2NvbG9yLCAiU3RhZ2UgdGhpcyBodW5rIFt5L24vYS9kJG90aGVyLz9dPyAiOwotCQlteSAk
bGluZSA9IDxTVERJTj47CisJCW15ICRsaW5lID0gVGVybTo6UmVhZEtleTo6UmVhZEtleSgwKTsK
IAkJaWYgKCRsaW5lKSB7CiAJCQlpZiAoJGxpbmUgPX4gL155L2kpIHsKIAkJCQkkaHVua1skaXhd
e1VTRX0gPSAxOwpAQCAtOTk4LDYgKzEwMDAsNyBAQCBzdWIgcGF0Y2hfdXBkYXRlX2ZpbGUgewog
CQkJfQogCQl9CiAJfQorCVRlcm06OlJlYWRLZXk6OlJlYWRNb2RlKCdyZXN0b3JlJyk7CiAKIAlt
eSAkbl9sb2ZzID0gMDsKIAlteSBAcmVzdWx0ID0gKCk7Ci0tIAoxLjYuMC4zCgoACg==
