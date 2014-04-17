From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [l10n] date: Note for translators not included in .po files
Date: Thu, 17 Apr 2014 14:27:28 +0800
Message-ID: <CANYiYbGqKOj6HRipQQWD5ZFUDHBNUFwj4hh-HoqsDbfStPy-oQ@mail.gmail.com>
References: <CAN7MxmV5tzvGTTG+aOL73fLhbXc7YeOWvYwLkMyad0=mvffMHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 08:27:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WafnL-0000Dq-Ek
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 08:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbaDQG1a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2014 02:27:30 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:55014 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183AbaDQG1a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2014 02:27:30 -0400
Received: by mail-wi0-f170.google.com with SMTP id bs8so2289958wib.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 23:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bW8FWEMZqf718LAws/1Q3VJz0S3W/WhZXkUYa8gFbAc=;
        b=diKcpC++/PHie9dHajCOUJiZ/4nWNS1gGz1Th+XbzextKeXvPpyQqiujo+MRe9xu7a
         26Rd8lm6qkj5AXKLigh2wJi/LmuDeYe2DQxqfxY6PEaPpXW1W0Jcbm1TAOCbVy2qzVvy
         mqVCVpHwzgH6Uk0fr+2CMnKINBdvXMfwDQ0N1ldAzXWJ4KbeSgA4TNjEQopmx5Ku3UVb
         vy6IjEWilMV/P80vlybwTI7qyu8L0Vmo9fJMhHOfIOmzR2yM0eeRUtVwV4sPXzDlicqO
         LVASsZTJ8Fc/mXIAkQHE0cRbz4E25AKfHy4iIQO9yxqWClNA1GVtyvG3s5skCyivnmWZ
         OUJQ==
X-Received: by 10.194.63.236 with SMTP id j12mr10498491wjs.5.1397716048745;
 Wed, 16 Apr 2014 23:27:28 -0700 (PDT)
Received: by 10.217.58.65 with HTTP; Wed, 16 Apr 2014 23:27:28 -0700 (PDT)
In-Reply-To: <CAN7MxmV5tzvGTTG+aOL73fLhbXc7YeOWvYwLkMyad0=mvffMHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246408>

2014-04-17 6:51 GMT+08:00 Brian Gesiak <modocache@gmail.com>:
> According to po/README, the l10n coordinator is responsible
> for updating the git.pot file. Would it be possible to update it base=
d
> on v1.9.2 and include the above comment?
>

I have pushed a polished "git.pot" to the maint branch of git-l10n/git-=
po.
It's based on Git v1.9.2, and you can get it from:

    https://github.com/git-l10n/git-po/blob/maint/po/git.pot

But if you want to translate for the upcoming Git v2.0.0, you can use
"git.pot" in the "pu" branch as a template. See:

    https://github.com/git-l10n/git-po/blob/pu/po/git.pot

> By the way, I am trying to organize contributors to produce a Japanes=
e
> localization for Core Git. Currently we have plenty of interest but
> only two contributors. If you or anyone you know would like to contri=
bute
> please visit the repository here: https://github.com/modocache/git-po=
-ja
>
> Thanks!
>
> - Brian Gesiak
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
=E8=92=8B=E9=91=AB

=E5=8C=97=E4=BA=AC=E7=BE=A4=E8=8B=B1=E6=B1=87=E4=BF=A1=E6=81=AF=E6=8A=80=
=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8
=E9=82=AE=E4=BB=B6: worldhello.net@gmail.com
=E7=BD=91=E5=9D=80: http://www.ossxp.com/
=E5=8D=9A=E5=AE=A2: http://www.worldhello.net/
=E5=BE=AE=E5=8D=9A: http://weibo.com/gotgit/
=E7=94=B5=E8=AF=9D: 18601196889
