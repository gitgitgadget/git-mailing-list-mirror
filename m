From: skillzero@gmail.com
Subject: Re: Avery Pennarun's git-subtree?
Date: Fri, 23 Jul 2010 17:58:31 -0700
Message-ID: <AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com>
References: <4C472B48.8050101@gmail.com>
	<AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com>
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com>
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com>
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
	<4C4778DE.9090905@web.de>
	<AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com>
	<m31vavn8la.fsf@localhost.localdomain>
	<AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
	<4C49B31F.8000102@xiplink.com>
	<AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 02:58:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcT4Y-0005yn-Gd
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 02:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375Ab0GXA6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 20:58:33 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36707 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab0GXA6c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 20:58:32 -0400
Received: by gxk23 with SMTP id 23so371507gxk.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 17:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FTSMhza/a6FtPNGrLz139Lcx2nT6TLrgLXWFI5Eq1vI=;
        b=lNMhd4mSIuKl/fA1v0QMa6JZmK0GxG0ECs82Bs/wBXGAvsYEOFalXwYF1EMVyKVVSP
         0fZnNm8eznMylE4yPNfTsOym5Ymv2PGfeiVuYrqNuTc55nM1a3cPT/5FYg8EahMdHAj+
         t6nrdCUPEBAGkPPKaGU35CIeXWjM2iof66lAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qtL/kCB9+tKe2b/K2zE8kKe9eyv2xHxmywjQqHBElstPaFnJEWO/6Mj+zIkSirWSk0
         KTYEssdBfoqTnAbyOICJTZ9qqpVPqH7t+Fq9mXp7kzhv7NZqdFJXas6Vz4KmZL5UyXlh
         VJUYqdlEIRKI73prVTXX9grJRd2pQpJmN0daU=
Received: by 10.90.102.4 with SMTP id z4mr3997266agb.86.1279933111900; Fri, 23 
	Jul 2010 17:58:31 -0700 (PDT)
Received: by 10.90.177.3 with HTTP; Fri, 23 Jul 2010 17:58:31 -0700 (PDT)
In-Reply-To: <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151589>

On Fri, Jul 23, 2010 at 3:50 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:

> Honest question: do you care about the wasted disk space and download
> time for these extra files? =C2=A0Or just the fact that git gets slow=
 when
> you have them?

I have the similar situation to the original poster (huge trees) and
for me it's all three: disk space, download time, and performance. My
tree has a few relatively small (< 20 MB) shared directories of common
code, a few large (2-6 GB) directories of code for OS's, and then
several medium size (< 500 MB) directories for application code. The
application developers only care about the app+shared directories (and
are very annoyed by the massive space and performance impact of the OS
directories). The firmware-only developers only care about OS+shared
and are mildly annoyed by the medium space and performance impact of
the app directories. I work on all of the pieces, but even I would
prefer to have things separated so when I work on the apps, git
status/etc doesn't take a big hit for close to a million files in the
OS directories (particularly when doing git status on Windows). Even
when using the -uno option to git status, it's still pretty slow (over
a minute).

git-submodule might be technically possible in this situation, but
having to commit and push each submodule and then commit and push the
super module makes it slightly worse than just dealing with the
space/download/performance issues of one huge repository.

git-subtree could also possibly help, but there's still extra work to
split and merge each repository. And I'm not sure how it handles
commit IDs across the repositories because I want to be able to say "I
fixed that bug in shared/code.c in commit abc123" and have both the
OS+shared and the apps+shared people be able git log abc123 and see
the same change (and merge/cherry-pick/etc.).

I think what I want is a way to do a sparse checkout where some sort
of module is maintained in the git repository (probably just an
INI-style file with paths) so I can clone directly from the server and
it figures out the objects I need for the full history of only
apps+shared (or firmware+shared, etc.) on the server side and only
sends those objects. I still want to be able to branch, tag, and refer
to commit IDs. So I only take the space/download/performance hit of
directories included in the module, but I don't have to manually
maintain that view of the repository (as I do with git-submodule and
git-subtree).

The closest thing to that so far for me has been the sparse checkout
support added in git 1.7 combined with a convenience script I wrote.
Everyone still has a huge download and .git directory, but at least
the working copy is limited to the paths specified in the module so
git status isn't super slow (although just having all those objects in
the .git directory still slows it down quite a bit).
