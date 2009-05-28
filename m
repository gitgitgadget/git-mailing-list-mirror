From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Survey on DVCS usage and experience
Date: Thu, 28 May 2009 04:55:12 -0700 (PDT)
Message-ID: <m3tz35bfxm.fsf@localhost.localdomain>
References: <75599A84-8A53-4DA4-A022-1BEF4EEDA943@usask.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian de Alwis <brian.de.alwis@usask.ca>
X-From: git-owner@vger.kernel.org Thu May 28 13:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9eCf-00052w-Oi
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 13:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315AbZE1LzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 07:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755458AbZE1LzN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 07:55:13 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:39074 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441AbZE1LzL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 07:55:11 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so4177033pzk.33
        for <git@vger.kernel.org>; Thu, 28 May 2009 04:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=uKn6cqpt/dXDSq5E/KO6AgMuRYiz+9B8IWNRLK7wIc4=;
        b=qaTgwZgb3erS5v/Bw/32tPMGZwCYBKEM6+KjVXx9UwLd5FLdDx/zOGx0HIjGlLZ12f
         AtmE5C4A0WuffJWFrOg/xzhtHdOPFF63XVrzWnmnDDuLfjpF78+Ul/WsSXFWIXrwIijb
         4H5UJQrsj/FxIu0YUC7pxNdgIP5lCqKwt8xhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=jVTjG8EAlTMF4xs8VjkV9S7yOATH64y4Oq5AF6U4pojfv7vYUuPDZSYqOH4CnxVkVY
         eLPTsN296O4FE1xUrjrJ13n/VhZRvIc6JqFma7o/99VWodZJFBy1CbhEsde6rkt0sswT
         100JDL1d/j9u+hMcdaBmvbwvyfFPW/TSblqaM=
Received: by 10.142.246.20 with SMTP id t20mr346212wfh.348.1243511713879;
        Thu, 28 May 2009 04:55:13 -0700 (PDT)
Received: from localhost.localdomain (absg169.neoplus.adsl.tpnet.pl [83.8.126.169])
        by mx.google.com with ESMTPS id 24sm2239854wff.31.2009.05.28.04.55.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 04:55:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4SBt4nI029312;
	Thu, 28 May 2009 13:55:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4SBt2jf029309;
	Thu, 28 May 2009 13:55:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <75599A84-8A53-4DA4-A022-1BEF4EEDA943@usask.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120185>

Brian de Alwis <brian.de.alwis@usask.ca> writes:

> Hello everybody.  I'm part of a team conducting a survey to understand
> the perceived benefits and challenges of using a decentralized or
> distributed version control systems (DVCS) in software development.
> Presuming that most people on this list have used a DVCS :)  we would
> like to invite all people over 18 years old to participate in our survey
> and share your experiences.  Details on partcipating are below.
> Thanks for your time!
> 
> Brian.

I don't know what channels did you use to distribute information about
this survey, but you might want to consider the following additional
channels (some of those channels were used in announcing Git User's
Survey in 2006-2008, see e.g. http://git.or.cz/gitwiki/GitSurvey2008):

 * Mailing lists for other DVCS you include in your survey, like
   Bazaar and Monotone (in addition to current Git and Mercurial),
   perhaps using GMane news (NNTP, Usenet) to mail interface.

 * Homepages and/or wikis for DVCS such as Git, Mercurial, Bazaar,
   Monotone, Darcs.  Git User's Surveys were announced on Git homepage
   (http://git-scm.com) and Git Wiki (http://git.or.cz/gitwiki/)

 * News / Announcement sections of software hosting sites, and/or
   blogs for those hosting sites.  Git User's Surveys were announced
   on git hosting sites: repo.or.cz, git.kernel.org, Gitorious and
   GitHub.  You might want to contact admin of BitBucket (Mercurial)
   and Launchpad (Bazaar), and some commercial hosting sites, to add
   announcement about survey.

 * Blogs related to DVCS or version control in general such as
   http://www.versioncontrolblog.com/ and/or blogs by maintainers,
   creators, or people important to given DVCS like Junio C. Hamano or
   Linus Torvalds for Git, or Mark Shuttleworth for Bazaar (via
   Ubuntu), or Bram Cohen for Codeville; or perhaps generic
   programmers blogs such as Eric Sink blog or Coding Horror, or Joel
   On Software.

 * You might also want to either announce from time to time on DVCS
   related IRC channels (mainly on FreeNode) such as #revctrl, #git,
   #bazaar, #mercurial, #monotone, #github etc., or ask sysop to add
   announcement to channel topic (using some kind of URL shortening
   service, with menmonic short name)

 * Git User's Survey 2008 was also announced on Ohloh, open source
   software metric site.

 * You might also want to at least try to add announcement on news
   sites such as LWN.net or community sites such as Slashdot, Digg or
   Reddit; the latter might prove difficult...

I hope that this would help.
-- 
Jakub Narebski
Poland
