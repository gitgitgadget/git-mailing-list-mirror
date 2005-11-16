From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] git email submissions
Date: Wed, 16 Nov 2005 15:51:00 +0100
Message-ID: <20051116145100.GY30496@pasky.or.cz>
References: <437B4472.1080401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 16 15:54:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcOdV-00007z-HQ
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 15:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbVKPOvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 09:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVKPOvE
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 09:51:04 -0500
Received: from w241.dkm.cz ([62.24.88.241]:48101 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030356AbVKPOvC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 09:51:02 -0500
Received: (qmail 8239 invoked by uid 2001); 16 Nov 2005 15:51:00 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Content-Disposition: inline
In-Reply-To: <437B4472.1080401@pobox.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12027>

Dear diary, on Wed, Nov 16, 2005 at 03:38:42PM CET, I got a letter
where Jeff Garzik <jgarzik@pobox.com> said that...
> For people without _any_ hosting, it would be nice to give them a method 
> to submit some git changes via email.

What kind of people have no hosting whatsoever? There is plenty of free
web hosting sites, and that should be enough...?

> - is this all pointless, since the submittor could just email patches? 
> [IMO no, git trees are better merges than emailed patches]

Couldn't you just look at the applies-to string of the first patch in
the series, branch up from that commit, and at the end of the series do
the merge?

No special tool required, just a bit smarter applier.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
