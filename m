From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Fixing typos
Date: Thu, 11 Apr 2013 15:44:49 +0530
Message-ID: <CALkWK0kwm-sFevWhZ1XwZGzozbJ_VwGkSt16FJtb67q10sqS+A@mail.gmail.com>
References: <5166291C.8070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Benoit Bourbie <benoit.bourbie@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 12:15:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQEXc-0008I3-93
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 12:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761402Ab3DKKPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 06:15:30 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:63415 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab3DKKP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 06:15:29 -0400
Received: by mail-ie0-f181.google.com with SMTP id 17so1748375iea.40
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 03:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sB7V4/S5a/ZyWnMb+j/6E+WzrVQ/i3o+WHFUtHRttY8=;
        b=LswuN4BSEJkQkim02WOiD5yKGzs9MwkvQRbp7meCW+ZOkaWCw4oZy1DH/E2utygEHc
         dbaFvno1Z7rpk+uj0A45qUS5zdFGtGDTQc4J2F8YMtLvot4kYKBLpy1MH8s7NGaED5tG
         spyGfj0pnEAWEgkxYP8+VLxWYCzMM/BIslLTj6a3qiqdP7sVhWS4rNXt/ip/Yd/Zmqej
         iuNTmlUktYcaLe9e35hIBrsO2LniKcNbnuUqS168YoEq/NhDp8nKOHDxt5OdTB9/qx6r
         z0GvY9FPLwuB40tg10k1nToZYY9LomG67xH0WvSvXOU+H4nVv7/3gF+mcTswCegxwRzD
         W0Nw==
X-Received: by 10.50.108.235 with SMTP id hn11mr3935611igb.107.1365675329468;
 Thu, 11 Apr 2013 03:15:29 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 11 Apr 2013 03:14:49 -0700 (PDT)
In-Reply-To: <5166291C.8070709@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220839>

Benoit Bourbie wrote:
> I apologize for being picky

There's nothing to apologize for.  These are good catches worth fixing.

> but that patch fixes 3 typos.

Please read Documentation/SubmittingPatches, particularly the parts about:
1. Sending patches inline using git send-email, as opposed to an attachment.
2. Signing off on your patch.

Cheers.
