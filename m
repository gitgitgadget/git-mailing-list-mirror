From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 01/12] Introduce Git.pm (v4)
Date: Sat, 24 Jun 2006 05:14:36 +0200
Message-ID: <20060624031436.GQ21864@pasky.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz> <7vr71f5kzs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 05:14:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftybc-0002dP-3f
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 05:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWFXDOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 23:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWFXDOj
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 23:14:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:206 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750881AbWFXDOi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 23:14:38 -0400
Received: (qmail 2553 invoked by uid 2001); 24 Jun 2006 05:14:36 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr71f5kzs.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22482>

Dear diary, on Sat, Jun 24, 2006 at 04:46:15AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Just to let you know, I already have v3 in my tree which is
> merged in "pu".  With the two fixes I sent you earlier I think
> it is in a good shape to be cooked in "next".

Ah, yes, could you please apply your fixes as well? :-)

> I do not think I'd have trouble applying this new series (I
> would probably start from "master" to apply it and perhaps merge
> or --squash merge it onto pb/gitpm topic branch that has v3 with
> the two fixes I sent you separately) but we will see soon
> enough.

I noticed v3 in pu but thought that it should be trivial to just throw
that away from pu and take v4 instead - I'm sorry if that turns out to
be an issue.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
