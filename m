From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gittogether session notes
Date: Fri, 29 Oct 2010 12:26:15 -0700 (PDT)
Message-ID: <m3ocachkcy.fsf@localhost.localdomain>
References: <20101029180530.GA18997@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 29 21:26:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBuaq-0000SE-Ad
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 21:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781Ab0J2T0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 15:26:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50697 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472Ab0J2T0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 15:26:18 -0400
Received: by bwz11 with SMTP id 11so2854303bwz.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 12:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=qIB5vVTnSpkuk5l9TJWyaRrWZvKzBjwknVEi62OFALs=;
        b=WOqSkkKlctdJebvJChiDirYeUeJ5RkPRqhRdQd+BSIMBWS8fSSux6667bUgTjGJVN2
         UrCdIOFmPL2u1p75XEFjfI5OZFE1hrMUuVb6mrc0dG5li3RlnOPDqMSYjC66Z82tWTAg
         QeSYg87s29EgoA8TjECkFLidRpC9yYvivnqYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=qQM07i1MGvwQ4aD1qJuHw2MeNEM/kd6dxUG5ek+QZPsNQmrsaTYd8EIT4pt02GQKVG
         UXclViHkMhjlDEnO67H8M3AHeytNGpb1gYivMdaKIzMJHnUa+G7vO8cHr8HIMXG8n5KB
         M0Og1KhAFdMZamQAJAxhQx9rMZTDh1yI92qP8=
Received: by 10.204.67.77 with SMTP id q13mr10018415bki.214.1288380376747;
        Fri, 29 Oct 2010 12:26:16 -0700 (PDT)
Received: from localhost.localdomain (abwf136.neoplus.adsl.tpnet.pl [83.8.229.136])
        by mx.google.com with ESMTPS id r21sm1111581bkj.10.2010.10.29.12.26.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 12:26:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9TJPkMa031676;
	Fri, 29 Oct 2010 21:25:57 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9TJPYWS031669;
	Fri, 29 Oct 2010 21:25:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101029180530.GA18997@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160357>

Jeff King <peff@peff.net> writes:

> For anyone interested, session notes from GitTogether '10 are here:
> 
>   https://git.wiki.kernel.org/index.php/GitTogether10#Session_notes
> 
> They are mostly rough transcriptions of the talks by a few volunteers,
> along with slides from some of the speakers.  Some of it may be
> incomplete or confusing, but I'm sure many of the speakers would be
> happy to carry discussion onto the list if emailed.

Thank you all who created and posted notes, and those who posted their
slides.  It was a good idea to use Etherpad, I think.


The page about GitTogether 2010 on Git Wiki has a section called
"Suggested Topics" - which of those were made, and what talks are
missing from it?

I have provided below list with all 'suggested topics', with short
note if there are session notes notes, or talks slides, and in what
format.  You can see from it which are yet missing notes and slides.

* How bup stores 1TB+ in git, and what exploded along the way
  slides (ODP), notes (etherpad), documentation (github)

* How can we make git-submodule/git-subtree usable by mere mortals?
  notes x 2 (etherpad)

* Dulwich
  notes (etherpad)
 
* Git on DHTs (Git on Cassandra)
  notes/slides (Google Docs)

* Distributed code reviews
  notes (etherpad)

* How to (not) abuse Git (multiple lightning talks)
  ???

* Resurrecting the exponential-stride/bisection algorithm; practical issues
  notes (etherpad)

* Git and Encryption : How To Do X
  notes (etherpad)

* Using Git in a centralized, Gui based environment - What we achieved
  and what could be improved
  slides (PDF), repositories (github)
  
* Tolerating clock skew in commit histories
  notes (etherpad)

* Git as Software Freedom Conservancy member project
  notes (etherpad)

* git-remote-hg
  notes (etherpad)

* Dealing with many large repositories with lots of old data
  notes (etherpad)

* State of libgit2
  notes (etherpad)

* Project status JGit / Projects using JGit / future roadmap
  notes (etherpad)

* Git Survey Results / Gerrit Survey Results
  notes (etherpad) - only Gerrit Survey


* Git Scalability at GitHub
  slides (PDF)

* How to improve Git Together
  notes (etherpad)


Below there are proposed talks which either weren't presented, or lack
notes / slides.
* Hudson and Gerrit integration
* What's new on github: pull requests, git based wiki etc.
* Git and Big Files
* git log -L demo, combination of log and blame
* RefInsteadOf (discussion)
* git-always-on


Below there are notes and/or slides for which I don't have name of
presentation, lightning talk, or discussion:

* Gitweb caching
  notes (etherpad)

* Distributed Android builds
  notes (etherpad)

* git-cheetah
  notes (etherpad)

* Gerrit submodules support
  notes (git wiki)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
