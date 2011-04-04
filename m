From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: GSoC 2011 : one more interested student.
Date: Mon, 4 Apr 2011 21:27:35 +0530
Message-ID: <20110404155731.GA30215@kytes>
References: <4D9912F8.60002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Cyril Roelandt <tipecaml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 17:58:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6mAy-0001P5-DP
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 17:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab1DDP6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 11:58:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35312 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750Ab1DDP6m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 11:58:42 -0400
Received: by iwn34 with SMTP id 34so5882270iwn.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=nRuwQKR9eSHkyG0pvR7r2hSB5YRJlQyNantvsNDvM9s=;
        b=hFeqL0BKze5tNFtyWIALyWsXTMPLhddsU4fsm2Ycm1JhpJfSNcEhDNIxLMMBGUkVRP
         921iSJjM0OJ9qO7lWWxBuACwSYn87eNmio9u7tkEutgJofuEeaNMQRdHRXNvdQArGi2Y
         kK9l3MHEwrm9+DdatnmGDAb+NjkhkCGLHxHc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=onGTK0ylAlokz4SOIn1nN4sySOWqKEq09/HWLbzwNJ5WjXKvx1snjiFkBSt3jufGdH
         wds14ufCO5Vv6sna8HdurXc2jV2oZwQqmHrF2mx3E9MmkRs5CjYSgZl18xcokxJlmzow
         9hvSGucuBPdF5nLuLIB2LGrKPF14xHmtkikg8=
Received: by 10.231.194.87 with SMTP id dx23mr7292930ibb.133.1301932722124;
        Mon, 04 Apr 2011 08:58:42 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id e9sm538601ibb.32.2011.04.04.08.58.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 08:58:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9912F8.60002@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170822>

Hi Cyril,

Cyril Roelandt writes:
> I am currently studying Computer Science and Engineering. I have
> been using Open Source software for quite a while now, but I have
> not contributed a lot of code to Open Source projects - except for a
> few patches to Gnome.
> 
> Being a git user, I would be interested in working on this project.
> I believe that taking part in the GSoC would be a good opportunity
> for me to discover the guts of a version control system.

Thanks for writing.  We'd love to see more student proposals.

> * Complete some libgit2 features
> Implementing a few key features seems like a great way to understand
> the way a VCS works. I would be interesting in working on the diff
> command and on the network related commands (git-push, git-fetch).
> 
> * Build a minimal Git client based on libgit2
> It seems to be a quite popular task :) Hacking on this small git
> client would be a nice experience and would help me understanding
> how libgit2 works.

Yes, libgit2-related work in general seems to be very popular among
GSoC students this year :) Not to worry- you can make your application
stronger by sketching out a solid proposal and showing us some code.

> * Build in more external commands
> I am wondering why these commands should be rewritten. You know what
> they say : "if it is not broken, do not fix it" :-p Do these
> commands currently have performance issues ?

As Nguyen already pointed out, the rewrite is mostly motivated by
portability reasons.

> I will be working in a research lab until the end of June, but I
> will have more free time in July/August, that I could use to hack on
> git, which means I may have less time than most US students, who can
> enjoy a slightly longer summer break. Do you think it would be
> possible to work one of these projects anyway ?

>From my personal experience, most of the GSoC ideas listed on the Git
wiki page are quite demanding.  They're almost as engaging as a
full-time job.  I'd be especially worried about the mid-term
evaluations.  However, if you feel that you can take on a project,
please do so by all means -- include a convincing timeline in your
proposal.

Good luck with your application.

-- Ram
