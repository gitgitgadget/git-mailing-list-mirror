X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 12:10:27 +0100
Message-ID: <20061201111027.GR12463MdfPADPa@greensroom.kotnet.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <200612011029.28059.andyparkins@gmail.com>
 <20061201104256.GQ12463MdfPADPa@greensroom.kotnet.org>
 <200612011102.17079.andyparkins@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 1 Dec 2006 11:11:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200612011102.17079.andyparkins@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32895>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq6I0-0004IB-TC for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936422AbWLALKm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936429AbWLALKm
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:10:42 -0500
Received: from smtp17.wxs.nl ([195.121.247.8]:51102 "EHLO smtp17.wxs.nl") by
 vger.kernel.org with ESMTP id S936422AbWLALKl (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:10:41 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by smtp17.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built
 Jul 14 2004)) with SMTP id <0J9L00AMEDPFMS@smtp17.wxs.nl> for
 git@vger.kernel.org; Fri, 01 Dec 2006 12:10:28 +0100 (CET)
Received: (qmail 20347 invoked by uid 500); Fri, 01 Dec 2006 11:10:27 +0000
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, Dec 01, 2006 at 11:02:15AM +0000, Andy Parkins wrote:
> On Friday 2006 December 01 10:42, Sven Verdoolaege wrote:
> 
> > He showed it to you in the example.  The "submodule object" is the COMMIT
> > of the submodule itself.
> 
> That's no different from mine.  I need more detail than that.

You were proposing to create an extra object containing some random value
that is disconnected from the repo.

> Is that commit in the submodule or the supermodule?

It's in BOTH.  That's why it's a *sub*module.

Someone else can try to expain it you.

