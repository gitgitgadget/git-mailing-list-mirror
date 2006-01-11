From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Wed, 11 Jan 2006 11:11:58 -0600
Message-ID: <1136999518.29751.233.camel@cashmere.sps.mot.com>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	 <1136849810.11717.518.camel@brick.watson.ibm.com>
	 <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	 <1136900174.11717.537.camel@brick.watson.ibm.com>	<43C3CC4A.4030805@op5.se>
	 <1136910406.11717.579.camel@brick.watson.ibm.com>
	 <7vzmm36f1x.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0601102054200.27363@wbgn013.biozentrum.uni-wuerzburg.de>
	 <1136925066.11717.605.camel@brick.watson.ibm.com>
	 <Pine.LNX.4.63.0601102200040.31923@wbgn013.biozentrum.uni-wuerzburg.de>
	 <43C44CF2.5050808@op5.se> <7v8xtn4m59.fsf@assigned-by-dhcp.cox.net>
	 <43C4F292.7010404@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 18:13:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwjWd-0005TJ-HV
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 18:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbWAKRMY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 12:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWAKRMX
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 12:12:23 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:41113 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751498AbWAKRMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 12:12:08 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id k0BHQb3p014399;
	Wed, 11 Jan 2006 10:26:37 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k0BHJw7u011467;
	Wed, 11 Jan 2006 11:19:59 -0600 (CST)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C4F292.7010404@op5.se>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14491>

On Wed, 2006-01-11 at 05:57, Andreas Ericsson wrote:
> Junio C Hamano wrote:
> > 
> > True, but *please* stop calling "git wrapper" a potty.  It gives
> > me an impression that it is not connected to the plumbing.
> > 
> 
> Aww... And here I was being quite pleased with this wording in the man-page:
> 
> "The program git is just a wrapper to reach the core git programs (or  a 
> potty if  you like, as it's not exactly porcelain but still brings your 
> stuff to the plumbing)."

Oh man.  So, do we have to go with "kitchen sink" instead? ;-)

jdl
