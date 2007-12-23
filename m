From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Sun, 23 Dec 2007 07:08:37 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0712230701520.14863@localhost.localdomain>
References: <200612241807.kBOI746w008739@laptop13.inf.utfsm.cl> <476E42BF.1010300@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Sun Dec 23 13:09:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Pdh-0003LY-5H
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 13:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbXLWMIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 07:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbXLWMIl
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 07:08:41 -0500
Received: from astoria.ccjclearline.com ([64.235.106.9]:59318 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbXLWMIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 07:08:40 -0500
Received: from [99.236.111.198] (helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1J6PdH-00026o-5m; Sun, 23 Dec 2007 07:08:39 -0500
X-X-Sender: rpjday@localhost.localdomain
In-Reply-To: <476E42BF.1010300@garzik.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69176>

On Sun, 23 Dec 2007, Jeff Garzik wrote:

> Another year, another update!  :)
>
> The kernel hacker's guide to git has received some updates:
>
> 	http://linux.yyz.us/git-howto.html
>
> This includes all the input sent to me in the past several months,
> as well as a few new tips and tricks I use on a regular basis.
>
> In general, this document is designed to be a quick-start cookbook,
> and not a comprehensive introduction.

there's one issue i have with this document, and that's that i wish it
more carefully distinguished between regular git "user" tasks, and git
"developer" tasks.

i may be mistaken, but it would seem that a lot of folks are going to
be what i call basic users, who only want to update their git tree,
check the logs, check the status and so on.  and if they start to get
ambitious, they might make some changes to the tree, do a diff, and
submit a patch.  but in the beginning, they won't be making commits or
switching branches, etc.

in short, i can see the value of something like a "getting started
with git as a basic user" tutorial.  does such a thing exist?

rday
--

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================
