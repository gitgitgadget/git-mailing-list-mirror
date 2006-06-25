From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [RFC] GIT user survey
Date: Sun, 25 Jun 2006 16:04:45 +0200
Message-ID: <4d8e3fd30606250704vf0e77dx9c3a029807e3dccd@mail.gmail.com>
References: <4d8e3fd30606240918m6b452314m6514b5e5fc86f147@mail.gmail.com>
	 <46a038f90606241642q1467d577q329412f4ad09da34@mail.gmail.com>
	 <4d8e3fd30606250347o47c4b200t6feb0406bfa535fa@mail.gmail.com>
	 <7vfyhtv6iw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 16:05:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuVEX-0007BF-0x
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 16:05:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWFYOEs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 10:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWFYOEr
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 10:04:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:44358 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750938AbWFYOEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 10:04:47 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1693622ugf
        for <git@vger.kernel.org>; Sun, 25 Jun 2006 07:04:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g5V7L7VCfoz9D2k/q0NShgCnuPrr7FqWCfPKKoSO676tU6hl7sylMteo08jywTeLLv0RNWpqS43+vVjzaJ2DSLVqCeJ+nsnj9eVUkVunBA25XPq4VjEfeqB0fgeiBrMN6AVbdCWBAAULlflLuW56hrplxL1jPQhbv+1tACjNQoo=
Received: by 10.78.138.14 with SMTP id l14mr1770087hud;
        Sun, 25 Jun 2006 07:04:45 -0700 (PDT)
Received: by 10.78.121.12 with HTTP; Sun, 25 Jun 2006 07:04:45 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vfyhtv6iw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22627>

On 6/25/06, Junio C Hamano <junkio@cox.net> wrote:
> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
>
> > About you
> >
> >    1. What country are you in?
> >    2. What is your preferred language?
> >    3. What's your gender?
>
> Demography is interesting and quite relevant to understand the
> bias in the answers to the rest of the questions, although I do
> not see much point about #3.  Question #2 is relevant in i18n,
> of course.

Yeah, removed item #3.

> I would also ask if the respondent has her own patch in the
> git.git repository.  If most of them are git developers, the
> answer to the question "was git easy to learn" becomes
> suspicious, for example.

OK.

> > Getting started with GIT
> >
> >    1. How did you hear about GIT?
> >    2. Did you find GIT easy to learn?
> >    3. What helped you most in learning to use it?
>
> Also "When did you start using git?" -- old timers who learned
> git when it was still young and small would have had an easier
> time to learn it.

OK.

> > How you use GIT
> >
> >    1. Do you use GIT for work, unpaid projects, or both?
> >    2. How do you obtain GIT?  Source tarball, binary package, or
> >       pull the main repository?
> >    3. What platforms (hardware, OS, version) do you use GIT on?
> >    4. How many people do you collaborate with using GIT?
> >    5. How big are the repositories that you work on? (e.g. how many
> >       files, how much disk space)
> >    6. How many different projects do you manage using GIT?
> >    7. Which porcelains do you use?
>
> After seeing the Mercurial survey result, I think question #3
> should be stated a bit more concretely.  The results having
> mixture of i386 and Linux are not very interesting.  I would
> also add "how deep the history" to #5.

OK

> > Getting help, staying in touch
> >
> >    1. Have you tried to get GIT help from other people?
> >          * If yes, did you get these problems resolved quickly and to
> >            your liking?
> >    2. Do you subscribe to the mailing list?
> >          * If yes, do you find it useful, and traffic levels OK?
> >    3. Do you use the IRC channel (#git on irc.freenode.net)?
> >          * If no, did you know that all of the core developers use
> >            IRC, and that there's almost 24-hour help available?
>
> About #3, I do not see some people I consider "core" often on
> the IRC.  Maybe "most of the core".

I think I can remove that part of the sentece, Pasky already had the
same comment when I was discussing the sruvey on #GIT. My mistake.

New version attached.

About you

    1. What country are you in?
    2. What is your preferred language?

Getting started with GIT

    1. How did you hear about GIT?
    2. Did you find GIT easy to learn?
    3. What helped you most in learning to use it?
    4. When did you start using git?

How you use GIT

    1. Do you use GIT for work, unpaid projects, or both?
    2. How do you obtain GIT?  Source tarball, binary package, or
       pull the main repository?
    3. What hardware platforms do you use GIT on?
    4. What OS (please include the version) do you use GIT on?
    5. How many people do you collaborate with using GIT?
    6. How big are the repositories that you work on? (e.g. how many
       files, how much disk space, how deep is the histoty)
    7. How many different projects do you manage using GIT?
    8. Which porcellains do you use?
    9. Is the git.git repository including codes produced by you?

What you think of GIT

    1. Overall, how happy are you with GIT?
    2. How does GIT compare to other SCM tools you have used?
    3. What do you like about using GIT?
    4. What would you most like to see improved about GIT?
       (features, bugs, plugins, documentation, ...)
    5. If you want to see GIT more widely used, what do you
       think we could do to make this happen?

Documentation

    1. Do you use the GIT wiki?   If yes, do you find it useful?
    2. Do you find GIT's online help useful?
    3. What is your favourite user documentation for any software
       projects or products you have used?
    4. What could be improved on the GIT homepage?

Getting help, staying in touch

    1. Have you tried to get GIT help from other people?
          * If yes, did you get these problems resolved quickly and to
            your liking?
    2. Do you subscribe to the mailing list?
          * If yes, do you find it useful, and traffic levels OK?
    3. Do you use the IRC channel (#git on irc.freenode.net)?


Open forum

    1. What other comments or suggestions do you have that are not
       covered by the questions above?


-- 
Paolo
http://paolociarrocchi.googlepages.com
http://picasaweb.google.com/paolo.ciarrocchi
