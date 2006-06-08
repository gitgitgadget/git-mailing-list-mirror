From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 08 Jun 2006 22:55:29 +0200
Organization: At home
Message-ID: <e6a2rt$n6p$1@sea.gmane.org>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de> <44880BE8.40804@etek.chalmers.se> <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de> <7v1wtzaa26.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP04DDBAA584B31A4B0F31DCAE8B0@CEZ.ICE> <Pine.LNX.4.63.0606082222470.28323@wbgn013.biozentrum.uni-wuerzburg.de> <BAYC1-PASMTP102B1021B943F57F9FB1EEAE8B0@CEZ.ICE> <Pine.LNX.4.63.0606082235020.28405@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 08 22:56:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoRY7-00068K-8r
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 22:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWFHU4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 16:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWFHU4M
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 16:56:12 -0400
Received: from main.gmane.org ([80.91.229.2]:22482 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965009AbWFHU4L (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jun 2006 16:56:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FoRXk-00062e-2D
	for git@vger.kernel.org; Thu, 08 Jun 2006 22:55:52 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 22:55:52 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 22:55:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21514>

Johannes Schindelin wrote:

> BTW it is the same reason I would rather not see /etc/gitconfig: it 
> meddles with an existing configuration. If you want to give defaults, you 
> can use a skeleton for $HOME, and templates for $GIT_DIR. As a user, I 
> would be very surprised if the behaviour of git changed from one day to 
> the other without my changing anything.

I agree wholeheartily. I guess that the 'skeleton' part has yet to be
written...

-- 
Jakub Narebski
Warsaw, Poland
