From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Tue, 19 Apr 2005 14:25:18 +0200
Message-ID: <20050419122518.GD12757@pasky.ji.cz>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr> <20050418122011.GA13769@abridgegame.org> <7iy8bf7fh2.fsf@lanthane.pps.jussieu.fr> <20050419110407.GB28269@abridgegame.org> <7i4qe3x8ig.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 14:22:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNrjG-0005it-AF
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 14:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVDSMZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 08:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVDSMZY
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 08:25:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41661 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261476AbVDSMZU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 08:25:20 -0400
Received: (qmail 18580 invoked by uid 2001); 19 Apr 2005 12:25:18 -0000
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Content-Disposition: inline
In-Reply-To: <7i4qe3x8ig.fsf@lanthane.pps.jussieu.fr>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 02:20:55PM CEST, I got a letter
where Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr> told me that...
> > The problem is that there is no sequence of alien versions that one can
> > differentiate.  Git has a branched history, with each version that follows
> > a merge having multiple parents.
> 
> Yep.  I've just realised that this morning.  Is there some notion of
> ``primary parent'' as in Arch?  Can a changeset have 0 parents?

Yes, the root commit. Usually, there is only one, but there may be
multiple of them theoretically.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
