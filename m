From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: importance of .git extension for bare repos
Date: Thu, 16 Feb 2012 09:38:08 +0800
Message-ID: <CALUzUxqEirjnCBHt28dwcgTBqC+u0wydNsnVR1rgyGG0-R_M1w@mail.gmail.com>
References: <jhhkn8$a0t$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 02:38:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxqJ5-0001s8-FQ
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 02:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078Ab2BPBia convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 20:38:30 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:40051 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770Ab2BPBiJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2012 20:38:09 -0500
Received: by werb13 with SMTP id b13so1012778wer.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 17:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8G73OOYE9jaPVJSRvyj1LEpkVFnRCmZPSuz5byGCHXg=;
        b=c74crlV61InbMWrGn4Z6Q7LXDakk+4OHCUhBVHKb3Yt9dBSrr8YyANXeqAHmz0eSZJ
         TmEZ/xeulThSkivxMEBRP1iyI1GIPEW28mQ974wrfCiIms2FonSrxZS/+Pwn6ZG113S5
         yD2r+LmW/hSNNdvU5LmeqMCobGlDC9Im/L9No=
Received: by 10.180.107.68 with SMTP id ha4mr866453wib.9.1329356288540; Wed,
 15 Feb 2012 17:38:08 -0800 (PST)
Received: by 10.223.89.15 with HTTP; Wed, 15 Feb 2012 17:38:08 -0800 (PST)
In-Reply-To: <jhhkn8$a0t$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190871>

I don't believe its significant to git itself, it's just a convention
for us humans.

--=20
Cheers,
Ray Chuan


On Thu, Feb 16, 2012 at 9:04 AM, Neal Kreitzinger <neal@rsss.com> wrote=
:
> I have a user who has created bare repos without naming them with the=
 .git
> extension. =A0As a result, the file paths are MYBARE/config instead o=
f
> MYBARE.git/config, etc. =A0Is this a supported naming convention for =
bare
> repos in git.git, or is it going to have some problems?
>
> v/r,
> neal
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
