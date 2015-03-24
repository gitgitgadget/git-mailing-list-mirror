From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzFdIGwxMG46IGRlLnBvOiB1c2UgImJsYSDigKYiIGluc3RlYWQgbw==?=
	=?UTF-8?B?ZiAiYmxhLi4uIg==?=
Date: Tue, 24 Mar 2015 18:34:16 +0100
Message-ID: <CAN0XMOLq5WLy2kQzm6kxuEk0=sxvREO-rqv8x56CPsY7JkR34A@mail.gmail.com>
References: <1426942357-5618-1-git-send-email-phillip.szelat@gmail.com>
	<CAN0XMO+JLfzkYwP5rKkT6RyLJ-XuH1k=9vKmi1X0xb1SjTOdvg@mail.gmail.com>
	<551190F2.10808@drmicha.warpmail.net>
	<20150324171044.GA4414@ralf-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phillip Sz <phillip.szelat@gmail.com>, git <git@vger.kernel.org>,
	Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	=?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:34:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSig-0005bq-4u
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933317AbbCXReT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 13:34:19 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:35280 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbbCXReS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:34:18 -0400
Received: by weoy45 with SMTP id y45so19513290weo.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wi7Iq8pqALHK4UulvXqw7zwwR783WnoAZOLzMjPwAYw=;
        b=Rm2RdyqsksgHferRzsVHeDqYEVuvjRf01YBh2hZKShk4Cek+Xj8FhliRDwRmwgrNCS
         KmJKwZVpZ6xuW+eOsyn713DWkJfPflC2RRXvLbUKOr5lHSDe1nAgwTdYvzQK96usHv0y
         a/Tu3m6EbpmFTIfmM8KeQmAvV7tWVd+f/YHpEHHFUIgrkWli7hJZLIHD/9OYkvpSjCGN
         QkkOg2irnCuIyvsuBjyCabqjmrKKvMWkyiclTB9uwrCI+xjZi8VksGkcd2vGdmHIhcEt
         FkGc4st8eYhXdvNYvlyHqwazXtWMlbSBdB0IFHJ9nfQFwlq6zhJcnOeJWh/8UnF+ANfV
         mJuA==
X-Received: by 10.194.76.69 with SMTP id i5mr10249701wjw.3.1427218456671; Tue,
 24 Mar 2015 10:34:16 -0700 (PDT)
Received: by 10.194.72.5 with HTTP; Tue, 24 Mar 2015 10:34:16 -0700 (PDT)
In-Reply-To: <20150324171044.GA4414@ralf-ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266206>

2015-03-24 18:10 GMT+01:00 Ralf Thielow <ralf.thielow@gmail.com>:
> Let's apply this instead.
>
> -- >8 --

>  #: builtin/notes.c:51
>  msgid "git notes copy --stdin [<from-object> <to-object>]..."
> -msgstr "git notes copy --stdin [<von-Objekt> <nach-Objekt>]..."
> +msgstr "git notes copy --stdin [<von-Objekt> <nach-Objekt>] ..."
>
>  #: builtin/remote.c:64
>  msgid "git remote update [<options>] [<group> | <remote>]..."
> -msgstr "git remote update [<Optionen>] [<Gruppe> | <externesRepository>]..."
> +msgstr "git remote update [<Optionen>] [<Gruppe> | <externesRepository>] ..."
>

Oops.
I'll remove the space in these two messages as the dots aren't
ellipsis obviously.
