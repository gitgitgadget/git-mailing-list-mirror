From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] l10n: TEAMS: update Ralf Thielow's email address
Date: Sat, 5 Mar 2016 11:06:37 +0800
Message-ID: <CANYiYbFDKqLXU5GNAjan4ZzK8JM4_yoxV5xLuVYWYPi5sMfEVA@mail.gmail.com>
References: <1457038105-4404-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 04:06:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac2YH-0005oO-M2
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 04:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759799AbcCEDGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2016 22:06:39 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38425 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759503AbcCEDGi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 22:06:38 -0500
Received: by mail-wm0-f49.google.com with SMTP id l68so12281668wml.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 19:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=3jN8Tr/eYCHgtz+/VCHRrXF8Wfn/YXGYT4eCrgadzWg=;
        b=Y8J1S4JIlfc5v/bNqJsRvrbC5bPH3KPuDgGR82ZprOGN6X09bMYJLrcfToyChIa6Tx
         zyPgp2twBhl2paFwI8rY5YwYtXuVDb0RXl9Yh6+fLRFEiaaeYrDXV6Nf2evL/v2dmXAr
         x9uz4nbjAg3lmynNLjCUhzmnuJwcretyd6ORhi+4194jBuvkQgVZ80aX1tTsqQuvfSQT
         6AnThT1svCm1pzckHk9Esl1fbrUhUUuyatk4GUyRGIPb3WDCImnX/F9wHMKrHznsRU8Y
         NogxV2CGibjkxwiFyk4PPQGb7BwJP3fOIX/KRB2N8w309LJdvV/x7VZhwIux7rO3gV/S
         fupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=3jN8Tr/eYCHgtz+/VCHRrXF8Wfn/YXGYT4eCrgadzWg=;
        b=JD5vuZ+9NeZWzzlAG4JG7FiM9S1yfaCPkSjamXSZoQrT+MK6JPS56DkDBG9+EAJd09
         NMf8zhAMh9QmrkSFadtAS0Ol8YeoF8zzSOybaQWX4fXwGZqSTbjayNHf9RCgv8nWd8lW
         2LCISFXuYa6FOMZKuHmKDq087ugZjjeCJYbc6awYF1w02j0pTkUG+engPMLWKzLiwkYS
         Pi/99dom29+8U67NQ4drgmby00muMh21Os7kcuJ5ULICmCzzriqNDD2n4yU30siqSZGr
         CiLaS/81ap/WGyQxfwBMum6xkozfE10xDSrw1jEbFuKizuhFOAHRTlh8wf7N3jw0mv7z
         HAkg==
X-Gm-Message-State: AD7BkJJHEapkN2duVs/frHhmrrFYwOHTw1oM+S9ZNU+3KVOu7wd6bf7uH/BejrldOEWxG1KpILB2JqJ5Q9jZ3A==
X-Received: by 10.28.138.149 with SMTP id m143mr1895849wmd.94.1457147197224;
 Fri, 04 Mar 2016 19:06:37 -0800 (PST)
Received: by 10.194.54.8 with HTTP; Fri, 4 Mar 2016 19:06:37 -0800 (PST)
In-Reply-To: <1457038105-4404-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288291>

That's fine.  Already pulled to git-po.

2016-03-04 4:48 GMT+08:00 Ralf Thielow <ralf.thielow@gmail.com>:
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/TEAMS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/TEAMS b/po/TEAMS
> index df12b58..56274ad 100644
> --- a/po/TEAMS
> +++ b/po/TEAMS
> @@ -11,7 +11,7 @@ Leader:               Alex Henrie <alexhenrie24@gma=
il.com>
>
>  Language:      de (German)
>  Repository:    https://github.com/ralfth/git-po-de
> -Leader:                Ralf Thielow <ralf.thielow@googlemail.com>
> +Leader:                Ralf Thielow <ralf.thielow@gmail.com>
>  Members:       Thomas Rast <tr@thomasrast.ch>
>                 Jan Kr=C3=BCger <jk@jk.gs>
>                 Christian Stimming <stimming@tuhh.de>
> --
> 2.8.0.rc0.159.g391b917
>



--=20
Jiang Xin
