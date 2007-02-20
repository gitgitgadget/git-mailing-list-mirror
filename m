From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add a compat/strtoumax.c for Solaris 8.
Date: Mon, 19 Feb 2007 16:53:13 -0800
Message-ID: <7virdx4pl2.fsf@assigned-by-dhcp.cox.net>
References: <17777.1171930976@lotus.CS.Berkeley.EDU>
	<20070220003533.GB28314@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:53:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJG1-0001OY-Ey
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965793AbXBTAxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965832AbXBTAxQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:53:16 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52008 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965793AbXBTAxP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:53:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220005314.RCHD21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 19:53:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RctD1W00D1kojtg0000000; Mon, 19 Feb 2007 19:53:13 -0500
In-Reply-To: <20070220003533.GB28314@spearce.org> (Shawn O. Pearce's message
	of "Mon, 19 Feb 2007 19:35:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40188>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> This is a better version than the patch I sent out last night,
> so Junio please drop my patch in favor of Jason's.

Agh.  Too late...

I need some rewinding and reshuffling.
