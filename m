X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: selective git-update-index per diff(1) chunks
Date: Mon, 04 Dec 2006 22:51:34 +0100
Message-ID: <20061204215134.GJ940MdfPADPa@greensroom.kotnet.org>
References: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com>
 <el1nsi$vat$1@sea.gmane.org>
 <20061204202102.GH940MdfPADPa@greensroom.kotnet.org>
 <200612042146.06419.jnareb@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 4 Dec 2006 21:51:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200612042146.06419.jnareb@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33258>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrLit-0004lH-NT for gcvg-git@gmane.org; Mon, 04 Dec
 2006 22:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967200AbWLDVvh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 16:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967408AbWLDVvh
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 16:51:37 -0500
Received: from smtp19.wxs.nl ([195.121.247.10]:37170 "EHLO smtp19.wxs.nl"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S967200AbWLDVvg
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 16:51:36 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by smtp19.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.07
 (built Jun 24 2005)) with SMTP id <0J9R0034DRDYAP@smtp19.wxs.nl> for
 git@vger.kernel.org; Mon, 04 Dec 2006 22:51:35 +0100 (CET)
Received: (qmail 25186 invoked by uid 500); Mon, 04 Dec 2006 21:51:34 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, Dec 04, 2006 at 09:46:06PM +0100, Jakub Narebski wrote:
> If it is GPL, you can post it anyway. As I understand from log
> you have added git interface, isn't it?

I think Paul added the ability to compare a git tree to a (set of)
directory trees, while I add a primitive way of committing partial
changes to a git branch.  It's been over a year, though, so I may
be mistaken.

> You are then perfectly
> in the right to post info at GitWiki about this tool.

I feel like I should check first that it hasn't been obsoleted by
some other tool already and I currently don't have the time to
investigate.

