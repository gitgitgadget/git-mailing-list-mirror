From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [RFC] l10n: de.po: translate 29 new messages
Date: Fri, 6 Jul 2012 22:12:59 +0200
Message-ID: <CAN0XMOLW_S0Py+zeWaNVcMm18OLG4Kx6vU+gvS5yrVn1nVxWBQ@mail.gmail.com>
References: <1341335086-6767-1-git-send-email-ralf.thielow@gmail.com>
	<2021839.rMjHRWft8I@cs-pc>
	<CAN0XMO+R3+JiuHSZ0O46py2WbXVh8D2Z+f7t_xofsN6ZrFwnQQ@mail.gmail.com>
	<m28vf0aqb8.fsf@igel.home>
	<CAN0XMOJF8+iJqyiqvBxEHOVGMB17rPnO9Pnu29LY1fMDBopKGw@mail.gmail.com>
	<4FF72C70.1010202@drmicha.warpmail.net>
	<CAN0XMO+wz-2EGcX+KoLQLYDsG7Kz1T7YujxdJTUo1Yvqx=A4tg@mail.gmail.com>
	<20120706191829.GA20919@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Stimming <stimming@tuhh.de>, trast@student.ethz.ch,
	jk@jk.gs, worldhello.net@gmail.com, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 22:13:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnEto-0007F8-A2
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 22:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab2GFUNC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 16:13:02 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43144 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab2GFUNB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 16:13:01 -0400
Received: by wibhr14 with SMTP id hr14so1204914wib.1
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2G1OsbRQffXBExYuKvAJcbSGf6yF89xq1qpo48yURpw=;
        b=PGhiMGCfhBIHfFXaG5VlYtRCFn7E+t2mVOyHT/KpcvbbJ8x8GQabi98ef2vWtg8p2U
         6yUgWgBwExYLCA2zQx6tsEMlWpuGw8CIXrVsYN3YPdh9lfEiWDHYvIDborLUbE0SgXYr
         YLKr2r75lTUj5PwBY4RMk9GeOf7mhRAAmVo6dc3oshCWQktaiqJJVOr32kqisJRe3Dvm
         RJRPLK/3uuKjFktNMPBP/32LwpCu9/60/YWHyORUP6cAjrp1L3Kn8BubTQykecm7jNXc
         2po7qx6xMSuWhGdiEyu5wpbOpH8rYyZ4+e0WwudqBKGNteEaJKr7xsu108eR6Yly+dWD
         Olxg==
Received: by 10.216.211.19 with SMTP id v19mr10994210weo.89.1341605579780;
 Fri, 06 Jul 2012 13:12:59 -0700 (PDT)
Received: by 10.194.7.8 with HTTP; Fri, 6 Jul 2012 13:12:59 -0700 (PDT)
In-Reply-To: <20120706191829.GA20919@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201148>

> AFAIK it makes no senes to translate terms like "commit" to "Abzeichen" like it is used
> in git gui. I don't know *anybody* here in my IT business environment who uses this word
> or even would guess what it means.  Everyone is used to the Denglisch Version "committen"
> or "einchecken".

As far as i can see, "Abzeichen" is only used as translation for "Sign off".
"commit" is translated as "eintragen". So i don't see what your
problem is, actually.

If you have a problem caused by translation, please send a bug-report
to the GIT ML
that we are able to detect and fix them.

Thanks

Ralf
