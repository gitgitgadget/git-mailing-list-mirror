From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] [TopGit] Pretty print the help creation commands in
	Makefile.
Date: Sat, 9 Aug 2008 02:28:55 +0200
Message-ID: <20080809002855.GP10151@machine.or.cz>
References: <1218177797-21589-1-git-send-email-bert.wesarg@googlemail.com> <1218127155-32192-1-git-send-email-bert.wesarg@googlemail.com> <1218009771-30358-1-git-send-email-bert.wesarg@googlemail.com> <1218008964-27286-1-git-send-email-bert.wesarg@googlemail.com> <20080806024348.GF11179@maggie.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Russell Steicke <russellsteicke@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 02:30:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRcLV-0005Fh-1f
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 02:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750695AbYHIA27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 20:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbYHIA26
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 20:28:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58005 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbYHIA26 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 20:28:58 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 621C72C4C02B; Sat,  9 Aug 2008 02:28:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218177797-21589-1-git-send-email-bert.wesarg@googlemail.com> <1218127155-32192-1-git-send-email-bert.wesarg@googlemail.com> <1218009771-30358-1-git-send-email-bert.wesarg@googlemail.com> <1218008964-27286-1-git-send-email-bert.wesarg@googlemail.com> <20080806024348.GF11179@maggie.localnet>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91731>

  Hi,

  thanks, patches applied (after heavy dose of swearing in the general
direction of git-am and git-apply at #git - now I'm really ashamed
I've ever put "git is well-suited for patch-oriented workflows" on
any of my slides).

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
