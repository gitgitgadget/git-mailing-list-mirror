From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Create a new manpage for the gitignore format, and reference it elsewhere
Date: Fri, 01 Jun 2007 14:46:44 -0700
Message-ID: <7vtztrxs8r.fsf@assigned-by-dhcp.cox.net>
References: <4660866B.7000304@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 427078@bugs.debian.org,
	427078-forwarded@bugs.debian.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 23:46:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuExR-0000ul-Jv
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 23:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761184AbXFAVqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 17:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760996AbXFAVqq
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 17:46:46 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:47963 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760836AbXFAVqq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 17:46:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070601214646.KPX7952.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 1 Jun 2007 17:46:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6Mmk1X00N1kojtg0000000; Fri, 01 Jun 2007 17:46:45 -0400
In-Reply-To: <4660866B.7000304@freedesktop.org> (Josh Triplett's message of
	"Fri, 01 Jun 2007 13:49:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48889>

Josh Triplett <josh@freedesktop.org> writes:

Thanks, but shouldn't all the in-text mention of "gitignore(5)"
and friends, not just in "See Also" section, use
"gitlink:gitignore[5]" instead?
