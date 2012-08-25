From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] branch -v: align even when the first column is in UTF-8
Date: Sat, 25 Aug 2012 12:48:40 +0200
Message-ID: <CABPQNSYabHGzmEfukt1PzT=j3qa99fScDHRZqLZvLNv9cJKXag@mail.gmail.com>
References: <1345817872-7943-1-git-send-email-pclouds@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 12:50:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5DwT-0004YW-7K
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 12:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621Ab2HYKtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 06:49:21 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40356 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab2HYKtV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 06:49:21 -0400
Received: by vbbff1 with SMTP id ff1so2951455vbb.19
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=xxOXNAGfnoaQh0QQn+ZFbCECrRAmMiMeMs4BvIXdoH0=;
        b=CMhgbkjrjaXyY4GgbltqX2d/wsTbOBGj57ApQSvS28gEalcZB2GcqqiFQYYwA+4KMo
         jHnQrjGsRa10Gv7YXGUtNgg3KTj7S/CKNcvG5CiUw9b+UJ5liCZ5fR3QNp9vVRngN+Ad
         rhBNGlTB/qWjsbq4K0Eq596ttSAAXJa+3pFoIA1bsUVRIEXRvKkwVUBIL6WxqBja9P/Z
         Nr9JCtF+jCHKCcFz37KqZwBH3BCAUbpauc1f/NwWACCy7a1dBq8iejFFUto8oSyjNpdt
         4akDWuBRzbfVVhgvXoJZPK0d13Lnx9wNs136S49bk1QDKVSQqMJndAtbMFgiNokws+zq
         aFzA==
Received: by 10.221.0.138 with SMTP id nm10mr5992900vcb.38.1345891760176; Sat,
 25 Aug 2012 03:49:20 -0700 (PDT)
Received: by 10.58.237.166 with HTTP; Sat, 25 Aug 2012 03:48:40 -0700 (PDT)
In-Reply-To: <1345817872-7943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204271>

T24gRnJpLCBBdWcgMjQsIDIwMTIgYXQgNDoxNyBQTSwgTmd1eeG7hW4gVGjDoWkgTmfhu41jIER1
eSA8cGNsb3Vkc0BnbWFpbC5jb20+IHdyb3RlOgo+ICAxIHThuq1wIHRpbiDEkcOjIGLhu4sgdGhh
eSDEkeG7lWksIDUgxJHGsOG7o2MgdGjDqm0gdsOgbygrKSwgMyBi4buLIHjDs2EoLSkKCkh1aD8K
