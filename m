From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 18:46:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508031845001.24273@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508021942500.3341@g5.osdl.org> <7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508030808530.3341@g5.osdl.org> <7vr7dbhvci.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508030913060.3341@g5.osdl.org> <7vk6j3f044.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 18:49:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0MPZ-0001vG-5B
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 18:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVHCQrC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 12:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVHCQrC
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 12:47:02 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45016 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262340AbVHCQqr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 12:46:47 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DA18CE236E; Wed,  3 Aug 2005 18:46:41 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BBB67B345E; Wed,  3 Aug 2005 18:46:41 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9F98BB3464; Wed,  3 Aug 2005 18:46:41 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7B9CBE236E; Wed,  3 Aug 2005 18:46:41 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6j3f044.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 3 Aug 2005, Junio C Hamano wrote:

> Sorry, you have not lost anything.  It is my bad that this is
> the first time I brought it up.  I've been seeing that from time
> to time when I push to either my "send to master" repository
> from my working repository, or from the "send to master"
> repository to master.kernel.org, but I haven't figured it out if
> there is any pattern.

This could be related to what I was realizing the other day: when trying 
to push to a repository (just one branch), but I do not have _all_ of the 
remote branches pulled, then it fails.

Ciao,
Dscho
