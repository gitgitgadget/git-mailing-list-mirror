From: Jakub Narebski <jnareb@gmail.com>
Subject: Git User's Survey 2007 partial summary
Date: Sun, 2 Sep 2007 10:33:18 +0200
Message-ID: <200709021033.18990.jnareb@gmail.com>
References: <200708190128.43515.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 10:33:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRktv-00067o-SS
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 10:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbXIBIdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 04:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbXIBIdi
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 04:33:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:32577 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342AbXIBIdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 04:33:36 -0400
Received: by nf-out-0910.google.com with SMTP id f5so992441nfh
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 01:33:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=DgwUnlZUJDvZtIlo+Hf+ULvQzVpznhAoDxkuGM1yypHrOIdRj9Zo2n84nsHxbOMeQOcjvZ+cXUhzeDmWwUliDWRFdKSyccMNFyW9g+xm4zMNP49lWu9sem6mXBNSMU76Puez3eUSwpxO0Z9XtgJ/MEl+q6QJdWPPuerU3Df5RuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=CcXqO5guiOWTuf+JXIvlm/YkSTYSt2oI3IIZGjMMB6er/NpVS8Of3MDU7enDnjEtgvXyR098hUloepYLqDEMKi5MgsgLVF7KpmZRLsRjX3yfn3bLbjh35e+vNRGpRRK6ND3lQeY+R5cDXgDxZYp3aukmIVBXKBN1FEDsjjadJjg=
Received: by 10.86.76.16 with SMTP id y16mr2350334fga.1188722015587;
        Sun, 02 Sep 2007 01:33:35 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 28sm3215742fkx.2007.09.02.01.33.30
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Sep 2007 01:33:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200708190128.43515.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57307>

This is partial summary of Git User's Survey 2007 after 2 weeks of 
running. It is based on "View Text Results" page:
  http://www.survey.net.nz/members.php?page=results&qn=1304

The same information but in graphical form you can see at
  http://www.survey.net.nz/results.php?94e135ff41e871a1ea5bcda3ee1856d9


10. What other SCM did/do you use?

Note that this question does not distinguish between SCMs/VCSs which 
were used prior to Git and used no longer, SCMs which are used beside 
(in parallel) to Git perhaps interacting with Git, and SCMs which are 
used instead of Git. Also note that this is _Git User's_ survey, so it 
those number for example do not represent number of e.g. users of 
Mercurial as compared to e.g. users of Subversion.

Below there is table of SCM used, sorted by the number of responses.
Note that annotations (like "a little CVS") were not weighted here.

There were 502 responses, 25 null responses (eviovalent to "none").
Only SCMs which has count more that 10 are shown. One person can (and 
usually did) chose more than one SCM.

  Name                      Count
  --------------------------------------------------
  Subversion                399
  CVS                       362
  Mercurial                 73
  Darcs                     59
  GNU Arch                  52
  RCS                       45
  Bazaar-NG                 40
  Perforce                  34
  ClearCase                 31
  Monotone                  23
  BitKeeper                 23
  Bazaar                    17
  SVK                       16
  SourceSafe                11
  SCCS                      10

  tla+baz+bzr               109

As you can see two most popular SCMs are Subversion ('svn') and CVS, 
with Subversion being slightly more popular. Among distributed SCMs 
with most count are Mercurial ('hg') and Arch and its descendants 
('tla', 'baz', 'bzr').


35. How does GIT compare to other SCM tools you have used?

  Answer                    Count
  ------------------------------------------------
  Better                    388
  Comparable (equal)        73
  Worse                     24

  TOTAL                     485 (129 null)

Clearly Git is superior SCM! (In the minds of _Git users_) ;-)
Seriously, one should take into consideration that those results
are biased, because it is _Git User's_ Survey, and people usually
choose SCM because they think it is best choice.

No answer (null answer) might mean that responder does not use and did 
not use other SCMs to compare, or at least think that he/she does not 
have sufficient basis for a comparison.


====================================================================

26. Which porcelains do you use?

Multiple answers (one can use more than one porcelain).

  Porcelain                   Count
  ------------------------------------------------
  core-git                    428
  Cogito (deprecated)         45

 Patch management interface layers:
 ..................................
  StGIT                       37
  Guilt (formerly gq)         13
  pg (deprecated, abandoned)  7

  my own scripts              74
  other                       11

It is understandable that Cogito still has some users, even though it is 
deprecated, and [I think] all of its functionality can be found in 
git-core porcelain. It was meant as SCM / porcelain layer when git-core 
didn't have it and consisted almost only of plumbing commands.

Quite a bit of people use patch management interface: StGIT, Guilt, even 
deprecated and abandoned pg (Patchy Git). StGIT has more users than 
Guilt, although that might be caused by the fact that StGIT was here 
longer...

It is interesting that quite a bit of responders script their git usage: 
74 "my own script" users.

I am wondering what those 11 other are...


27. Which git GUI do you use?

Multiple answers (one can use more than one GUI). Note that for the 
first week and a bit of survey "CLI" answer had no explanation that it 
means command line interface, so results might be bit skewed.

  GUI                         Count
  ------------------------------------------------
  CLI (command line)          295
  gitk                        266
  git-gui                     91
  qgit                        68
  giggle                      43
  gitview                     13
  instaweb                    13
  tig                         38
  (h)gct                      3
  qct                         3
  KGit                        7
  git.el                      25
  other                       10

  giggle + gitview            56

As one can see almost as many people use gitk as CLI. Most used GUI are 
gitk and git-gui, most probably because they are distributed with git, 
and because they are portable. QGit is also quite popular, although 
GTK+ viewers, namely giggle and gitview have the same count summary 
(note that there might be instances of users using both giggle and 
gitview). I am a bit suprised about Giggle, I'd say.

Tig (text-mode interface for git) and git.el (GIT mode for Emacs) are 
also quite popular.

I wonder what are those 10 other GUI... and I didn't provide "What is 
this 'other GUI'?" question...


=====================================================================

44. Do you use the GIT wiki?

  233 yes, 239 no, 112 no answer

56. Do you read the mailing list? 

  168 yes, 303 no, 114 no answer

59. Do you use the IRC channel (#git on irc.freenode.net)?

  148 yes, 281 no, 198 no answer

(I do wonder a bit about "no answer" here. Does it mean: "There is git 
wiki/git mailing list/#git IRC channel?!? I didn't know."? Or does it 
mean something else: "I was too tired to answer this question...")

-- 
Jakub Narebski
Poland
