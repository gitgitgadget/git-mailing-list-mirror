From: Junio C Hamano <junkio@cox.net>
Subject: Re: t4201-shortlog.sh does bad things to my terminal
Date: Mon, 23 Apr 2007 13:14:04 -0700
Message-ID: <7v4pn6g86r.fsf@assigned-by-dhcp.cox.net>
References: <20070423170301.GL955MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0704231928270.8822@racer.site>
	<7vmz0zey30.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704232042170.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 22:14:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg4va-00078U-NF
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 22:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbXDWUOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 16:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbXDWUOL
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 16:14:11 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42430 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbXDWUOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 16:14:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423201409.GCSU1271.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 16:14:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qkE71W00a1kojtg0000000; Mon, 23 Apr 2007 16:14:10 -0400
In-Reply-To: <Pine.LNX.4.64.0704232042170.8822@racer.site> (Johannes
	Schindelin's message of "Mon, 23 Apr 2007 20:46:21 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45358>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Ah!
>
> I see where this is coming from: c7263d4d "Display the subject of the 
> commit just made".
>
> Here's the fix:

thanks.
