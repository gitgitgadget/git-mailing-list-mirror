From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2007
Date: Mon, 30 Jul 2007 02:21:23 +0200
Message-ID: <200707300221.23511.jnareb@gmail.com>
References: <200707250358.58637.jnareb@gmail.com> <200707271320.06313.jnareb@gmail.com> <4d8e3fd30707290950lce19ef4g103cbb7ad1abbe23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 02:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFJ1A-0004G8-EO
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 02:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965472AbXG3AVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 20:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965514AbXG3AVm
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 20:21:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:43078 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965466AbXG3AV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 20:21:29 -0400
Received: by nf-out-0910.google.com with SMTP id g13so133299nfb
        for <git@vger.kernel.org>; Sun, 29 Jul 2007 17:21:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VUc6SOlqDwyDXogP+O7FZg7wPdntiMPmJHYt9A0+n/RtNvn5AACiv8QVfYH3JH9yYvZO1UD3RNt/p2al69E/fcPImpjqksiCtvjEUsHw2EPRFhciMDvj5BRimnX56YqWGWlJYTwGQ4sURRIgKRTr0uGO8cCRlVjX7Kzy600esJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BRcPCNsJ0u3SP0vwYC0j6WtvSfd7xOsMJmAYpm7lRvdtLJGUYv+eGF+2fWhNgeThVPIQbgpaBGG8jUL7mfcwzBrj1pL7ocwZcYkC+xHOJ9kNdOBVM/NJUxvrj0X6lsHutHD9KChTLbzGlr6/tqUPi6KWyOkEE/sbgT1//xGiBZc=
Received: by 10.86.80.5 with SMTP id d5mr3512966fgb.1185754887409;
        Sun, 29 Jul 2007 17:21:27 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id j9sm11404931mue.2007.07.29.17.21.26
        (version=SSLv3 cipher=OTHER);
        Sun, 29 Jul 2007 17:21:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4d8e3fd30707290950lce19ef4g103cbb7ad1abbe23@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54165>

Paolo Ciarrocchi wrote:
> On 7/27/07, Jakub Narebski <jnareb@gmail.com> wrote:

>> First there is a question about the form of survey. Should we use web
>> based survey, as the survey before (http://www.survey.net.nz), sending
>> emails with link to this survey, or perhaps do email based survey,
>> with email Reply-To: address put for this survey alone?
> 
> I vote for the survey.net.nz approach. I think that from a user
> prospective that's the right thing to do, we can have "multiple choice
> questions" and avoid some of the more common mistakes.

I think it also better (especially that I started devising questions
with multiple-choice and single-choice answers in mind...).
 
>> Third, where to send survey to? I was thinking about git mailing list,
>> LKML, and mailing list for git projects found on GitProjects page on
>> GIT wiki. Do you want to add some address? Or should info about GIT
>> User's Survey 2007 be sent also to one of on-line magazines like
>> LinuxToday, or asked to put on some blog?
> 
> I think that one of the mistakes I did when I sent out the first
> survey was to not contact any magazines and blog.

Any proposals? Besides LWN, NewsForge, Slashdot?
 
>> ----
>> About you
>>
>>     1. What country are you in?
> 
> I know that lot of people will disagree with me but from a pure
> statistical prospective I'd like to add a couple of questions about
> gender and age.
>
> I understand very well that these questions will not be useful for
> making git any better but it will be interesting to have a better
> picture abut the git customer base.

I'm not sure it would add any important informatant information;
although "age" (years, or age bracket?) could be useful.
 
>> How you use GIT

>>     8. Which porcelains do you use?
>>        (zero or more: multiple choice)
>>     -  core-git, cogito, StGIT, pg, guilt, other
          IsiSetup

> git-gui ?
> 
>>     9. Which git GUI do you use
>>        (zero or more: multiple choice)
>>     -  gitk, git-gui, qgit, gitview, giggle, other
          tig, instaweb, (h)gct, qct, KGit

I consider git-gui an UI (like qgit or tig), not a porcelain. To be
a porcelains tool need to add some SCM functionality not present in
git-core.

> How about adding a question about whether the user migrated from a
> different SCM? If so, from which SCM and why?

I have added, suggested [somewhat] by Andy Parkins, the following
set of questions:

----
Other SCMs

    1. What other SCM did you use?
    2. What other SCM do you use currently?
    3. What other SCM do you use as a main SCM for your project
       instead of git, if any? Why?
    *  example: Mercurial, better MS Windows support
    5. What would you require from git to enable you to change,
       if you use other SCM for your project?
    4. Do your git repository interact with other SCM? Or what SCM
       did you import from? What tool did/do you use?
    *  examples: CVS, import: fromcvs, interaction: git-cvsserver;
		 Subversion, git-svn
----

-- 
Jakub Narebski
Poland
