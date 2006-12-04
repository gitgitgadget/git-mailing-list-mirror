X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: latest update to git-svn blows up for me
Date: Mon, 4 Dec 2006 12:08:45 -0800
Message-ID: <20061204200844.GC30316@hand.yhbt.net>
References: <863b7wnwcw.fsf@blue.stonehenge.com> <20061204070021.GG1369@localdomain> <86hcwbnb0o.fsf@blue.stonehenge.com> <20061204181241.GA27342@soma> <86zma3lahj.fsf@blue.stonehenge.com> <20061204195452.GB27342@soma> <86slfvl95j.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 20:08:56 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <86slfvl95j.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33237>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrK7R-0004lS-Ou for gcvg-git@gmane.org; Mon, 04 Dec
 2006 21:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966439AbWLDUIr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 15:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966599AbWLDUIq
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 15:08:46 -0500
Received: from hand.yhbt.net ([66.150.188.102]:42015 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S966439AbWLDUIp
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 15:08:45 -0500
Received: by hand.yhbt.net (Postfix, from userid 500) id 2DA0A2DC034; Mon,  4
 Dec 2006 12:08:45 -0800 (PST)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:
> 
> Eric> Can you try:
> 
> Eric> git update-ref refs/remotes/git-svn \
> Eric>   <last commit successfully imported from git-svn>
> 
> Eric> and running rebuild again?
> 
> Yes, and now after seeing 14000 lines scroll by, I tried again:

<snip>

> Anything you want me to try now?  I'm not in a fast net place (at
> least not for a week), so I can't rebuild from scratch.

Which version of the SVN libraries are you using?  Also, are you
tracking https://svn.perl.org/parrot/trunk or just
https://svn.perl.org/parrot (top-level)

-- 
