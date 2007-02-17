From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: monotone is slow
Date: Sat, 17 Feb 2007 01:19:01 -0500
Message-ID: <20070217061901.GB27864@spearce.org>
References: <9e4733910702161320s12ba7a2boadaf075993579900@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 17 07:19:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIIue-0006UP-0H
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 07:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946414AbXBQGTJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 01:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946419AbXBQGTI
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 01:19:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59840 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946414AbXBQGTI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 01:19:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HIIuX-0004L8-NH; Sat, 17 Feb 2007 01:19:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2FD9820FBAE; Sat, 17 Feb 2007 01:19:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <9e4733910702161320s12ba7a2boadaf075993579900@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39967>

Jon Smirl <jonsmirl@gmail.com> wrote:
> 45 CPU minutes to do a pull. About 2hrs real time.
> 
> jonsmirl@jonsmirl:~$ ps aux | grep mtn
> jonsmirl  8382 80.5  4.4 131444 115204 pts/0   S+   14:54  45:44 mtn pull
> 
> And it worked, nothing was wrong. 1,500 revs pulled.

Uhhh..  wasn't this something already known about Monotone?

> Let's convert the world to git.

Uhhh.. didn't we try that already?  Only to find out Windows matters
more than anything else?  ;-)

-- 
Shawn.
