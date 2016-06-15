From: Junio C Hamano <junkio@cox.net>
Subject: Re: git + ssh + key authentication feature-request
Date: Wed, 08 Feb 2006 13:58:26 -0800
Message-ID: <7vhd79o6m5.fsf@assigned-by-dhcp.cox.net>
References: <43EA73C3.2040309@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 22:58:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6xKo-0000R0-B3
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 22:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWBHV63 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 16:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWBHV63
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 16:58:29 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:2202 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750975AbWBHV63 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 16:58:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060208215724.QPVH3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 16:57:24 -0500
To: Nicolas Vilz 'niv' <niv@iaglans.de>
In-Reply-To: <43EA73C3.2040309@iaglans.de> (Nicolas Vilz's message of "Wed, 08
	Feb 2006 23:42:11 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15755>

Nicolas Vilz 'niv' <niv@iaglans.de> writes:

> I would like to ask if it is possible to use ssh keys to authenticate
> via ssh on a git repository via git-pull/git-push. Since ssh supports
> them, wouldn't it be nice to use them in git, too?

Please read what has been discussed within the last couple of
weeks at least.  I could say the last couple of months but I
know that is asking too much ;-).

http://thread.gmane.org/gmane.comp.version-control.git/15462
