From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb not friendly to firefox?
Date: Thu, 01 Mar 2007 20:40:51 -0800
Message-ID: <7v4pp4ntpo.fsf@assigned-by-dhcp.cox.net>
References: <20070301140046.GM57456@codelabs.ru>
	<989B956029373F45A0B8AF02970818902DA75D@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <rea-git@codelabs.ru>,
	"Raimund Bauer" <ray@softwarelandschaft.com>, <git@vger.kernel.org>
To: "Li Yang-r58472" <LeoLi@freescale.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 05:40:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMzZg-0001Xq-Bt
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 05:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422876AbXCBEky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 23:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422877AbXCBEkx
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 23:40:53 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52515 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422876AbXCBEkx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 23:40:53 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302044053.WSPV1226.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 1 Mar 2007 23:40:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vggr1W00C1kojtg0000000; Thu, 01 Mar 2007 23:40:52 -0500
In-Reply-To: <989B956029373F45A0B8AF02970818902DA75D@zch01exm26.fsl.freescale.net>
	(Li Yang-r's message of "Fri, 2 Mar 2007 10:28:55 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41157>

"Li Yang-r58472" <LeoLi@freescale.com> writes:

>> The proper thing is to replace "<" with "&lt;" and ">" with "&gt;".
>
> Yes, you are right.  But why gitweb didn't do that for me?  I observed
> that some early version of gitweb doesn't have this problem.  Is it
> possible that some new change caused this?

It's very possible.
