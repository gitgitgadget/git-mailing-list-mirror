From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 11:57:49 +0200
Message-ID: <20070521095749.GI942MdfPADPa@greensroom.kotnet.org>
References: <11796842882917-git-send-email-skimo@liacs.nl>
 <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net>
 <20070520195930.GX942MdfPADPa@greensroom.kotnet.org>
 <20070520205444.GC25462@steel.home>
 <20070520210954.GB942MdfPADPa@greensroom.kotnet.org>
 <20070520212432.GE25462@steel.home>
 <20070520214732.GC942MdfPADPa@greensroom.kotnet.org>
 <20070520222621.GG25462@steel.home>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 11:58:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq4eZ-0000pw-4I
	for gcvg-git@gmane.org; Mon, 21 May 2007 11:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbXEUJ5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 05:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755716AbXEUJ5v
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 05:57:51 -0400
Received: from smtp19.wxs.nl ([195.121.247.10]:61869 "EHLO smtp19.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964AbXEUJ5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 05:57:50 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JID00I1WYCDUC@smtp19.wxs.nl> for git@vger.kernel.org; Mon,
 21 May 2007 11:57:49 +0200 (CEST)
Received: (qmail 6799 invoked by uid 500); Mon, 21 May 2007 09:57:49 +0000
In-reply-to: <20070520222621.GG25462@steel.home>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48002>

On Mon, May 21, 2007 at 12:26:21AM +0200, Alex Riesen wrote:
> Sven Verdoolaege, Sun, May 20, 2007 23:47:32 +0200:
> > 
> > How would _you_ specify which subprojects to checkout ?
> > 
> 
> Aren't the ones which already have .git in them are kind of specified?
> 

Would you always recurse into these submodules, regardless of
any option?
Or would you want two options, one for handling the submodules
you have explicitly marked someway and one for getting all submodules?

skimo
