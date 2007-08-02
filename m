From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Add a --user option to git-config
Date: Thu, 02 Aug 2007 20:44:13 +0100
Message-ID: <46B2340D.4080109@ramsay1.demon.co.uk>
References: <46AB7041.8070605@ramsay1.demon.co.uk>	<Pine.LNX.4.64.0707282103150.14781@racer.site>	<46AFAF7D.7010306@ramsay1.demon.co.uk>	<Pine.LNX.4.64.0708011913070.14781@racer.site> <7vzm1b3y3w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 20:02:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH1Tk-0005Bq-27
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 20:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757074AbXHCSCT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 14:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756702AbXHCSCT
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 14:02:19 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:3837 "EHLO
	anchor-post-31.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756517AbXHCSCS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 14:02:18 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.42)
	id 1IH1Ta-000Cc6-4Y; Fri, 03 Aug 2007 18:02:14 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vzm1b3y3w.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54737>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>> Yep, which is why I made it a synonym; git-gui uses the
>>> --global option, for example, and I'm confident that other
>>> (user) scripts use it too. The "future" I had in mind was
>>> something like 1 year down the road, but it could be longer
>>> (or forever) if necessary.
>> Please read my reply as "I vote against ever removing the --global 
>> option".
> 
> I would say with --system present, I do not see much point
> having the new alias --user either.  Get used to it.  It is
> global across the repositories you have control over.
> 

OK

ATB,

Ramsay Jones
