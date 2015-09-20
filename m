From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.6.0 round 2
Date: Mon, 21 Sep 2015 00:28:41 +0800
Message-ID: <CANYiYbH_gF=T6X_SNWm-vxBrcDFDdfzOHejNKPNoZAAa+KBONA@mail.gmail.com>
References: <CANYiYbHB=kNQnfpO5vuOQkZmmZs8V++NQBhER6t21saKC6OMmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Sun Sep 20 18:28:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdhTr-0002zA-Rv
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 18:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbbITQ2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 12:28:43 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33300 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbbITQ2m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 12:28:42 -0400
Received: by wiclk2 with SMTP id lk2so117599547wic.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=++O6GkGj8QLnOx096/KuF8wBOm+rJtEECdxRrBHrSVo=;
        b=0pdVwm0ExVVQXkYdlu6EZYiUdzICP07fxn4VoXkvYHtyC1g3wZUuKxbo9QyeRLNeuP
         3LxpZ6Ejb3i7wVPENDvLky7f5zkGdF3TQUUU5pSqGIcSdSZiZoWTirB2fcRIPxnRPOdc
         5wrKljkYa4V3IszM2MicFSMRJr16pXBexf3TYgHU5sPSS7k1DqSqaD37wED69MGDtKRV
         tNIt3Q53hnbRDaXdY5707FZyWaBZrrOZC5TCQzgfXVd0kB+uRLBZj43YJGunVj5B62JF
         QCpVwsu0EO29fozfMqLZf56QQw++ABt5B+TPovdPziUa707lbfYsSWwY+zHgSy14ANr+
         4NrQ==
X-Received: by 10.180.188.211 with SMTP id gc19mr9578838wic.81.1442766521607;
 Sun, 20 Sep 2015 09:28:41 -0700 (PDT)
Received: by 10.194.76.230 with HTTP; Sun, 20 Sep 2015 09:28:41 -0700 (PDT)
In-Reply-To: <CANYiYbHB=kNQnfpO5vuOQkZmmZs8V++NQBhER6t21saKC6OMmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278247>

2015-09-21 0:21 GMT+08:00 Jiang Xin <worldhello.net@gmail.com>:
> Hi Junio,
>
> Would you please pull the following git l10n updates.
>
> The following changes since commit f4d9753a89bf04011c00e943d85211906e86a0f6:
>
>   Update RelNotes to 2.6 to describe leftover bits since -rc2
> (2015-09-14 15:00:41 -0700)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po master
>
> for you to fetch changes up to 7e4bed9570f518b0d375db1109dcf797b3989cd3:
>
>   l10n: Update and review Vietnamese translation (2440t) (2015-09-16
> 07:06:03 +0700)
>
> ----------------------------------------------------------------
> Alex Henrie (1):
>       l10n: ca.po: update translation
>
> Jean-Noel Avila (2):
>       l10n: fr.po v1.6.0 round 1 (2441t)

The commit log was wrong, it should replace 1.6.0 with 2.6.0.
I think I should recreate it.

>       l10n: fr.po v2.6.0 round 2 (2440t)


-- 
Jiang Xin
