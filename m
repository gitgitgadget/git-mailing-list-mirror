From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 38 new messages
Date: Sat, 23 Aug 2014 20:29:03 +0800
Message-ID: <CANYiYbErvzbW_gMseJyQ8=AY8Z36TRkG2NorwxeARHi0oSsoCg@mail.gmail.com>
References: <1407261111-24839-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 14:29:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLARS-0008AQ-Fx
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 14:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbaHWM3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 08:29:06 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:62501 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbaHWM3F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 08:29:05 -0400
Received: by mail-we0-f172.google.com with SMTP id x48so11573939wes.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2014 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7O7w7eoqN7p9mmjKyRBVaAE7AYwmXKPIvM8EV4K2p7c=;
        b=zjLwURxqb5/Ilns+SZYbu6Sg4QyLgwNScwgnDGy/P8tqiKqg7xQodOT2jfFGS+z7hX
         IzOpkltXfc4yuPFpO3kOABAIoffyn1RS2uoruM1VveE51jK5aPumSz3pGopJM7y3o9DC
         DSFKm3G1Za3Rb7dbUU8lOKjpJe9+Q5G+B2ijqYRrxQA9WIpWZ5A0zWHbyYAtLHr4MWaR
         +XupTLm7nxSdrBHYxYhgyEnQpn16LH5O9vSp5Ye5j1pUB3ByGPD+beh3Fpl+7eR+w6tH
         MyyBYSiySPsYvOI51K7OhyEAN5sMn+SpT+y0GHszBvt4GnfmpkhFmVmh3ezj/c9gt5iD
         OVCQ==
X-Received: by 10.194.20.230 with SMTP id q6mr10933783wje.43.1408796943045;
 Sat, 23 Aug 2014 05:29:03 -0700 (PDT)
Received: by 10.194.58.200 with HTTP; Sat, 23 Aug 2014 05:29:03 -0700 (PDT)
In-Reply-To: <1407261111-24839-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255748>

Hi Ralf,

If it is ready for merge, let me know.  We have already missed the
v2.1.0 release (it's my fault), I don't want to miss the release of v2.1.1
again.  Alex contributed l10n for a new language (Catalan), and
I will send a new pull-request to Junio in a few days.

2014-08-06 1:51 GMT+08:00 Ralf Thielow <ralf.thielow@gmail.com>:
> Translate 38 new messages came from git.pot update in fe05e19
> (l10n: git.pot: v2.1.0 round 1 (38 new, 9 removed)).
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 131 ++++++++++++++++++++++++++++++---------------------------------
>  1 file changed, 62 insertions(+), 69 deletions(-)

-- 
Jiang Xin
