From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [RFC] Git User's Survey 2007
Date: Sun, 29 Jul 2007 18:50:14 +0200
Message-ID: <4d8e3fd30707290950lce19ef4g103cbb7ad1abbe23@mail.gmail.com>
References: <200707250358.58637.jnareb@gmail.com>
	 <200707271320.06313.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 18:50:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFByH-0003cU-SB
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 18:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764075AbXG2QuS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 12:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763289AbXG2QuS
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 12:50:18 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:11509 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761608AbXG2QuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 12:50:16 -0400
Received: by py-out-1112.google.com with SMTP id d32so2340796pye
        for <git@vger.kernel.org>; Sun, 29 Jul 2007 09:50:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O6UfylUZNpgCycJTnRYcn/La+3wV4wzRnc7V8IVcRp3CXsmN/IHuaXH/Qcvu50ebQHjFENlftDqVyX87rIr4muZ3US50GTFYrKXI3WSz8tAe3Nd+/ontHR+5jgOkuiQ5vvx3z7DiFI23L0MBcwXkGSmclAsA6utosc3RtI7+8Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wm37uvsmSE/wHPygzmEolRKjddL6asdiuWz017XfG2tJK9kkXdshXfqRB3IOMowJuatBP1GHr3p08x6yCnmAS6TJtmFMtJ3HfDsqZTWxVTJ5xVVOm/z5M3f6vGdLaoIEqrGJq612wnlN0YnHsU6ru2DPhQggSSgoMMIJ6UTxfao=
Received: by 10.142.251.9 with SMTP id y9mr265792wfh.1185727814280;
        Sun, 29 Jul 2007 09:50:14 -0700 (PDT)
Received: by 10.143.163.10 with HTTP; Sun, 29 Jul 2007 09:50:14 -0700 (PDT)
In-Reply-To: <200707271320.06313.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54124>

On 7/27/07, Jakub Narebski <jnareb@gmail.com> wrote:
> It's been more than a year since last Git User's Survey. It would be
> interesting to find what changed since then. Therefore the idea to
> have another survey.

Hi Jakub,
sorry for the late answer, I've been away from my PC having fun on a
beach for a few days.
I'm now back home, I have my Menabrea beer with me so I can try to
provide some useful comments :-)

