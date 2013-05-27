From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: fix french translation
Date: Mon, 27 May 2013 08:32:40 +0200
Message-ID: <CALWbr2xU58Ymq3xzAdomi_ND==ByHFfCNuZvEPDcsEcozRgoTg@mail.gmail.com>
References: <CAHtLG6ToiRT-EQMFhrR976=gat+8p0GFFyz+9qpqaq36=gVyGQ@mail.gmail.com>
	<CALWbr2w+ooM04nc79XKyVy48c_eH1AES5XgVDwwk+tFpmitLTw@mail.gmail.com>
	<CAHtLG6SfTi9XiqGDFhjR0DzLwSK0qVm0GL9-7boHEo=d2uCmvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 08:32:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgqzC-0007N6-RA
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 08:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848Ab3E0Gcm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 May 2013 02:32:42 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:48483 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab3E0Gcl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 May 2013 02:32:41 -0400
Received: by mail-qc0-f179.google.com with SMTP id e1so3338831qcx.38
        for <git@vger.kernel.org>; Sun, 26 May 2013 23:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=13DHkFkSItsxDuh7pHasQCF96WY2+ZHQfosktXc6Wuw=;
        b=WDcmP3gNj7tY9dmRPc5Rz/slyuwKferp4b4lm761OzAYPr7UtXNtQmQ4rA8YgvMaST
         btKlLaaMnBmjUaFLXbFSDTvuzkjYSyOk5AqxIAaYdecmKL9Wa/8qnz9vRMOxvu0S8BY4
         9fmugf+cqi/dOSVenzP8zpLQzAKyZoeuzsIbY2O+LHvOWTCtnEYEZrFeziZyL/bYzF7V
         VR1aqyK8OUjJkrNyEj47sOp/MNKdBPjt2uzBEpSCAeaTaO/X3bvIECs9cp4A4ckqF5Nl
         3yJ//G3XjjtD5iy2CydkfT1vWgoweJvJ7m9VDil78Sf9FTWD8u/bbbOyUhRsAfpLmaO5
         XxsQ==
X-Received: by 10.49.34.130 with SMTP id z2mr7167820qei.25.1369636360786; Sun,
 26 May 2013 23:32:40 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Sun, 26 May 2013 23:32:40 -0700 (PDT)
In-Reply-To: <CAHtLG6SfTi9XiqGDFhjR0DzLwSK0qVm0GL9-7boHEo=d2uCmvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225577>

Please do not forget to "reply to all".

On Mon, May 27, 2013 at 1:34 AM, =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@=
gmail.com> wrote:
>  git-gui/po/fr.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git b/git-gui/po/fr.po a/git-gui/po/fr.po
> index 0aff186..40441db 100644
> --- b/git-gui/po/fr.po
> +++ a/git-gui/po/fr.po
> @@ -1139,7 +1139,7 @@ msgstr "Standard (rapide, semi-redondant, liens=
 durs)"
>
>  #: lib/choose_repository.tcl:514
>  msgid "Full Copy (Slower, Redundant Backup)"
> -msgstr "Copie compl=C3=A8te (plus lent, sauvegarde redondante)"
> +msgstr "Copy compl=C3=A8te (plus lent, sauvegarde redondante)"

I still don't get why "Copie" is replaced by "Copy" ?
