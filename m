From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-pull fails on ssh repos
Date: Sat, 11 Jun 2005 00:38:00 +0200
Message-ID: <20050610223800.GD22111@pasky.ji.cz>
References: <E1Dgrmf-0003x5-Ik@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 00:34:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgs4f-0004vI-Ng
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 00:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVFJWiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 18:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVFJWiI
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 18:38:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:21406 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261327AbVFJWiB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 18:38:01 -0400
Received: (qmail 28528 invoked by uid 2001); 10 Jun 2005 22:38:00 -0000
To: Sebastian Kuzminsky <seb@highlab.com>
Content-Disposition: inline
In-Reply-To: <E1Dgrmf-0003x5-Ik@highlab.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jun 11, 2005 at 12:15:25AM CEST, I got a letter
where Sebastian Kuzminsky <seb@highlab.com> told me that...
> cg-pull's pull_ssh() calls git-rpull, should that be git-ssh-pull?

Oops, fixed. Thanks for the report.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
