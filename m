From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 21:08:10 +0200
Message-ID: <200509292108.11092.oliver@neukum.org>
References: <433BC9E9.6050907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 21:09:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL3lR-0005I4-Sp
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 21:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVI2TIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 15:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVI2TIO
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 15:08:14 -0400
Received: from mail1.kontent.de ([81.88.34.36]:29673 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932195AbVI2TIN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 15:08:13 -0400
Received: from p549A2192.dip0.t-ipconnect.de (p549A2192.dip0.t-ipconnect.de [84.154.33.146])
	by Mail1.KONTENT.De (Postfix) with ESMTP id 4235210D9F46;
	Thu, 29 Sep 2005 21:08:21 +0200 (CEST)
To: Jeff Garzik <jgarzik@pobox.com>
User-Agent: KMail/1.8
In-Reply-To: <433BC9E9.6050907@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9496>

Am Donnerstag, 29. September 2005 13:03 schrieb Jeff Garzik:
> 
> Just updated my KHGtG to include the latest goodies available in 
> git-core, the Linux kernel standard SCM tool:
> 
> 	http://linux.yyz.us/git-howto.html
> 
> Several changes in git-core have made working with git a lot easier, so 
> be sure to re-familiarize yourself with the development process.
> 
> Comments, corrections, and notes of omission welcome.  This document 
> mainly reflects my typical day-to-day git activities, and may not be 
> very applicable outside of kernel work.

Unfortunately, following the instructions to the letter produces this:
oliver@oenone:~/linux-2.6> git checkout
usage: read-tree (<sha> | -m <sha1> [<sha2> <sha3>])

	Regards
		Oliver
