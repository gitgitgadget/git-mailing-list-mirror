X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 11:52:36 +0200
Message-ID: <453F33E4.2000708@op5.se>
References: <45357CC3.4040507@utoronto.ca>	<20061021191949.GA8096@coredump.intra.peff.net>	<20061021214629.GO75501@over-yonder.net>	<200610220025.32108.jnareb@gmail.com>	<1161474168.9241.188.camel@localhost.localdomain> <8764ed1b7z.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 09:52:50 +0000 (UTC)
Cc: Jeff Licquia <jeff@licquia.org>, Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <8764ed1b7z.wl%cworth@cworth.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30044>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcfRC-0002NI-HK for gcvg-git@gmane.org; Wed, 25 Oct
 2006 11:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423159AbWJYJwj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 05:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423168AbWJYJwj
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 05:52:39 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:63672 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1423159AbWJYJwj (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 05:52:39 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id C8DC46BDE3; Wed,
 25 Oct 2006 11:52:37 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id A44486BD5E; Wed, 25 Oct 2006 11:52:36 +0200 (CEST)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth wrote:
> On Sat, 21 Oct 2006 19:42:47 -0400, Jeff Licquia wrote:
>> I don't think so.  Recently, I've been trying to track a particular
>> patch in the kernel.  It was done as a series of commits, and probably
>> would have been its own branch in bzr, but when I was trying to group
>> the commits together to analyze them as a group, the easiest way to do
>> that was by the original committer's name.
> 
> As far as "its own branch in bzr" would such a branch remain available
> indefinitely even after being merged in to the main tree?
> 
>> Now, there's probably a better way to hunt that stuff down, but in this
>> case hunting the user down worked for me.  (It may have made a
>> difference that I was using gitweb instead of a local clone.)
> 
> Vast, huge, gaping, cosmic difference.
> 
> Almost none of the power of git is exposed by gitweb. It's really not
> worth comparing. (Now a gitweb-alike that provided all the kinds of
> very easy browsing and filtering of the history like gitk and git
> might be nice to have.)
> 

There was one, but it got discontinued due to performance issues. Shame 
that, because it would have been nice to have to show "foreign" visitors 
how gitk/qgit works. It would especially show the way git thinks about 
branches and stuff like that.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
