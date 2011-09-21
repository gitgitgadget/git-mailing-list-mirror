From: Kyle Neath <kneath@gmail.com>
Subject: Re: mac osx
Date: Tue, 20 Sep 2011 20:40:29 -0700
Message-ID: <CAFcyEtiexmE0WMif-eGHe5xMoYv7-8mdXos1qbQBH3g04z0sAg@mail.gmail.com>
References: <loom.20110921T002437-246@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tom smitts <tomsmitts@ymail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 05:40:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Dg7-0000Rk-ES
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 05:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435Ab1IUDku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 23:40:50 -0400
Received: from mail-gw0-f52.google.com ([74.125.83.52]:53975 "EHLO
	mail-gw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab1IUDku convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 23:40:50 -0400
Received: by gwb1 with SMTP id 1so1281190gwb.11
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 20:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=uF8kckKBp85O06eBeFRha59zeTbO/eFf6lIIfuYOX24=;
        b=Bhcliajw+/CYggvGOhdN/2Kks5vxAQ+XazL79mxaOCHMoMgA7PcvS4dr6EqoHG57yJ
         NpqqQnGJWWI+5LIxxOrc0mrkJ6WdtGU4LLKD3aV3ljbTpSIPQ0gpQeefSPOAIM3lS34+
         XiVYefjjfg2LasyTz9WSoHiBqazL2dh+8NFx4=
Received: by 10.68.13.36 with SMTP id e4mr666004pbc.379.1316576449158; Tue, 20
 Sep 2011 20:40:49 -0700 (PDT)
Received: by 10.142.233.14 with HTTP; Tue, 20 Sep 2011 20:40:29 -0700 (PDT)
In-Reply-To: <loom.20110921T002437-246@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181814>

On Tue, Sep 20, 2011 at 3:40 PM, tom smitts <tomsmitts@ymail.com> wrote=
:
> Do the git maintainers really think any mac users have
> =A0a clue which git install package to download? =A0You
> put some arcane chipset designation in the package
> =A0name! =A0Why make mac installers at all? =A0Mac users
> know their operating system number, e.g. 10.6.7,
> and that's all. =A0I doubt Windows users know any better.
> And I doubt you can find anywhere on a mac that says
> =A0i386 or whatever the heck the other dumb
> designation is.

Yikes! That's definitely not good. I'll see what we can do about updati=
ng
git-scm.com to point to a more reasonable installer for OSX. I haven't =
clicked
that link in a long time and had no idea it was so confusing.

I've created an issue so we can track it, if you'd like to follow along=
:
https://github.com/schacon/gitscm/issues/16

Kyle Neath
Director of Design, GitHub