> First there is a question about the form of survey. Should we use web
> based survey, as the survey before (http://www.survey.net.nz), sending
> emails with link to this survey, or perhaps do email based survey,
> with email Reply-To: address put for this survey alone?

I vote for the survey.net.nz approach. I think that from a user
prospective that's the right thing to do, we can have "multiple choice
questions" and avoid some of the more common mistakes.

> Second, what questions should be put in the survey, and in the case of
> single choice and ultiple choice questions what possible answers
> should be? Below are slightly extended questions from the last
> survey. Please comment on it.
>
> Third, where to send survey to? I was thinking about git mailing list,
> LKML, and mailing list for git projects found on GitProjects page on
> GIT wiki. Do you want to add some address? Or should info about GIT
> User's Survey 2007 be sent also to one of on-line magazines like
> LinuxToday, or asked to put on some blog?

I think that one of the mistakes I did when I sent out the first
survey was to not contact any magazines and blog.

> References:
>   http://marc.info/?l=git&m=115116592330648&w=2
>   http://marc.info/?l=git&m=115364303813936&w=2
>   http://git.or.cz/gitwiki/GitSurvey
>
> ----
> About you
>
>     1. What country are you in?

I know that lot of people will disagree with me but from a pure
statistical prospective I'd like to add a couple of questions about
gender and age.
I understand very well that these questions will not be useful for
making git any better but it will be interesting to have a better
picture abut the git customer base.

>     2. What is your preferred non-programming language?
>     3. Which programming languages you are proficient with?
>        (zero or more: multiple choice)
>     -  C, shell, Perl, Python, Tcl/Tk
>
> Getting started with GIT
>
>     1. How did you hear about GIT?
>     2. Did you find GIT easy to learn?
>     -  very easy/easy/reasonably/hard/very hard
>     3. What helped you most in learning to use it?
>     4. What did you find hardest?
>     5. When did you start using git? From which version?
>
> How you use GIT
>
>     1. Do you use GIT for work, unpaid projects, or both?
>        work/unpaid projects/work
>     2. How do you obtain GIT?  Source tarball, binary package, or
>        pull the main repository?
>     -  binary package/source tarball/pull from main repository
>     3. What hardware platforms do you use GIT on?
>     *  examples: i386, x86_64, ARM, PowerPC, Alpha, g5, ...
>     4. What OS (please include the version) do you use GIT on?
>     *  examples: Linux, MS Windows (Cygwin/MinGW/gitbox),
>        IRIX, HP-UX, Solaris, FreeBSD, ...
>        (please give kernel version and distribution for Linux)
>     5. How many people do you collaborate with using GIT?
>     6. How big are the repositories that you work on? (e.g. how many
>        files, how much disk space, how deep is the history?)
>     *  number of files in repository: "git ls-tree -r HEAD | wc -l"
>     *  pack size of freshly cloned fully packed repository
>     *  number of commits in straight line, number of commits in branch
>        ("git rev-list --first-parent HEAD | wc -l",
>         "git rev-list HEAD | wc -l")
>     7. How many different projects do you manage using GIT?
>     8. Which porcelains do you use?
>        (zero or more: multiple choice)
>     -  core-git, cogito, StGIT, pg, guilt, other

git-gui ?

>     9. Which git GUI do you use
>        (zero or more: multiple choice)
>     -  gitk, git-gui, qgit, gitview, giggle, other
>    10. Which git web interface do you use for your projects?
>     -  gitweb/cgit/wit (Ruby)/git-php/other
>    11. How do you publish/propagate your changes?
>        (zero or more: multiple choice)
>     -  push, pull request, format-patch + email, bundle, other
>    12. Does git.git repository include code produced by you?
>     -  yes/no
>
> Internationalization
>     1. Is translating GIT required for wider adoption?
>     -  yes/no/somewhat
>     2. What do you need translated?
>        (zero or more: multiple choice)
>     -  GUI (git-gui, gitk, qgit, ...), git-core messages,
>         manpages, other documentation
>     3. For what language do you need translation for?
>
> What you think of GIT
>
>     1. Overall, how happy are you with GIT?
>     -  unhappy/not so happy/happy/very happy/completely extatic
>     2. How does GIT compare to other SCM tools you have used?
>     -  worse/equal (or comparable)/better
>     3. What do you like about using GIT?
>     4. What would you most like to see improved about GIT?
>        (features, bugs, plugins, documentation, ...)
>     5. If you want to see GIT more widely used, what do you
>        think we could do to make this happen?
>
> Documentation
>
>     1. Do you use the GIT wiki?
>     -  yes/no
>     2. Do you find GIT wiki useful?
>     -  yes/no/somewhat
>     3. Do you contribute to GIT wiki?
>     -  yes/no/only corrections or spam removal
>     4. Do you find GIT's online help (homepage, documentation) useful?
>     -  yes/no/somewhat
>     5. Do you find help distributed with GIT useful
>        (manpages, manual, tutorial, HOWTO, release notes)?
>     -  yes/no/somewhat
>     6. Do you contribute to GIT documentation?
>     -  yes/no
>     7. What is your favourite user documentation for any software
>        projects or products you have used?
>     8. What could be improved on the GIT homepage?
>
> Getting help, staying in touch
>
>     1. Have you tried to get GIT help from other people?
>     -  yes/no
>     2. If yes, did you get these problems resolved quickly
>        and to your liking?
>     -  yes/no
>     3. Do you subscribe to the mailing list?
>     -  yes/no
>     4. Do you read the mailing list? What method do you use?
>     -  subscribed/news interface/RSS interface/archives/
>        /post + reply-to request/digests/I don't read it
>     5. If yes, do you find it useful?
>     -  yes/no (optional)
>     6. Do you find traffic levels on GIT mailing list OK.
>     -  yes/no? (optional)
>     7. Do you use the IRC channel (#git on irc.freenode.net)?
>     -  yes/no
>     8. If yes, do you find IRC channel useful?
>     -  yes/no (optional)
>
> Open forum
>
>     1. What other comments or suggestions do you have that are not
>        covered by the questions above?

How about adding a question about whether the user migrated from a
different SCM?
If so, from which SCM and why?

Regards,
-- 
Paolo
