From: Junio C Hamano <junkio@cox.net>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Thu, 24 Nov 2005 00:33:49 -0800
Message-ID: <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 09:35:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfCZE-0003xB-31
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 09:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbVKXIdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 03:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbVKXIdx
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 03:33:53 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:21460 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030624AbVKXIdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 03:33:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124083322.FWGN15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 03:33:22 -0500
To: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <43857430.7060103@op5.se> (Andreas Ericsson's message of "Thu, 24
	Nov 2005 09:05:04 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12694>

Andreas Ericsson <ae@op5.se> writes:

> git-config-set handles configuration for a particular repo, so 
> git-repo-config is better, IMO.

Ok, so git-repo-config that is.  Johannes?
