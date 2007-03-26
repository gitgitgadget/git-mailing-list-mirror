From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] Consistently use user-defined UI font everywhere in GUI tools.
Date: Mon, 26 Mar 2007 01:31:54 -0700
Message-ID: <7vr6rcxv5x.fsf@assigned-by-dhcp.cox.net>
References: <20070326073715.GE44578@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Mon Mar 26 10:32:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVkcR-0006Fy-6R
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 10:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbXCZIb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 04:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbXCZIb4
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 04:31:56 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:33685 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbXCZIb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 04:31:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326083155.DENJ18070.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 04:31:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fLXu1W0021kojtg0000000; Mon, 26 Mar 2007 04:31:55 -0400
In-Reply-To: <20070326073715.GE44578@codelabs.ru> (Eygene Ryabinkin's message
	of "Mon, 26 Mar 2007 11:37:15 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43131>

I think this is sane in general, but please

 (1) do not make a combined patch that covers gitk and git-gui
     at the same time;

 (2) address gitk patches to Paul Mackerras <paulus@samba.org>,
     with cc: the list;

 (3) address git-gui patches to Shawn Pearce <spearce@spearce.org>
     with cc: the list.

Thanks.
