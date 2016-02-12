From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] gitk: update German translation
Date: Fri, 12 Feb 2016 10:56:29 -0800
Message-ID: <CAGZ79kY8aSD-T-pcqeBBA-Rv9FwSeqAT2k2+OSyEsiPcF-AWOA@mail.gmail.com>
References: <1455302439-9290-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Christian Stimming <stimming@tuhh.de>,
	Paul Mackerras <paulus@samba.org>,
	Phillip Sz <phillip.szelat@gmail.com>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 19:56:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUItO-0006kY-JF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 19:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbcBLS4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 13:56:31 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33641 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbcBLS4a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 13:56:30 -0500
Received: by mail-ig0-f176.google.com with SMTP id y8so37256374igp.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 10:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OoLTirjssOydt//b5qiLPb/zoJs0veVNlHDrlK9QoNQ=;
        b=eF0t/BMzGdZfosFlqndP+9JdT6YG5R2eukZxoBg9wTreRZ6NgOKBl5pbr6RGE7pMsc
         rBKna5pGdl+sBIBFd46W2TedmQ08+DM1jeqKCJ1D/IUVrIS4TU6Xcxw3yU7nTHx0SGkV
         G+q6W70TlJ30kVoKc2/sA7cBlP7pXU3W2N8CfUdiLls1somCTVmxVR3bb0NHVdlYsCQv
         Rojf0xK82/lHHQ1bFqutH1ETL4XisMuNdOkTbKdbZQ/cTgXRE4nmqjr6pmuWT1ixJFok
         4uren0z3JbZxWRI/xqJupuSz6+1hy3oMYQ3s/N/LaYkELz1hfTyq3Jw40dbNVGexxWp3
         LC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OoLTirjssOydt//b5qiLPb/zoJs0veVNlHDrlK9QoNQ=;
        b=OHDiPDyWt35Xes1Ikt/PnNrms6YddR/+k1TspZjOkePCK7v09WHZSfu48tTJrvF396
         1MS61wjwcV6eK6T+/76lV8rAl+5GeHqqf2PilViblZy7JzuQGzsBzF1X5yz9JuUl4XAD
         6zkLK0ZstQXEy7QpLzG0JT4KH3e+FMrfaZZQFHDUVwLH6VYjVXSR8eaRoDHcroait3/X
         nAvd/eYzuelRvcBaBYDEKH6keyScR+z8BBmlnAwDrbKzbQDrUSEAjt+yUqKslVl7uOBG
         veRU7sCJlYk4tODm0XqIB+INs1kfedYp0FpsO0XW/Wtu2CzeQjdjYEPLc2mp1bz+CvcT
         Q6UQ==
X-Gm-Message-State: AG10YORiVmdHJV9B/zEEtkW6rZljSQhGo01SYZzQS90h/My9O5RLmH0B6Bt+BAUuaMgkIsO66/C9JwkQqBXFryMb
X-Received: by 10.50.176.195 with SMTP id ck3mr4859732igc.94.1455303389416;
 Fri, 12 Feb 2016 10:56:29 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 12 Feb 2016 10:56:29 -0800 (PST)
In-Reply-To: <1455302439-9290-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286069>

2016-02-12 10:40 GMT-08:00 Ralf Thielow <ralf.thielow@gmail.com>:
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> Note:
> Some translations in gitk may differ from translations in git-core
> since gitk uses another glossary which I tried to follow here.
>
>  po/de.po | 79 +++++++++++++++++++++++++++---------------------------=
----------
>  1 file changed, 33 insertions(+), 46 deletions(-)
>
> diff --git a/po/de.po b/po/de.po
> index d9ba405..bde749e 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -21,15 +21,15 @@ msgstr ""
>  msgid "Couldn't get list of unmerged files:"
>  msgstr "Liste der nicht zusammengef=C3=BChrten Dateien nicht gefunde=
n:"
>
>  #: gitk:212 gitk:2381
>  msgid "Color words"
> -msgstr ""
> +msgstr "W=C3=B6rter einf=C3=A4rben"
>
>  #: gitk:217 gitk:2381 gitk:8220 gitk:8253
>  msgid "Markup words"
> -msgstr ""
> +msgstr "W=C3=B6rter kennzeichnen"
>
>  #: gitk:324
>  msgid "Error parsing revisions:"
>  msgstr "Fehler beim Laden der Versionen:"

"Laden" (loading) is not the most correct translation for parsing,
but maybe good for the user. What about one of "analysieren, (zer)glied=
ern,
parsen, bestimmen" ?

Thanks,
Stefan
