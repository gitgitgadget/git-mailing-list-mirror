From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-pack-ls-objects tool
Date: Sat, 21 Jan 2006 18:46:58 -0800
Message-ID: <7vzmlphtct.fsf@assigned-by-dhcp.cox.net>
References: <20060122022711.16333.93404.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 22 03:47:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0VG1-0003XP-6I
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 03:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWAVCrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 21:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWAVCrF
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 21:47:05 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:49845 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751256AbWAVCrC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 21:47:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122024604.OEWO3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 21:46:04 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060122022711.16333.93404.stgit@machine.or.cz> (Petr Baudis's
	message of "Sun, 22 Jan 2006 03:27:11 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15036>

Petr Baudis <pasky@suse.cz> writes:

> This tool takes pack index on stdin and produces the list of indexed
> objects on stdout.

Isn't this essentially what git-show-index does?
