From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH and RFC] gitweb: Remove --full-history from git_history
Date: Wed, 09 Aug 2006 04:09:40 -0700
Message-ID: <7vu04m413f.fsf@assigned-by-dhcp.cox.net>
References: <200608091257.19461.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 13:09:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAlwX-0007Wd-Bs
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 13:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030616AbWHILJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 07:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030681AbWHILJm
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 07:09:42 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:6371 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030616AbWHILJl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 07:09:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809110941.DSAS6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 07:09:41 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608091257.19461.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 9 Aug 2006 12:57:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25113>

Jakub Narebski <jnareb@gmail.com> writes:

> Stop pretending that gitweb is rename-aware, and remove --full-history
> option to git-rev-list in git_history (for "history" action):

Where did you get the idea that --full-history has anything to
do with renames?

Message-ID: <20060701005924.7726.qmail@web31812.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.64.0606301818480.12404@g5.osdl.org>
