From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Git User's Survey 2007
Date: Fri, 27 Jul 2007 13:20:05 +0200
Message-ID: <200707271320.06313.jnareb@gmail.com>
References: <200707250358.58637.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 13:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEO18-0004TP-KI
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 13:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764022AbXG0L3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 07:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759351AbXG0L3w
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 07:29:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:56688 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932AbXG0L3v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 07:29:51 -0400
Received: by ug-out-1314.google.com with SMTP id j3so693324ugf
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 04:29:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gongpEcIvsBoyGViLbiB8Ex9re6T52TQrw62q6OF4o8A07Su8FKD3C1fxHuoafNleGXCq565lXBnmx1sOBx9NfSL4ox53LDDT8kbgUFuqAWUNqM6E3y7WZXIZfwXw7dL3zFS+vqQcjSi9eZYFcOc9bi14hMXmB4sLL65lsz9A6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oR15v0dcxCBeA2Yt+ddnOUTwCAZTAdM6XQJEkMQJXY5NsldE+G8XagCnv3fuFswHqMfIdprWx5bmKuNbe2GANts043ZK5gkpKnssnLHAnXIPlRPwMQIxq4PFQpnzU6c4xzTVc3GbAtpn5galkvL0T4N0S/xaMyM0sYyoX6gJ4GI=
Received: by 10.86.60.7 with SMTP id i7mr1892786fga.1185535789397;
        Fri, 27 Jul 2007 04:29:49 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id g1sm9788561muf.2007.07.27.04.29.46
        (version=SSLv3 cipher=OTHER);
        Fri, 27 Jul 2007 04:29:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200707250358.58637.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53916>

It's been more than a year since last Git User's Survey. It would be
interesting to find what changed since then. Therefore the idea to
have another survey.

First there is a question about the form of survey. Should we use web
based survey, as the survey before (http://www.survey.net.nz), sending
emails with link to this survey, or perhaps do email based survey,
with email Reply-To: address put for this survey alone?

Second, what questions should be put in the survey, and in the case of
single choice and ultiple choice questions what possible answers
should be? Below are slightly extended questions from the last
survey. Please comment on it.

Third, where to send survey to? I was thinking about git mailing list,
LKML, and mailing list for git projects found on GitProjects page on
GIT wiki. Do you want to add some address? Or should info about GIT
User's Survey 2007 be sent also to one of on-line magazines like
LinuxToday, or asked to put on some blog?

References:
  http://marc.info/?l=git&m=115116592330648&w=2
  http://marc.info/?l=git&m=115364303813936&w=2
  http://git.or.cz/gitwiki/GitSurvey

----
About you

    1. What country are you in?
    2. What is your preferred non-programming language?
    3. Which programming languages you are proficient with?
       (zero or more: multiple choice)
    -  C, shell, Perl, Python, Tcl/Tk

Getting started with GIT

    1. How did you hear about GIT?
    2. Did you find GIT easy to learn?
    -  very easy/easy/reasonably/hard/very hard
    3. What helped you most in learning to use it?
    4. What did you find hardest?
    5. When did you start using git? From which version?

How you use GIT

    1. Do you use GIT for work, unpaid projects, or both?
       work/unpaid projects/work
    2. How do you obtain GIT?  Source tarball, binary package, or
       pull the main repository?
    -  binary package/source tarball/pull from main repository
    3. What hardware platforms do you use GIT on?
    *  examples: i386, x86_64, ARM, PowerPC, Alpha, g5, ...
    4. What OS (please include the version) do you use GIT on?
    *  examples: Linux, MS Windows (Cygwin/MinGW/gitbox), 
       IRIX, HP-UX, Solaris, FreeBSD, ...
       (please give kernel version and distribution for Linux)
    5. How many people do you collaborate with using GIT?
    6. How big are the repositories that you work on? (e.g. how many
       files, how much disk space, how deep is the history?)
    *  number of files in repository: "git ls-tree -r HEAD | wc -l"
    *  pack size of freshly cloned fully packed repository
    *  number of commits in straight line, number of commits in branch
       ("git rev-list --first-parent HEAD | wc -l", 
        "git rev-list HEAD | wc -l")
    7. How many different projects do you manage using GIT?
    8. Which porcelains do you use?
       (zero or more: multiple choice)
    -  core-git, cogito, StGIT, pg, guilt, other
    9. Which git GUI do you use
       (zero or more: multiple choice)
    -  gitk, git-gui, qgit, gitview, giggle, other
   10. Which git web interface do you use for your projects?
    -  gitweb/cgit/wit (Ruby)/git-php/other
   11. How do you publish/propagate your changes?
       (zero or more: multiple choice)
    -  push, pull request, format-patch + email, bundle, other
   12. Does git.git repository include code produced by you?
    -  yes/no

Internationalization
    1. Is translating GIT required for wider adoption?
    -  yes/no/somewhat
    2. What do you need translated?
       (zero or more: multiple choice)
    -  GUI (git-gui, gitk, qgit, ...), git-core messages,
        manpages, other documentation
    3. For what language do you need translation for?

What you think of GIT

    1. Overall, how happy are you with GIT?
    -  unhappy/not so happy/happy/very happy/completely extatic
    2. How does GIT compare to other SCM tools you have used?
    -  worse/equal (or comparable)/better
    3. What do you like about using GIT?
    4. What would you most like to see improved about GIT?
       (features, bugs, plugins, documentation, ...)
    5. If you want to see GIT more widely used, what do you
       think we could do to make this happen?

Documentation

    1. Do you use the GIT wiki?
    -  yes/no
    2. Do you find GIT wiki useful?
    -  yes/no/somewhat
    3. Do you contribute to GIT wiki?
    -  yes/no/only corrections or spam removal
    4. Do you find GIT's online help (homepage, documentation) useful?
    -  yes/no/somewhat
    5. Do you find help distributed with GIT useful
       (manpages, manual, tutorial, HOWTO, release notes)?
    -  yes/no/somewhat
    6. Do you contribute to GIT documentation?
    -  yes/no
    7. What is your favourite user documentation for any software
       projects or products you have used?
    8. What could be improved on the GIT homepage?

Getting help, staying in touch

    1. Have you tried to get GIT help from other people?
    -  yes/no
    2. If yes, did you get these problems resolved quickly
       and to your liking?
    -  yes/no
    3. Do you subscribe to the mailing list?
    -  yes/no
    4. Do you read the mailing list? What method do you use?
    -  subscribed/news interface/RSS interface/archives/
       /post + reply-to request/digests/I don't read it
    5. If yes, do you find it useful?
    -  yes/no (optional)
    6. Do you find traffic levels on GIT mailing list OK.
    -  yes/no? (optional)
    7. Do you use the IRC channel (#git on irc.freenode.net)?
    -  yes/no
    8. If yes, do you find IRC channel useful?
    -  yes/no (optional)

Open forum

    1. What other comments or suggestions do you have that are not
       covered by the questions above?

-- 
Jakub Narebski
Poland
