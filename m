From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 10/10] l10n: de.po: translate one new message
Date: Thu, 10 May 2012 07:17:55 +0800
Message-ID: <CANYiYbGn1Wq22ZHQLoPLouX8UT0W3_+yP4ADZRzJ+B+P_EJaBg@mail.gmail.com>
References: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
	<1336498425-17890-11-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de,
	git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 10 01:18:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSG8v-00088q-Dz
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 01:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611Ab2EIXR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 19:17:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36201 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab2EIXR4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 19:17:56 -0400
Received: by yhmm54 with SMTP id m54so876620yhm.19
        for <git@vger.kernel.org>; Wed, 09 May 2012 16:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=sK+x5aSfpNhact86uZa6m89INh/p0gQEdPXYdMUsdb8=;
        b=nQQI5uGqGJXqtgS+bE2oteis8hze6Yn3W/KQGVZqXLO90CkQdhRMybvzGtLVf2qWA+
         U5tlhs41eWczAJJBtUlmWjx+SoYUCw3Wzy1PO5lToTH0CvYkVvDXr5iGHFpIW7UMx4Zw
         wWESnbX3lr8473yIa57HicXvHW4zvPi3W9pE0Z75Lo7N7GEpEWn4jY42FEgy9y6GxQXe
         PGKh4gx/P1OexxQrXgvj1MHEriYhXQuY5xEBjrZ39b8dN3oCgWMBeGzeI4V8IptFSkRF
         inAEXWDyAy+C2dXOZBZR2fqI6DUfc3u1Zht+CzPyNOlOdKU4GLSl4hN7wjNdkyz/mpXb
         fklw==
Received: by 10.50.190.197 with SMTP id gs5mr1110755igc.37.1336605475525; Wed,
 09 May 2012 16:17:55 -0700 (PDT)
Received: by 10.50.134.102 with HTTP; Wed, 9 May 2012 16:17:55 -0700 (PDT)
In-Reply-To: <1336498425-17890-11-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197531>

2012/5/9 Ralf Thielow <ralf.thielow@googlemail.com>:
> -#: builtin/fetch.c:298
> +#: builtin/fetch.c:305
> =A0msgid "[new tag]"
> =A0msgstr "[neue Markierung]"
>
> -#: builtin/fetch.c:302
> +#: builtin/fetch.c:308
> =A0msgid "[new branch]"
> =A0msgstr "[neuer Zweig]"

A silly question, why not "[neue Zweig]"?

>
> -#: builtin/fetch.c:347
> +#: builtin/fetch.c:311
> +msgid "[new ref]"
> +msgstr "[neue Referenz]"


--=20
Jiang Xin
