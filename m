X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 11:42:56 +0100
Message-ID: <20061201104256.GQ12463MdfPADPa@greensroom.kotnet.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <200612010919.06030.andyparkins@gmail.com>
 <20061201095751.GK18810@admingilde.org>
 <200612011029.28059.andyparkins@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 1 Dec 2006 10:43:09 +0000 (UTC)
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200612011029.28059.andyparkins@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32887>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq5rB-0005hz-CV for gcvg-git@gmane.org; Fri, 01 Dec
 2006 11:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936187AbWLAKm6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 05:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936209AbWLAKm6
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 05:42:58 -0500
Received: from smtp18.wxs.nl ([195.121.247.9]:42935 "EHLO smtp18.wxs.nl") by
 vger.kernel.org with ESMTP id S936187AbWLAKm6 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 05:42:58 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by smtp18.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built
 Jul 14 2004)) with SMTP id <0J9L000ASCFK19@smtp18.wxs.nl> for
 git@vger.kernel.org; Fri, 01 Dec 2006 11:42:57 +0100 (CET)
Received: (qmail 20062 invoked by uid 500); Fri, 01 Dec 2006 10:42:56 +0000
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, Dec 01, 2006 at 10:29:26AM +0000, Andy Parkins wrote:
> I notice though that you avoided my question: what does YOUR submodule object 
> contain?

He showed it to you in the example.  The "submodule object" is the COMMIT
of the submodule itself.

