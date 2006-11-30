X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 17:33:04 +0100
Message-ID: <20061130163304.GN12463MdfPADPa@greensroom.kotnet.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <200611301449.55171.andyparkins@gmail.com>
 <20061130152011.GM12463MdfPADPa@greensroom.kotnet.org>
 <200611301530.51171.andyparkins@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 30 Nov 2006 16:33:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200611301530.51171.andyparkins@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32772>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpoqW-0003Ep-5J for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759261AbWK3QdI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759260AbWK3QdI
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:33:08 -0500
Received: from psmtp02.wxs.nl ([195.121.247.11]:51373 "EHLO psmtp02.wxs.nl")
 by vger.kernel.org with ESMTP id S1759261AbWK3QdF (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:33:05 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by psmtp02.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.07
 (built Jun 24 2005)) with SMTP id <0J9J008C1XZ4YR@psmtp02.wxs.nl> for
 git@vger.kernel.org; Thu, 30 Nov 2006 17:33:04 +0100 (MET)
Received: (qmail 18598 invoked by uid 500); Thu, 30 Nov 2006 16:33:04 +0000
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Thu, Nov 30, 2006 at 03:30:49PM +0000, Andy Parkins wrote:
> On Thursday 2006 November 30 15:20, Sven Verdoolaege wrote:
> > How are you going to checkout the right commit of the lixcb repo if
> > you didn't store it in the supermodule ?
> 
> Well, I know what the commit is /that/ was all that was stored.  So I 

Then I have no idea what you are talking about.
A commit _contains_ all the history that lead up to that commit,
so if you have the commit, then you also have the history.

