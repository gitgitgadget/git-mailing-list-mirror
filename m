From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] GIT user survey
Date: Sun, 25 Jun 2006 04:06:31 -0700
Message-ID: <7vfyhtv6iw.fsf@assigned-by-dhcp.cox.net>
References: <4d8e3fd30606240918m6b452314m6514b5e5fc86f147@mail.gmail.com>
	<46a038f90606241642q1467d577q329412f4ad09da34@mail.gmail.com>
	<4d8e3fd30606250347o47c4b200t6feb0406bfa535fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 13:06:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuSRq-0003Hg-Al
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 13:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWFYLGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 07:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWFYLGe
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 07:06:34 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:29434 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932358AbWFYLGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 07:06:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625110632.BJZU8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Jun 2006 07:06:32 -0400
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
In-Reply-To: <4d8e3fd30606250347o47c4b200t6feb0406bfa535fa@mail.gmail.com>
	(Paolo Ciarrocchi's message of "Sun, 25 Jun 2006 12:47:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22611>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> About you
>
>    1. What country are you in?
>    2. What is your preferred language?
>    3. What's your gender?

Demography is interesting and quite relevant to understand the
bias in the answers to the rest of the questions, although I do
not see much point about #3.  Question #2 is relevant in i18n,
of course.

I would also ask if the respondent has her own patch in the
git.git repository.  If most of them are git developers, the
answer to the question "was git easy to learn" becomes
suspicious, for example.

> Getting started with GIT
>
>    1. How did you hear about GIT?
>    2. Did you find GIT easy to learn?
>    3. What helped you most in learning to use it?

Also "When did you start using git?" -- old timers who learned
git when it was still young and small would have had an easier
time to learn it.

> How you use GIT
>
>    1. Do you use GIT for work, unpaid projects, or both?
>    2. How do you obtain GIT?  Source tarball, binary package, or
>       pull the main repository?
>    3. What platforms (hardware, OS, version) do you use GIT on?
>    4. How many people do you collaborate with using GIT?
>    5. How big are the repositories that you work on? (e.g. how many
>       files, how much disk space)
>    6. How many different projects do you manage using GIT?
>    7. Which porcelains do you use?

After seeing the Mercurial survey result, I think question #3
should be stated a bit more concretely.  The results having
mixture of i386 and Linux are not very interesting.  I would
also add "how deep the history" to #5.

> Getting help, staying in touch
>
>    1. Have you tried to get GIT help from other people?
>          * If yes, did you get these problems resolved quickly and to
>            your liking?
>    2. Do you subscribe to the mailing list?
>          * If yes, do you find it useful, and traffic levels OK?
>    3. Do you use the IRC channel (#git on irc.freenode.net)?
>          * If no, did you know that all of the core developers use
>            IRC, and that there's almost 24-hour help available?

About #3, I do not see some people I consider "core" often on
the IRC.  Maybe "most of the core".
