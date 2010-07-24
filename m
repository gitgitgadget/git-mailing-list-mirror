From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Fri, 23 Jul 2010 21:20:07 -0400
Message-ID: <AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<4C49B31F.8000102@xiplink.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> 
	<AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sat Jul 24 03:20:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcTPm-0002if-Jx
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 03:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757587Ab0GXBU3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 21:20:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62383 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378Ab0GXBU2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 21:20:28 -0400
Received: by wyf19 with SMTP id 19so768505wyf.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 18:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=S2tClxKdPphADibrWRy94BAShlEnfXo794r3GrYFc0I=;
        b=SSLGWcw2JcovsdZT4ICCwL2cNBzSy+rsPd8q4wKVMO5sJGTTN2/X3jQMrofCl+w6QA
         VS4NHdN8H7TilkT+SdJBG2bpuX91Vfs0K/jIeNu/hBQAgvwiWYwtxD+EQMCe3MB7Lai0
         enGuKhWMleXqYx8ySDL1e66HJ2DRzmQREG2ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GnLGJB7Fq+hXLg0nkO6a0hdpVYQ+NaLcJcf1qR1QpQdeUwlLgra27S7JqrzseVmhGo
         u3wnyAecyV5KFdekY3FkW2BmKWknwxxhG/Wa9SiBiC8A4m5jhal10XnCTo3DsWCOvVbF
         4qHT/hkKGK0lzoNL/HiWr5zWcYzWM3tVCXz60=
Received: by 10.216.178.196 with SMTP id f46mr4271028wem.62.1279934427252; 
	Fri, 23 Jul 2010 18:20:27 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Fri, 23 Jul 2010 18:20:07 -0700 (PDT)
In-Reply-To: <AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151595>

On Fri, Jul 23, 2010 at 8:58 PM,  <skillzero@gmail.com> wrote:
> On Fri, Jul 23, 2010 at 3:50 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> Honest question: do you care about the wasted disk space and downloa=
d
>> time for these extra files? =A0Or just the fact that git gets slow w=
hen
>> you have them?
>
> I have the similar situation to the original poster (huge trees) and
> for me it's all three: disk space, download time, and performance. My
> tree has a few relatively small (< 20 MB) shared directories of commo=
n
> code, a few large (2-6 GB) directories of code for OS's, and then
> several medium size (< 500 MB) directories for application code. The
> application developers only care about the app+shared directories (an=
d
> are very annoyed by the massive space and performance impact of the O=
S
> directories).

Given how cheap disk space is nowadays, I'm curious about this.  Are
they really just annoyed by the performance problem, and they complain
about the extra size because they blame the performance on the extra
files?  Or are they honestly short of disk space?

Similarly, are all your developers located at the same office?  If so,
then bandwidth ought not be an issue.

I'm pushing extra hard on this because I believe there are lots of
opportunities to just improve git performance on huge repositories.
And if the only *real* reason people need to split repositories is
that performance goes down, then that's fixable, and you may need
neither git-submodule nor git-subtree.

> I work on all of the pieces, but even I would
> prefer to have things separated so when I work on the apps, git
> status/etc doesn't take a big hit for close to a million files in the
> OS directories (particularly when doing git status on Windows). Even
> when using the -uno option to git status, it's still pretty slow (ove=
r
> a minute).

This is indeed a problem with large repositories.  Of course,
splitting them with git-submodule is kind of cheating, because it just
makes git-status *not look* to see if those files are dirty or not.
If they are dirty and you forget to commit them, you'll never know
until someone tells you later.  It would be functionally equivalent to
just have git-status not look inside certain subdirs of a single
repository.

In any case, this is a pretty clear optimization target (especially
since Windows is so amazingly slow at statting files): just have a
daemon running inotify (or the Windows equivalent) that tracks whether
files are up-to-date or not.  Then git would never need to recurse
through the entire tree, and operations like status, diff, checkout,
and commit could be fast even with a million-file repository.

> git-subtree could also possibly help, but there's still extra work to
> split and merge each repository. And I'm not sure how it handles
> commit IDs across the repositories because I want to be able to say "=
I
> fixed that bug in shared/code.c in commit abc123" and have both the
> OS+shared and the apps+shared people be able git log abc123 and see
> the same change (and merge/cherry-pick/etc.).

git-subtree (if you don't use --squash) keeps all the commit IDs.  It
is extra work to split and merge between repositories, though.  It
doesn't solve your repository-is-too-large problem.

> I think what I want is a way to do a sparse checkout where some sort
> of module is maintained in the git repository (probably just an
> INI-style file with paths) so I can clone directly from the server an=
d
> it figures out the objects I need for the full history of only
> apps+shared (or firmware+shared, etc.) on the server side and only
> sends those objects. I still want to be able to branch, tag, and refe=
r
> to commit IDs. So I only take the space/download/performance hit of
> directories included in the module, but I don't have to manually
> maintain that view of the repository (as I do with git-submodule and
> git-subtree).

Yes, better sparse checkout and sparse fetch would be very valuable
here and would eliminate a lot of the reasons people have for misusing
submodules.

> (although just having all those objects in
> the .git directory still slows it down quite a bit).

You're the second person who has mentioned this today (the first one
was to me in a private email).  I'd like to understand this better.

In my bup project (http://github.com/apenwarr/bup) we regularly create
git repositories with hundreds of gigabytes of packs, comprising tens
or hundreds of millions of objects, and the repository doesn't get
slow.  (Obviously this is a separate issue from having a huge work
tree with a million files in it.)  In repositories this thoroughly
huge, we did find a way to improve memory usage versus git's pack .idx
files (bup has '.midx' files that combine multiple indexes into one,
thus reducing the binary search steps).  But this only matters when
you get well over 10 gigabytes of stuff and you're wading through it
using crappy python code (as bup does) and frequently inserting a
million objects at a time (as bup does).  The git usage pattern is
much simpler and therefore faster.

How big is your .git directory and what performance problems do you
see?  I assume you've done 'git gc' to clean up all the loose objects,
right?

Have fun,

Avery
