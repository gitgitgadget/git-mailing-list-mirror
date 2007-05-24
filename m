From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 12:54:45 +0200
Message-ID: <20070524105445.GJ942MdfPADPa@greensroom.kotnet.org>
References: <11799589913153-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <20070524072404.GF942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241033570.4648@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 24 12:55:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrAyI-0000D7-GD
	for gcvg-git@gmane.org; Thu, 24 May 2007 12:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897AbXEXKys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 06:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755660AbXEXKys
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 06:54:48 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:55929 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754888AbXEXKyr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 06:54:47 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIJ00BD8KZ95A@smtp17.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 12:54:46 +0200 (CEST)
Received: (qmail 12344 invoked by uid 500); Thu, 24 May 2007 10:54:45 +0000
In-reply-to: <Pine.LNX.4.64.0705241033570.4648@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48243>

On Thu, May 24, 2007 at 10:35:33AM +0100, Johannes Schindelin wrote:
> I was complaining that git-config, which is purely a local beast, gets 
> infected with even more obscure stuff. Junio mentions regularly that he 
> does not trust git-config that much, and given the number of fixes we 
> still get, I have to agree. So let's not put any more stuff into that 
> kitchen sink, especially if it has nothing to do with the configuration of 
> your repo.

Well, the name has been changed from git-repo-config some time ago...

skimo
