From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Tue, 27 Jul 2010 14:40:47 -0400
Message-ID: <20100727184047.GC25124@worldvisions.ca>
References: <AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> <AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> <AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> <4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> <m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> <4C49B0E9.1090300@web.de> <AANLkTimSoe9iqu4cJCH1d4rVsWHpFn3+8pbrCxsnVM1D@mail.gmail.com> <4C4C9743.9080902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 27 20:40:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odp4u-000601-6U
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 20:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368Ab0G0Skb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 14:40:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52530 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0G0Ska (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 14:40:30 -0400
Received: by iwn7 with SMTP id 7so3927209iwn.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Octe/Vzl/7ok72czVvWSjZ5rMX593LjaraixsN8MzOo=;
        b=Wgz64hn8gUfQbNDn3kKfLQrT2uATPD2KGk2Xmg8sy0qJyq9YvvIffE6am1JAL6jbq8
         G++n/vTiy1+9hM/55ZkWv1JDaW6nJqFCZejqXsaAByFz9teyHYmLW7ungmhIbef8zxE0
         KnfcPwmOUv4I9cbIUEapsS2zXmk6xIDK8tmx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ktWJeoUb8nnfZ21lIGBrtEw4p/UE2RmEi/8ybsVxZ30KcYkMDOFP6IEeNstG871LD+
         6ROutzdwuMAkYWfOFLV1ofEg4TaPBAIzlnue5RyRbuomfMKfkKAFRvH1TolUjPQMWZ0i
         faVZk7LzA8HQcvEnZXCTITPBT+4Zho0Tscq2o=
Received: by 10.231.183.10 with SMTP id ce10mr10594243ibb.96.1280256030016;
        Tue, 27 Jul 2010 11:40:30 -0700 (PDT)
Received: from afterlife.apenwarr.local ([66.51.252.152])
        by mx.google.com with ESMTPS id h8sm5031519ibk.15.2010.07.27.11.40.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 11:40:28 -0700 (PDT)
Received: from apenwarr by afterlife.apenwarr.local with local (Exim 4.69)
	(envelope-from <apenwarr@afterlife.apenwarr.local>)
	id 1Odp55-0006Xk-S7; Tue, 27 Jul 2010 14:40:47 -0400
Content-Disposition: inline
In-Reply-To: <4C4C9743.9080902@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151972>

On Sun, Jul 25, 2010 at 09:57:55PM +0200, Jens Lehmann wrote:

> Am 24.07.2010 00:32, schrieb Avery Pennarun:
> > On Fri, Jul 23, 2010 at 11:10 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> >> You forgot what we do as best practice at work:
> >>
> >> [3] Fork the gem repos on github (or another server reachable by your
> >>    co-workers) and use those, so you don't have to change the URL
> >>    later:
> >>
> >>    git://github.com/apenwarrrubygems/gem[1..n]
> >>
> >> Your problems go away, setup has to be done only once on project
> >> start and not for every developer, you can use your own branchnames
> >> and you have a staging repo from where you can push patches upstream
> >> if necessary.
> > 
> > Now all your fellow developers have to push their submodule code to a
> > single upstream repo?  That's rather centralized and un-git-like.
> 
> But isn't that exactly the same thing you would have to do for your
> superproject too to be able to push your changes for your fellows?

No.  On github, only I can push to my superproject's history, and yet
everyone can still pull from me.

With what you're proposing, for all my submodules, we can't each have our
own project; we all have to push to the shared one.

(Just to be clear: I don't want to fork *every submodule by hand every
time*.  I just want *my* stuff to be in *my* repo.  The easiest way to do
this would be to have all my changes in a single repo, ie. my fork of the
superproject.)

> >> It is the /commits/ that have to be
> >> done twice, once in the submodule and
> >> then in the superproject. (But that is
> >> not necessarily bad, imagine having git
> >> gui as a submodule: you would be
> >> automagically reminded that stuff for
> >> git gui should be sent somewhere else
> >> than to Junio).
> > 
> > Yup, I agree that requiring a separate commit to the submodule repo is
> > not a bad idea.  I always do this anyway even when using git-subtree,
> > because I'm thinking ahead to the day when I'll push my submodule
> > changes upstream and I want my commit message to make sense.  But
> > that's because I think ahead like that.  Having the tool force me to
> > do it would be harmless and help people avoid mistakes.
> 
> And submodules force you to do that.

Yes.  This is a limitation of submodules, but not one that bothers me.  And
it encourages good behaviour.

> > The syntax for it ought to be nice though.  I should be able to do:
> > 
> >     git commit -- path/to/submodule
> > 
> > And have it commit everything in the submodule tree as a new commit in
> > the submodule.  I don't want to have to think about cd'ing to
> > path/to/submodule just so I can commit the files I changed in there.
> 
> Yes, that would be a nice feature (assuming you have a branch in the
> submodule to commit these changes to ;-).

No, I explicitly *don't* want to have to have a branch in the submodule;
that's too much extra thinking at that stage.

Have fun,

Avery
