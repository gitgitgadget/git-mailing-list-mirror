From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] vcs-svn: Fix 'fa/remote-svn' and 'fa/vcs-svn' in pu
Date: Thu, 30 Aug 2012 18:28:36 +0100
Message-ID: <503FA2C4.5020308@ramsay1.demon.co.uk>
References: <50366E9B.7040803@ramsay1.demon.co.uk> <22437025.vxzLHcuBYA@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: florian.achleitner.2.6.31@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 19:30:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T78Zn-0007ei-Pr
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 19:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab2H3Rab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 13:30:31 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:41636 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751179Ab2H3Rab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 13:30:31 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 474F94002B2;
	Thu, 30 Aug 2012 18:30:30 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 227C34002AF;	Thu, 30 Aug 2012 18:30:29 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Thu, 30 Aug 2012 18:30:24 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <22437025.vxzLHcuBYA@flomedio>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204558>

Florian Achleitner wrote:
> Hi!
> 
> Thanks for your fixups. I'm currently integrating them in a new series.
> On what platform did you find that problems? 
> Tried to reproduce them on 64bit Linux. Anyways the fixes look very reasonable.

I found the problem on Linux, cygwin and MinGW. That would be *32-bit* Linux,
cygwin and MinGW, of course. ;-)

ATB,
Ramsay Jones
