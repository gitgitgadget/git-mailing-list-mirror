From: Junio C Hamano <junkio@cox.net>
Subject: (Not) What's in git.git
Date: Mon, 15 May 2006 01:46:23 -0700
Message-ID: <7vves7u140.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 15 10:46:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfYii-0007qv-46
	for gcvg-git@gmane.org; Mon, 15 May 2006 10:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWEOIqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 04:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWEOIqZ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 04:46:25 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7354 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964821AbWEOIqY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 04:46:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515084623.JUOI9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 04:46:23 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20034>

Over the weekend everybody was busy feeding me patches, so I've
added much stuff in the "next", but without really looking deep
into each of them.  It still passes the testsuite, but that
tells us more about the sparseness of the tests not the quality
of what are in the branch.

I'll review them in the coming week and have them graduate to
"master", perhaps slowly.  Also what's currently in "maint" will
be tagged as 1.3.3.

I expect myself to be a bit slower for a couple of days at
least; I am still adjusting to the new development environment.
I haven't fully installed what I need nor configuired it
properly yet.
