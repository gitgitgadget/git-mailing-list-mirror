From: Scott Chacon <schacon@gmail.com>
Subject: The GitTogether
Date: Thu, 26 Jul 2012 15:28:00 -0700
Message-ID: <CAP2yMaJzJyw=9DqJzUXkkQjz_jcqB4pH=FfHFRiftC9=yC7dvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 00:29:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuWYE-0007Ew-Ce
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 00:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab2GZW2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 18:28:22 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34459 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab2GZW2V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 18:28:21 -0400
Received: by qcro28 with SMTP id o28so1555436qcr.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=4SZCev6kNfmA9pnYACb0FJVGUPm/JOqTYfGy6c409qA=;
        b=ndxUwYWf4YWzKi6Wd+Tnp342tIfDrcqcBg6eruVApfMQRqhoLh+x2v8xLFkDbLxFnH
         V937SBHAldBP93pPLEHn2rExJmHdjC5WrrOWIUzETd3QztXZMaVs94wB8wogl/LFLlnW
         SSb0opAqx7K17fE6d4nwfh/rd0MCEWGY1sC+DBtvT/HGckbaGyHPZIMEbdlMgxBeVgpw
         uLCNberACQQjgET1Lm3OdcelvQsrMXnUy3cmOYxGlcElKt0c1CWYCZFNT9boDFwtd7Xs
         zeG9jFHc0hYzIxe3qLwrcaIpg6C9jt9YT5trzXmXLI3CT/zwFkjGJoPFoAyY95YAlKWx
         tiBg==
Received: by 10.229.135.13 with SMTP id l13mr175749qct.98.1343341701041; Thu,
 26 Jul 2012 15:28:21 -0700 (PDT)
Received: by 10.229.251.143 with HTTP; Thu, 26 Jul 2012 15:28:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202311>

For the last few years, there has been a gathering of Gitty people in
Mountain View directly following the GSoC Mentor Summit that is
referred to as a GitTogether:

https://git.wiki.kernel.org/index.php/GitTogether

A few of us have been talking about what we would like to do this year
and thinking about the gatherings the past few years and how we could
get the most out of it.

I would like to see two different gatherings this year - one that
would be user-centric to gather people that use Git together with some
of the developers and talk about Git from a user's perspective.  The
other event I would like to see would be a gathering of many of the
core Git developers in a sort of hacker summit.

GitHub would like to volunteer to organize and pay for these events
this year.  I would like to hold the developer-centric one in Berlin
in early October (a few weeks before the Mentor Summit this time) and
the user one in January or February of next year.

The general idea of the developer one in October would be to get 30-40
people who work directly on Git core, JGit and libgit2 (or closely
related projects) together to discuss core issues, new features, etc.
GitHub can help with travel and lodging for participants who need it,
but attendance would be limited to people actually working on Git the
most.  Similar to some of the earlier GitTogethers.

The user conference early next year would be held in San Francisco or
nearby and would be a chance for people using Git to share how they're
using it, what they would like to see, etc.  I would expect to host
far more people at this - closer to 100, something like the last
GitTogether.

I'm working on putting together websites for the two events for
registration, schedule and to gather topics that should be discussed.
I am planning on having the talks recorded and put online as well. I
wanted to get some general feedback from the ML about what they think
about this plan before I finalized everything though.

For those of you who *have* been to a GitTogether, what did you find
useful and/or useless about it?  What did you get out of it and would
like to see again?  For those of you who have never been, what do you
think would be useful?  I was thinking for both of them to have a
combination of short prepared talks, lightning/unconference style
talks and general discussion / breakout sessions.

Finally, is there any feedback on the times and places - especially
the Berlin one. If nobody can agree on a better specific time, I'll
push forward with early October in Berlin, but if there is a concensus
around a different time, I'm fine moving it.

Scott
