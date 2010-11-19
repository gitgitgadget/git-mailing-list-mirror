From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Best newbie / advanced / expert reference texts for Git?
Date: Fri, 19 Nov 2010 17:08:23 +0000
Message-ID: <AANLkTinuuU+PqYQs=4XywUsrSyd3evFbRK+2_WxEAoZo@mail.gmail.com>
References: <AANLkTikctrASqX0FLCOapyJCt1VqG6_cxs_oXJ6fExZC@mail.gmail.com>
	<AANLkTik5ZYC66NicUvbDxJMiR_0iK3vPRAf9dGAQu+qW@mail.gmail.com>
	<AANLkTin_kS_2d=ajuGo-V_OWsF91xSb=SeKmrX9Aghe8@mail.gmail.com>
	<AANLkTimckSDtkfoVqvEACNUhMHAKVvTKcCCmm=VdavJL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Patrick Doyle <wpdster@gmail.com>, Git ML <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 18:08:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJURp-0000Vy-IV
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 18:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167Ab0KSRIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 12:08:25 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52018 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab0KSRIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 12:08:24 -0500
Received: by qyk32 with SMTP id 32so239980qyk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=mx7SEfg9H4/KJ/sO1os6Q0KxSWG/oIDGbe9XWz/dJEw=;
        b=Y6NPwGS9uVHNOGGUPosAUm7otZUyt79N8m0SkNyPVG5XsJaEUgoeKTf9D9rreuBRPi
         1ByExg/K9RAn60DHEl9fTgij2Gn08DbiV9pV8cik789ClA+VxgPq5nSL+f8eN9yjG0O8
         mtV3H4hSn7jZ+PnwURWMdHg/6MWBk1LbC/gIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KmBSTAx8LBY3oj9E7URNGsdx/LAUh6JbJYIw6ogMa6ZWN41Rsg87npE0QkxdwGYx2V
         9A+a3tAnzYRZjGowsDOi2Xzd6AZtE2aVc1wg3TW20VMzFANPsHbEZ25ud3wILwGT/Wka
         387ufC8vntcZxc86pULgBOiqrGEsE4O8IOrYE=
Received: by 10.224.19.129 with SMTP id a1mr1110725qab.154.1290186503325; Fri,
 19 Nov 2010 09:08:23 -0800 (PST)
Received: by 10.220.186.198 with HTTP; Fri, 19 Nov 2010 09:08:23 -0800 (PST)
In-Reply-To: <AANLkTimckSDtkfoVqvEACNUhMHAKVvTKcCCmm=VdavJL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161768>

On Fri, Nov 19, 2010 at 3:54 PM, Scott Chacon <schacon@gmail.com> wrote:
> For newbies as a sort of shorter tutorial/reference I also have
> http://gitref.org

Cool, looks like what I need for the Newbie class.
> These and other resources are listed out in http://git-scm.com/documentation

Yeah there are definitely a lot of resources listed there; so many,
that one can't readily decide which to use and for what purpose ;-)

>> P.S. I glanced at it briefly and it seemed a bit out of date, but
>> perhaps my inspection was too cursory.
>
> Do you have any examples?

I just glanced through a description of checking out branches and
didn't see the feature that creates a remote-tracking branch foo when
you `git checkout foo`, and foo isn't a local branch but does exist on
the remote.

Very cool of you to open your text up like that. I'll get a bunch of
copies of ProGit ordered as soon as I can.

D
