From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 11 Dec 2013 22:38:20 -0500
Message-ID: <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 04:39:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqx79-0005VZ-5w
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 04:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364Ab3LLDim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 22:38:42 -0500
Received: from mail-vb0-f52.google.com ([209.85.212.52]:40192 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3LLDil (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 22:38:41 -0500
Received: by mail-vb0-f52.google.com with SMTP id p5so2335416vbn.11
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 19:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L/NutwL2Cn/+iL+KRJiA7Htz4108xND9oLZiD2Uqu+Q=;
        b=Zmr1ykaMYDRyvrBrVZIvCZ89J/0ANzhcuSm/Aw0QWnlO4sBr7oBTBluC4tNDKiOUKr
         cN5E2coGrkWJmtu/MGvZBDihYcJbhspUIFBFlVwJEAWI3wcho7ljL5O2L52CsRagzb5G
         jUXzO4+pJm2/VQz9G6WVNTgUmshzd3aT29JGo7d83UVePS5WnDkhoB5zk1isHMhI6dE+
         aNjOuQODl5fmZtWFGmWcHPw/BYM1wjyPdqCpZZd2/72mEJ8FVNbhRdXKMwvARoJNryxd
         bYyPSL1UGDBl9qM7HJlxapaVEgIewR7UWKfogRv2ZXDGF82RvdZirpcSoMVtESIQ1kJo
         f0Wg==
X-Received: by 10.52.231.130 with SMTP id tg2mr1869870vdc.16.1386819520570;
 Wed, 11 Dec 2013 19:38:40 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Wed, 11 Dec 2013 19:38:20 -0800 (PST)
In-Reply-To: <20131212001738.996EB38055C@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239224>

On Wed, Dec 11, 2013 at 7:17 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> I tried very hard to salvage this program - the ability to
> remote-fetch CVS repos without rsync access was appealing

Is that the only thing we lose, if we abandon cusps? More to the
point, is there today an incremental import option, outside of
git-cvsimport+cvsps?

[ I am a bit out of touch with the current codebase but I coded and
maintained a good part of it back in the day. However naive/limited
the cvsps parser was, it did help a lot of projects make the leap to
git... ]

regards,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
