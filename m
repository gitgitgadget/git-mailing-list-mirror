From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] l10: de.po: grammar fix
Date: Tue, 19 May 2015 14:46:07 -0700
Message-ID: <CAGZ79kYPhTK=tymEcB_YsYdNZvt0=sA4-Hon1SLwujV39W7fmA@mail.gmail.com>
References: <cover.1432025365.git.git@drmicha.warpmail.net>
	<2b4460dbf6abb15c4cd94d4c5c335cc9e8059ee7.1432025365.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 19 23:46:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YupLI-0001YN-Jo
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 23:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbbESVqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 17:46:24 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:35734 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbbESVqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 17:46:08 -0400
Received: by qceb3 with SMTP id b3so13294893qce.2
        for <git@vger.kernel.org>; Tue, 19 May 2015 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AeuCfgkul8dPo26JcX16S8K/pffjK67iPSjMhvRp72o=;
        b=Lo2yEFyVyTAKfwH6WqeVEuhNvcILB93XAcfjvUbcNH4PSijuyklhrjZZATzrqCniz5
         31G3yOCqRe4fUyjYWBdHE04UvSUI6q9e3FdZEuoJt1VvPeca8hyQqyl7hNdlNwKE/KOz
         hrSJRHNdSJ1dX9d1TP7Vhkz6XRT7DSfwjB0+Un10NlXVJOu3HthVaN/Ynb92ticDiSab
         NrjZ21QZq8VH5sYdsj6wJZNFI800OvuJBOh2uhGY2XB/7cPhK6h+UUmqZ2mOvvOb4jX8
         goVsn100kymCaP6g89kUsKd7/AVTcxNCS+KO1QzBDzqy/nKh/kgsXa+o0Qh4e1c4CEgS
         8pUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AeuCfgkul8dPo26JcX16S8K/pffjK67iPSjMhvRp72o=;
        b=f9uPBTjMln9Vxn7u8Uf1rJMSqboXT7mAEeMX0t0ULSu0hQhQ4ctWQBPaex5/S2iWSN
         YT7Cx1YaQJkwKDbOXqh+D98zqSh+qG0uHULkqi+fLDuBSxhZeT24joo8IebgAYLxGU5M
         VcLCAbUMB0pQzDIE/qfUn1WllnpjOKuEw1PhtMfqVV+DZlkro5U8K+D0IVBh2lkgGgsq
         OFbpQ0QYX/8Q4b7urztHOwdcvSzB2vH0LSnegDHzK59hGg8SuJ6c5tQIPG6M6BabOGCV
         lWixHzM/5YDmTLE/28WHc8LDF4At5ir3s/coSrlMPdwna/Lwau2eXwp0YxfiSjhPus9U
         6vwA==
X-Gm-Message-State: ALoCoQn2ygDNLrGUQk+cGRrGwMEYc18hFjKr+jA26XQQxjWnC+wM6XeBon8fydKPWAK6TuwJAryp
X-Received: by 10.140.96.202 with SMTP id k68mr23660125qge.102.1432071967817;
 Tue, 19 May 2015 14:46:07 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 19 May 2015 14:46:07 -0700 (PDT)
In-Reply-To: <2b4460dbf6abb15c4cd94d4c5c335cc9e8059ee7.1432025365.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269410>

On Tue, May 19, 2015 at 1:51 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  po/de.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/de.po b/po/de.po
> index 2feaec1..25258e3 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -10478,7 +10478,7 @@ msgstr ""
>  #: git-am.sh:142
>  msgid "Using index info to reconstruct a base tree..."
>  msgstr ""
> -"Verwende Informationen aus der Staging-Area, um einen Basisverzeichnis "
> +"Verwende Informationen aus der Staging-Area, um ein Basisverzeichnis "
>  "nachzustellen"

Waere es sinnvoll Staging-Area in Staging-Bereich umzubenennen?
"Staging" ist wohl ein eher fester Term mit dem man den index/staging area
assoziert, aber "Area" 'doesn't ring a bell for me'.



>
>  #: git-am.sh:157
> --
> 2.4.0.rc3.332.g886447c
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
