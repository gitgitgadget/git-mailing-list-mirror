X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 15:53:23 +0200
Organization: At home
Message-ID: <ehqeja$d5j$1@sea.gmane.org>
References: <20061022185350.GW75501@over-yonder.net>	<Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>	<20061023222131.GB17019@over-yonder.net>	<Pine.LNX.4.64.0610231534010.3962@g5.osdl.org>	<20061024002622.GC17019@over-yonder.net>	<Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz>	<20061024163458.GH17019@over-yonder.net>	<Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz>	<20061025002713.GN17019@over-yonder.net>	<Pine.LNX.4.63.0610251459160.1754@qynat.qvtvafvgr.pbz>	<20061025235306.GD17019@over-yonder.net> <45408A53.10400@op5.se> <4540BC6B.1050009@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 26 Oct 2006 13:53:51 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.git
Original-Lines: 32
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30220>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd5fl-0004aT-U5 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 15:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161395AbWJZNxZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 09:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161398AbWJZNxZ
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 09:53:25 -0400
Received: from main.gmane.org ([80.91.229.2]:56714 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161396AbWJZNxY (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 09:53:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd5fN-0004WO-4f for git@vger.kernel.org; Thu, 26 Oct 2006 15:53:05 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 15:53:05 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 15:53:05 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Aaron Bentley wrote:

> Andreas Ericsson wrote:

>> The only issue I have with bzr's revno's and truly distributed setup is
>> that, by looking at the table, it seems to claim that you have found
>> some miraculous way to make revnos work without a central server. Since
>> everyone agrees that they don't, this should IMO be listed as mutually
>> exclusive features.
> 
> The "simple namespace" is both a URL and a revno.
> 
> And therefore, it's just as distributed and decentralized as the web.
> 
> There is very little difference between this:
> 
> http://example.com/mywebpage#5
> 
> And this:
> 
> http://example.com/mybranch 5
> 
> In fact, we've been planning to unify them into one identifier.

Well, then it is not much simpler than 8-chars sha1. And sha1 is more
decentralized, because you can use it when you don't have access to net,
and when the _central_ revno server is down.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

