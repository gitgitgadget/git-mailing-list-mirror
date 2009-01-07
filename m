From: "Vagmi Mudumbai" <vagmi.mudumbai@gmail.com>
Subject: Re: JGit vs. Git
Date: Wed, 7 Jan 2009 10:38:10 +0530
Message-ID: <a55cfe9d0901062108m7c6a5133o59ee955bba3ab018@mail.gmail.com>
References: <a55cfe9d0901052249v1461c70cp1d89e184cfc05eb9@mail.gmail.com>
	 <a55cfe9d0901052250k2be203dfvb0b437a523f2cecc@mail.gmail.com>
	 <alpine.DEB.1.00.0901062240240.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 06:09:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKQfh-0003aT-O3
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 06:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbZAGFIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 00:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbZAGFIN
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 00:08:13 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:46102 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbZAGFIM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 00:08:12 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2608115ywe.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 21:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=m2dcAc1QvkLkXhKjR7uVZ4yAhT3QnauRFy3nWMJYRD8=;
        b=X4hT6MNW0BRv33l8ff4KbiiH4zgipbWSOB9vZaN2Asuc+D7DU7Ni5mrfsRL9WUdgQL
         zkXdA2mpxlQTk+hyLkEKmdvspngVc6RsbUSKb2qJn9NF1DvgCstKeayhtZiUewlJaTbf
         snFi0qiE+QHF5s5oES8Mduu9dPYcmy5pOFkb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aBTqEq7r9dwuFW8WaxY09J0g4lS53X2tEBjk3tJml24yL1sWzcm+/1kNdbEfhkhnWK
         MsKtypn7rlxcnyb2vXgbUda80nxlv7v6A14ODzPEnzxw0AiI0E1luxfSB9vdgxxYrL4Z
         rDJm+EIfUq7wFqVU+unl+PUEOvX2pQg7vwt+I=
Received: by 10.65.225.17 with SMTP id c17mr16862579qbr.71.1231304890609;
        Tue, 06 Jan 2009 21:08:10 -0800 (PST)
Received: by 10.65.230.8 with HTTP; Tue, 6 Jan 2009 21:08:10 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901062240240.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104757>

SGksCgpAU3RlcGhlbgo+PiBPciB0aGluayBhYm91dCBleHRlbmRpbmcgdGhlIFJ1YnkgZ2VtIGdy
aXQgdG8gYWxzbyB1c2UgSkdpdC4gIFdoaWNoIHdvdWxkIGNlcnRhaW5seSBpbXByb3ZlIGdyaXQg
YW5kICBwcm9iYWJseSBoZWxwIGltcHJvdmUgSkdpdCBhbHNvLgpJIGp1c3Qgc3RhcnRlZCB3b3Jr
aW5nIG9uIHRoYXQuIEl0IHdpbGwgYmUgY2xvc2UgdG8gR3JpdCBsZXQgbWUgc2VlCmhvdyBmYXIg
SSBnZXQgd2l0aCBpdC4gSWYgeW91IGhhdmUgYW4gZXhpc3RpbmcgcmVwbyB0aGF0IHlvdSBoYXZl
CmFscmVhZHkgd29ya2VkIG9uLCBwbGVhc2UgZmVlbCBmcmVlIHRvIHNoYXJlIGl0LgoKVGhlIEpH
aXQgY29kZSBib3RoIHRlc3RzIGFuZCB0aGUgVUkgaXMgcXVpdGUgcmVhZGFibGUuCgpUaGFua3Mg
YSB0b24gZm9yIGFsbCB5b3VyIGhlbHAuIDotKQoKUmVnYXJkcywKVmFnbWkKCmh0dHA6Ly9ibG9n
LnZhZ21pbS5jb20KIlRlYWNoaW5nIGNoaWxkcmVuIHRvIHVzZSBXaW5kb3dzIGlzIGxpa2UgdGVh
Y2hpbmcgdGhlbSB0byBzbW9rZQp0b2JhY2Nv4oCUaW4gYSB3b3JsZCB3aGVyZSBvbmx5IG9uZSBj
b21wYW55IHNlbGxzIHRvYmFjY28uIiAtIFJpY2hhcmQKU3RhbGxtYW4K
