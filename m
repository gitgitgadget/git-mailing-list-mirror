From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: Fixed typo
Date: Wed, 2 Mar 2016 12:24:56 +0100
Message-ID: <CAN0XMOLTtnj=3+XHk1Q-TUkNxniemoARX5Zn0_WCySxK0R_9bA@mail.gmail.com>
References: <1456910001-907-1-git-send-email-christophhoopmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: christophhoopmann@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 02 12:25:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab4ts-0007QV-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 12:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098AbcCBLY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 06:24:59 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33177 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbcCBLY6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2016 06:24:58 -0500
Received: by mail-lb0-f169.google.com with SMTP id k15so5261386lbg.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 03:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=KuuAHn7RcVtealpRbpC0yK4FTMxtIpXOtKC/4VpzYSY=;
        b=MRZdYEiCtnDJsY0RFelIp37epMBCG7PV1Sj7U62E957gAxeqtruFqFetSA4UCr6Pv9
         mY3iMxw7sBUpZyMMty4hmsLow2ZdyDdF2PzQsgnvwx6mHNesG7rkEM376OGwYxo21bkV
         gycDGFOfOtgeXvVcmDYiM138td0buM2ywa8MbdCgTHYATqJDy1gdJRR4JuWr1+nzRxvJ
         otrpYH/213Zg8QjnNIBhFxYORb/9rA2rHp3pVC7+fntnb66rqncFXGdqbWav4j1SEkdR
         Xy21AfPhAtGn2fiYe7YTV9ynq1QnkkMr1n4ycOzM7CJROMhOBo1JYdBVaSxiZAumUvIH
         Hc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=KuuAHn7RcVtealpRbpC0yK4FTMxtIpXOtKC/4VpzYSY=;
        b=nFV/6eBUihqtHVoxSwo28OW4HKpEpmrt9tqkoClny4yifKGrPM9g6itvy9VR3OtPpK
         XWtMz/S7KDyj7nqEwinwvzT2d1S/U58hZtXIpU/sEFT4YjKdazEgxysFaxRRhPhIcFtI
         1wKQmEE+KsvX2f/OCEi/dwgtYvoZumZTfx07sqWcqhj0Fy6QrZIH3du94QLTXJ5euXHf
         a/aVnYjK+Rt6jS0vnuwsPu2ljByONouUImeUOPQiO4Vtm+o87NdKOVtTMr+pQ+nQO9sK
         C7R3X1S4irrnXIFnA8QQExSAJcT8YsLmEO6pMda6ed1NLjBtaX0bngOt5U/Pp6K7gbzs
         VTsA==
X-Gm-Message-State: AD7BkJJ0lRAfeZhOu/K9+/cXc1MItNF5EP7ABlhMlBYvarnm/wwktIhbc+n2nciGcLjqbZtYweefYi3ocqv6QA==
X-Received: by 10.112.160.3 with SMTP id xg3mr9863635lbb.67.1456917896996;
 Wed, 02 Mar 2016 03:24:56 -0800 (PST)
Received: by 10.25.18.207 with HTTP; Wed, 2 Mar 2016 03:24:56 -0800 (PST)
In-Reply-To: <1456910001-907-1-git-send-email-christophhoopmann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288122>

Please use imperative form in the commit subject, like "l10n: de.po: fi=
x typo".

2016-03-02 10:13 GMT+01:00  <christophhoopmann@gmail.com>:
> From: Christoph Hoopmann <christophhoopmann@gmail.com>
>
> ---

"Signed-off-by"-line is missing.

Thanks

>  po/de.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/de.po b/po/de.po
> index 8c5f05d..a6b7bf3 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -12079,7 +12079,7 @@ msgid ""
>  "option."
>  msgstr ""
>  "oder Sie sich unsicher sind, was das bedeutet, w=C3=A4hlen Sie eine=
n anderen "
> -"Namenmit der Option '--name'."
> +"Namen mit der Option '--name'."
>
>  #: git-submodule.sh:347
>  #, sh-format
> --
> 2.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
