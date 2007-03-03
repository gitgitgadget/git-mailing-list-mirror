From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add core.symlinks to mark filesystems that do not support symbolic links.
Date: Sat, 03 Mar 2007 04:44:07 -0800
Message-ID: <7v1wk6cx9k.fsf@assigned-by-dhcp.cox.net>
References: <200703022211.30322.johannes.sixt@telecom.at>
	<7vvehjchsp.fsf@assigned-by-dhcp.cox.net>
	<7vr6s7chim.fsf@assigned-by-dhcp.cox.net>
	<200703031320.13535.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Mar 03 13:44:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNTb5-0003ru-Nb
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 13:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbXCCMoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 07:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbXCCMoK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 07:44:10 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39463 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030193AbXCCMoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 07:44:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303124407.FSRR24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 07:44:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WCk81W0041kojtg0000000; Sat, 03 Mar 2007 07:44:08 -0500
In-Reply-To: <200703031320.13535.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sat, 3 Mar 2007 13:20:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41292>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> I think that's still not correct.

Of course you are right.  Thanks.
