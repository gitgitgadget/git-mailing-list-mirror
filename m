From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Wine + GIT
Date: Mon, 05 Dec 2005 21:18:54 -0500
Message-ID: <4394F50E.7030803@pobox.com>
References: <4394CD68.8020500@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 03:20:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjSQ1-0003wq-Ih
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 03:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVLFCS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 21:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbVLFCS6
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 21:18:58 -0500
Received: from mail.dvmed.net ([216.237.124.58]:32144 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964924AbVLFCS5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 21:18:57 -0500
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EjSPx-0002zc-4G; Tue, 06 Dec 2005 02:18:57 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Mike McCormack <mike@codeweavers.com>
In-Reply-To: <4394CD68.8020500@codeweavers.com>
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Mike McCormack wrote: > Hi All, > > The Wine project
	has started maintaining a wine.git in parallel to the > Wine CVS. To
	introduce Wine developers to GIT, we've put together a > short
	introduction on the Wine Wiki on using GIT to maintain patches. > You
	can find it at: > > http://wiki.winehq.org/GitWine [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13248>

Mike McCormack wrote:
> Hi All,
> 
> The Wine project has started maintaining a wine.git in parallel to the 
> Wine CVS.  To introduce Wine developers to GIT, we've put together a 
> short introduction on the Wine Wiki on using GIT to maintain patches. 
> You can find it at:
> 
> http://wiki.winehq.org/GitWine

One other comment:  http:// is the slowest of all three transports. 
git:// (git daemon) is preferred, followed by rsync.

http:// takes forever, comparatively.

	Jeff
