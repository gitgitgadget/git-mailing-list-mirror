From: Scott Chacon <schacon@gmail.com>
Subject: Re: material for git training sessions/presentations
Date: Sun, 4 May 2014 21:29:59 -0700
Message-ID: <CAP2yMa+Q56R_Rsbsy4siJNKy0wU0JN7QM1NPMBO8sO_E9CSMwA@mail.gmail.com>
References: <CAFOYHZDNkTpQVge8Z_qOPS3eH-afKs-KeaFsQ6sOCtLbGgjdbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:18:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhsU-0005Yp-Ah
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbaEEEaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 00:30:22 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:64771 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbaEEEaV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 00:30:21 -0400
Received: by mail-pd0-f172.google.com with SMTP id g10so7820655pdj.3
        for <git@vger.kernel.org>; Sun, 04 May 2014 21:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BYCNTYsy3YBZPb4vUgv6HiNJNdf/a6FEoQHsNoh65kw=;
        b=k0yDch+4ezZgWicCI55DeJbeHAG7b2YibTnKE99jWHgitTeG546ZPDTTkYhbvBYBWM
         oRg0ZEkWQes+vCIk/r3C2Kx/j3xapndtRXytQ1LLEzWlqO+UB/V/5ZxdwOBjzTQcMVIk
         QhZnTe6fsCVhgsyEyBkVYHV0q8YbUhw+NGaO5zRcCR/xYdc0bLDU6zzIFPL1PkaWQlqS
         guHPyEdngHxKg3TL3ET/7RDoKxbfefV3+pJ2GixGoZXaRlNqP4Cb+dpQ5kNrPAbpsi6P
         XsEbVCp1ILcV8wXIwD5/CcIofUDwE7Dpwlnw0Jg9buvjfNaTGIBaw5ZDgHH55hG32bbr
         JdHw==
X-Received: by 10.66.65.204 with SMTP id z12mr37266464pas.60.1399264220275;
 Sun, 04 May 2014 21:30:20 -0700 (PDT)
Received: by 10.70.54.133 with HTTP; Sun, 4 May 2014 21:29:59 -0700 (PDT)
In-Reply-To: <CAFOYHZDNkTpQVge8Z_qOPS3eH-afKs-KeaFsQ6sOCtLbGgjdbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248125>

The GitHub training team has all of their materials open sourced under
a CC BY 3.0 license.  They're all written in Markdown and hosted on
GitHub.  You can check them out here, including going through an
online rendering of the materials:

http://training.github.com/kit/

Scott

On Sun, May 4, 2014 at 9:18 PM, Chris Packham <judge.packham@gmail.com> wrote:
> Hi,
>
> I know there are a few people on this list that do git training in
> various forms. At $dayjob I've been asked to run a few training
> sessions in house. The initial audience is SW developers so they are
> fairly clued up on VCS concepts and most have some experience
> (although some not positive) with git. Eventually this may also
> include some QA folks who are writing/maintaining test suites who
> might be less clued up on VCSes in general.
>
> I know if I googled for git tutorials I'll find a bunch and I can
> probably write a few myself but does anyone have any advice from
> training sessions they've run about how best to present the subject
> matter. Particularly to a fairly savy audience who may have developed
> some bad habits. My plan was to try and have a few PCs/laptops handy
> and try to make it a little interactive.
>
> Also if anyone has any presentations I could use under a CC-BY-SA (or
> other liberal license) as a basis for any material I produce that
> would save me starting from scratch.
>
> Thanks,
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
