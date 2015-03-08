From: Amate Yolande <yolandeamate@gmail.com>
Subject: Re: Delivery Status Notification (Failure)
Date: Sun, 8 Mar 2015 01:36:51 +0100
Message-ID: <CAFAMDXaVZy+XNbNtWs=N1vqmfMp+gg5T0JM5+7prrPxM9v7COg@mail.gmail.com>
References: <CAFAMDXb-_8WAMw7qOdAyJQKuLwtg+kAYOJO7xivCq7OTMyB26Q@mail.gmail.com>
	<047d7b2ed8ab924fe60510bc0ea0@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 01:36:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUPDF-0001vz-UV
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 01:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbbCHAgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 19:36:53 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37196 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbCHAgw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 19:36:52 -0500
Received: by wibhm9 with SMTP id hm9so11772704wib.2
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 16:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1x1mzVc4v5PlQCKt2hdlMUk0/xBuwLqQtYFlFnSGKO4=;
        b=OzdyRWya7DxMRjzl9MuhxxHvoydLMj85H1NreK07y0WM7ysaVyrH50cNhcLGfQBa0q
         BDTLodGI07d2R2Z/Usp21oCV7FgSCvVjR+WugGexCGWt254yiKMkUNYbyaKLr1zGzYD/
         Eychc3qFUiSUn9aahzcdGxPPFF1cYxoHkBdXYXMeInbvmR8WaMqBwjh+vt10XS6Y/ngc
         1mjIC8qkYUU2zJbROMn+hRII5d8xXi9lQQwo61QRaqkQNgfsJRnKqcrDeG+IiChQCxh3
         o7J5Ebe7aMalstWMdOTDzDkSzUFFs1fpD7xx7KeNnQ+ycSTy0k2ZLNPfxT5kcoyOtvNF
         1jrA==
X-Received: by 10.180.89.173 with SMTP id bp13mr88309335wib.91.1425775011420;
 Sat, 07 Mar 2015 16:36:51 -0800 (PST)
Received: by 10.27.206.135 with HTTP; Sat, 7 Mar 2015 16:36:51 -0800 (PST)
In-Reply-To: <047d7b2ed8ab924fe60510bc0ea0@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265022>

Hello Junio

          Thanks for the quick review and I apologize for the poorly
constructed code. I am
new to open source and git, and that was my first time coming across
the git source
code so I hoped to submit a working patch first, with the intention of
amending it later since
I did not really understand the requirements. With your clarification
and getting my self
familiar with the git commands, I hope to submit an accurate patch.

Thanks
