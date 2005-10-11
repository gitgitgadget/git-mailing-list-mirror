From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix cg-admin-uncommit
Date: Wed, 12 Oct 2005 01:16:17 +0200
Message-ID: <20051011231617.GG30889@pasky.or.cz>
References: <20050930183545.15895.61691.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 01:17:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPTMC-0006qf-4f
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 01:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVJKXQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 19:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVJKXQZ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 19:16:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27025 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932080AbVJKXQY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 19:16:24 -0400
Received: (qmail 14500 invoked by uid 2001); 12 Oct 2005 01:16:17 +0200
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Content-Disposition: inline
In-Reply-To: <20050930183545.15895.61691.stgit@zion.home.lan>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9990>

Dear diary, on Fri, Sep 30, 2005 at 08:35:46PM CEST, I got a letter
where Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> told me that...
> Btw, why doesn't optparse consume all the cmd arguments via shift, making thus
> sure that $1 never works at all?

I did something hopefully equivalent, thanks for the idea (and for the
patch as well :-).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
