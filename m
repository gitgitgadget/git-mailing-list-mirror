From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Git Gems
Date: Wed, 16 Nov 2011 15:18:15 -0800
Message-ID: <CAE1pOi1gyshz_502NQvLNAByfwiYXW2fzA+EnGKz8tuFrCpkxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 17 00:18:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQokH-0004Ts-HO
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 00:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab1KPXSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 18:18:16 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33655 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab1KPXSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 18:18:16 -0500
Received: by ywt32 with SMTP id 32so311784ywt.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 15:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=0yxq4Papas7cb0CTsACUh8Y/KH8HwEF3gIXeTmb+QdE=;
        b=UYBA2+ugXJPjwQwgz/qB4nnFThjwR3FfOPsDmNwJFXsFGazPwNoMpeOib+OuxXf5QG
         P/H1zm8yGEvIGE7BdiPfi9s4DlJDwFhZ5g8/Jquehb/2HXHzmgayNfWs3KkBIP7vSt0H
         QEk4QkMW+l2pB2qSvVujd3rD4a5IBOxLDp+d4=
Received: by 10.236.155.74 with SMTP id i50mr5383493yhk.23.1321485495655; Wed,
 16 Nov 2011 15:18:15 -0800 (PST)
Received: by 10.236.61.41 with HTTP; Wed, 16 Nov 2011 15:18:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185560>

Hi all,

Just today, I found out about 'git add -p'. I had never even thought
of this but, now that I know, I can't imagine life without it. :-)
Actually, it's a bit scary to note that the Git devs apparently aren't
just telepathic but they can read my thoughts even before I think
them. ;-)

All kidding aside, I'm starting to wonder which other Git Gems I don't
know about. For me, the list of Git Gems would include Git's Bash
command line prompt, 'git add -p', 'git rebase', 'git commit --amend',
and 'git-new-workdir'. I realize there are plenty of books and such
out there but I'm really just looking for a list of Git commands
and/or options that are worth looking into. Finding out more about a
particular command/script/option is easy, realizing that a particular
one is the one you need is not. Especially, if you don't even know you
have a problem.

As an example, 'git rebase' didn't really seem useful until I
understood (well, more or less) what it did. Until then, I just
naively assumed that merge commits and non-linear history were
something you simply had to live with. I'm guessing that, like me, a
lot of people come to Git with quite a few assumptions and
preconceived notions due to their exposure to other SCM tools. :-(

Cheers,
Hilco
