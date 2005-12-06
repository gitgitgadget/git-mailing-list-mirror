From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Wine + GIT
Date: Tue, 06 Dec 2005 14:01:49 -0500
Message-ID: <4395E01D.4080107@pobox.com>
References: <4394CD68.8020500@codeweavers.com> <4394F173.6000505@pobox.com> <20051206170803.GD17457@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 20:05:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eji5W-0004ch-Kg
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 20:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVLFTCG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 14:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbVLFTCF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 14:02:05 -0500
Received: from mail.dvmed.net ([216.237.124.58]:61847 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030187AbVLFTCC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 14:02:02 -0500
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1Eji4Y-0003uP-9D; Tue, 06 Dec 2005 19:01:56 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20051206170803.GD17457@fieldses.org>
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  J. Bruce Fields wrote: > On Mon, Dec 05, 2005 at
	09:03:31PM -0500, Jeff Garzik wrote: > >>2) The "git-foo" commands are
	apparently uncool. "git foo ..." is >>preferred. > > > How does e.g.
	git-diff differ from git diff? I thought they were > equivalent.--b.
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13285>

J. Bruce Fields wrote:
> On Mon, Dec 05, 2005 at 09:03:31PM -0500, Jeff Garzik wrote:
> 
>>2) The "git-foo" commands are apparently uncool.  "git foo ..." is 
>>preferred.
> 
> 
> How does e.g. git-diff differ from git diff?  I thought they were
> equivalent.--b.

The specific git-diff-XXX command example was longer.

In general, there is not much difference, except that I was admonished 
to avoid the git-XXX in my howto.  I suppose that makes sense if the 
git-XXX programs are moved out of $prefix/bin, leaving only $prefix/bin/git.

	Jeff
