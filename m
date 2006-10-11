From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Restore object-named links in item lists
Date: Wed, 11 Oct 2006 14:48:10 -0700
Message-ID: <7viriqsew5.fsf@assigned-by-dhcp.cox.net>
References: <20061011201812.26857.58295.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 23:49:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXlw4-0000c9-0m
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 23:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWJKVsP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 17:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbWJKVsO
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 17:48:14 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:36039 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1422664AbWJKVsL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 17:48:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011214811.CLBV12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Oct 2006 17:48:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Z9oD1V00V1kojtg0000000
	Wed, 11 Oct 2006 17:48:14 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28753>

I would love to take this but please defer it for now; the patch
does not apply to any of my topic branches (nor "next").

I'd like to stabilize "master" for v1.4.3 this week, and would
like to merge bunch of stuff that are already in "next" to
"master" after that.  I'd prefer to come back to gitweb when the
dust settles.
