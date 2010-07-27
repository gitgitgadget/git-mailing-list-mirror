From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Tue, 27 Jul 2010 16:57:24 -0400
Message-ID: <AANLkTim0A0MAmpgAiaYSgYO=YbZ2gc4Upx3MQQopx6DG@mail.gmail.com>
References: <4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<4C49B31F.8000102@xiplink.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> 
	<AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com> 
	<AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com> 
	<4C4DB9AC.9000306@xiplink.com> <AANLkTimQywtn-0Fcr-ceLeHGeSBNROt+T=K+TowF_u5h@mail.gmail.com> 
	<20100727182841.GA25124@worldvisions.ca> <7vaapc7jv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Branchaud <marcnarc@xiplink.com>, skillzero@gmail.com,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 22:57:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrDk-0000rb-Qa
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 22:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab0G0U5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 16:57:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55368 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab0G0U5p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 16:57:45 -0400
Received: by wyf19 with SMTP id 19so3513711wyf.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=sPTjlsHp1KkaEf8sEASUBVQino6F6Je8bHN56Le1qU4=;
        b=G39DzCM1oO3GkGjJ+U/fEJhtgsciXyns8VWs15GBYj/O+hCF5+wpawWoGpvTMhw4cR
         DEpq5E5jMSLM6LFpDf6CyUXrITQ3pzMNpVk/Jnv1UsRDyiIokq/FjtODyik4WrCs67Z1
         Y6rzndM+D07/JvfvhPQWz5aBbZ9RNKjzpAIL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HFIdtW59adr9OruQhPWt7ws+QhUPV+lAWEBO3FdYxXTeXSb657EIkofUuxOUCO4vGG
         8/wMoVyokBYyUPO7i14UuKHuMGbNREXcovpG+2YCoUbJ0PLZc+s0GtldEe4ZxuPRhe1H
         7CCjW69s9z+R4tI3ZYFNtJC2c9Ba5XnciM+oA=
Received: by 10.227.156.200 with SMTP id y8mr9415467wbw.120.1280264264207; 
	Tue, 27 Jul 2010 13:57:44 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Tue, 27 Jul 2010 13:57:24 -0700 (PDT)
In-Reply-To: <7vaapc7jv8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151985>

On Tue, Jul 27, 2010 at 4:25 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> I agree completely. =A0The major failing of git-subtree is that it u=
ses
>> tree->tree links instead of tree->commit links.
>>
>> This was necessary only because git fundamentally *mistreats* tree->=
commit
>> links: it refuses to push or fetch through them automatically.
>
> I do not think that is so "fundamental" as you seem to think.
>
> Isn't it just the matter of how the default UI of object transfer com=
mands
> (like push and fetch) are set up?

Well, I call it fundamental because there's currently no way to get
the git UI to do otherwise.  It's not really just a "default."  To
depend on this changing would have prevented me from writing
git-subtree, which is why I didn't depend on it.  However, I agree
that it's fixable.

Note that the way git treats a checked-out submodule (as you describe
below) is also very fundamental to how this works.  git-subtree
wouldn't have the usability that it does if 'git checkout branchname'
didn't work perfectly will all the subtrees, which it currently does,
but which it wouldn't if I had relied on tree->commit links.

> Some "recursive" operations have been added to commands for which it =
makes
> sense (e.g. "clone --recursive") by people who cared enough. =A0Even =
though
> there are a few other commands that shouldn't ever learn the recursiv=
e
> mode (e.g. "commit --recursive -m $msg" would not make sense), there =
still
> are some commands where a similar "--recursive" option would make sen=
se
> but haven't learned it (e.g. "push --recursive").

One problem with this line of reasoning is that "--recursive" is
always an option.  But if submodules are ever to be easy to use, I
think it should be the default (or settable as a default using git
config).  This would take us a *long* way towards usability (of
course, in addition to adding the missing features, as you mention).

Also, I haven't tried it, but I think 'git gc' will prune away objects
if the only reference to them is a 'commit' link from a tree.  This
would be undesirable too.

> I also consider it merely a lack of UI enhancement that you have to c=
lone
> the submodule again (or cannot switch to a clean slate very easily) w=
hen
> switching between revisions of superproject before and after you add =
a
> submodule, and nothing fundamental.

I mostly agree with this.  There is one problem I don't know how to
solve with this idea, though: what happens when commit A adds a
submodule in modules/mod1, commit B removes it, and then commit C
re-adds the same submodules in modules/mod1-again?  Will it reuse the
same submodule .git directory or a new one?  Share objects or not?
Share branch names or not?  Share .git/config or not?

Unless you have some kind of "unique id" scheme for submodules, this
gets impossible to handle correctly.  And the git objects themselves
(trees that link to commits) have nowhere to put such things.

By comparison, simply putting all the stuff related to all the
submodules into the supermodule's repo creates none of these confusing
problems.  You could even still choose not to checkout individual
submodules' trees if you wanted.

> When switching back in history to lose a recent submodule, the user
> experience should be like switching to a revision that didn't have a
> directory. =A0You shouldn't be able to lose your change in that direc=
tory,
> but if the directory is clean, you should be able to lose it. =A0And =
when
> you switch to a more recent revision that has the submodule, you shou=
ld be
> able to get it back (again, if you have a precious file there, the
> checkout should barf).

It sounds like you're proposing that we delete the entire submodule's
directory hierarchy when the submodule commit link goes away.  Note
that this isn't what happens in the non-submodule case: all the *.o
files, for example, in a deleted subdirectory are not automatically
deleted by git.  And I think this is the behaviour we should expect.

With that in mind, the situations where checkout barfs because of a
"precious" file should be the same as they are in normal git: it
should only be a problem if the files in question differ between the
originally-checked-out tree and the newly-checked-out tree.

Apologies if that's what you meant in the first place.

> We have added support for having "gitdir: $dir" in a regular file .gi=
t
> exactly because we wanted to be able to stash away the submodule's .g=
it
> directory somewhere inside .git (e.g. .git/modules/<submodulename>) i=
n the
> superproject when we do that kind of branch switching, so that we can=
 get
> it back when switching back to a revision with the submodule without
> having to re-clone (also this presumably would help when you move the
> submodule in the superproject tree), but there haven't been further w=
ork
> to make use of this in "git submodule update" (it probably needs to s=
tart
> by teaching "git clone" how to make use of "gitdir: $dir", if anybody=
 is
> interested).

I guess the real question is: just how much of a "real" repository do
we want a submodule to act like?

Thoughts:

- object store: I think this should just always be shared with the
superproject.  There's no reason to separate them that I can see.

- branches: should be a way to simply not worry about branches and
just use what's in the superproject.  Other people seem to want to be
able to have a set of branches/tags for their submodule.

- .git/config: entirely shared?  entirely separate?

- remotes: I would want my submodules to never do their own
pushing/pulling, and leave that to the supermodule; other people seem
to disagree.

=46or the particular model I'm proposing, I'm just not sure that *any*
of the features of a separate repo are warranted... and having them
adds a lot of complication.  (In the most basic level, you suddenly
need to track .git directories as submodules are added/deleted/moved
around when you checkout different revisions of the superproject, and
there seems to be no way to do that elegantly.)

Have fun,

Avery
