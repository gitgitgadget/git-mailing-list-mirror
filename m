From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: script to add another remote
Date: Thu, 22 Feb 2007 14:24:27 -0800
Message-ID: <7v8xepde5g.fsf@assigned-by-dhcp.cox.net>
References: <1172182595.20817.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 22 23:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKMMa-0008D0-Ic
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 23:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbXBVWY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 17:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbXBVWY2
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 17:24:28 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:45850 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbXBVWY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 17:24:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222222428.KJWA2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 17:24:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SmQT1W0031kojtg0000000; Thu, 22 Feb 2007 17:24:27 -0500
In-Reply-To: <1172182595.20817.26.camel@dv> (Pavel Roskin's message of "Thu,
	22 Feb 2007 17:16:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40399>

Pavel Roskin <proski@gnu.org> writes:

> It's interesting that git-clone-more can be used instead of git-clone.
> I can use it e.g. to check out git in an empty directory:
>
> git-init
> git-clone-more git://www.kernel.org/pub/scm/git/git.git git

Isn't that what "git remote" is about?
