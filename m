X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [DRAFT 2] Branching and merging with git
Date: Fri, 15 Dec 2006 16:41:56 -0500
Message-ID: <20061215214156.GK30858@fieldses.org>
References: <7vslghftix.fsf@assigned-by-dhcp.cox.net> <20061120235136.4841.qmail@science.horizon.com> <elv4f5$kcj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 21:42:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <elv4f5$kcj$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34554>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvKot-0004ra-1a for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753493AbWLOVl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbWLOVl6
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:41:58 -0500
Received: from mail.fieldses.org ([66.93.2.214]:36668 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753492AbWLOVl6 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 16:41:58 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GvKoW-0004mA-2s; Fri, 15 Dec 2006
 16:41:56 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, Dec 15, 2006 at 10:38:05PM +0100, Jakub Narebski wrote:
> linux@horizon.com wrote:
> 
> > I tried to incorporate all the suggestions.  There are still a few things
> > I have to research, and now I'm worried it's getting too long.  Sigh.
> 
> Tutorials can (and usually are) be long, don't worry.
>  
> 
> Could you resend this as patch creating Documentation/tutorial-3.txt
> This way it would be in the repository, and people would be able to correct
> this (I guess that it at first would appear in 'next' branch)...

Yes please.  Even if it has some problems or isn't really a perfect fit
in the current tutorial sequence, we can fix that later.

