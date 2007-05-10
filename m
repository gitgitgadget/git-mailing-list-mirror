From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Git.pm: config_boolean() -> config_bool()
Date: Wed, 09 May 2007 19:12:58 -0700
Message-ID: <7vr6ppo28l.fsf@assigned-by-dhcp.cox.net>
References: <20070427020601.22991.13792.stgit@rover>
	<7v7irxko81.fsf@assigned-by-dhcp.cox.net>
	<20070509104941.GK4489@pasky.or.cz>
	<20070509151337.GX4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 10 04:13:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hly9m-0002rq-Mj
	for gcvg-git@gmane.org; Thu, 10 May 2007 04:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbXEJCND (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 22:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754519AbXEJCND
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 22:13:03 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:37009 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbXEJCNA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 22:13:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510021259.YOSU1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 22:12:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xECy1W00T1kojtg0000000; Wed, 09 May 2007 22:12:58 -0400
In-Reply-To: <20070509151337.GX4489@pasky.or.cz> (Petr Baudis's message of
	"Wed, 9 May 2007 17:13:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46825>

Petr Baudis <pasky@suse.cz> writes:

> Looks like I forgot to make install or something
> when "testing" the patch, also judging by the error messages repo.or.cz
> spewed furiously in the last update round.

Well, at least I can trust Git.pm and gitweb patches coming thru
you better than patches from elsewhere, as I would know if they
are broken too badly.  People would immediately notice the
breakage at repo.or.cz ;-).

Thanks.
