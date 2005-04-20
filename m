From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git-viz tool for visualising commit trees
Date: Wed, 20 Apr 2005 21:45:17 +0200
Message-ID: <20050420194517.GA19112@pasky.ji.cz>
References: <20050417194818.GG1461@pasky.ji.cz> <20050420100824.GB25477@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, oliv__a@users.sourceforge.net
X-From: git-owner@vger.kernel.org Wed Apr 20 21:42:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOL4p-0000Fd-0v
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 21:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVDTTpi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 15:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVDTTph
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 15:45:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:8412 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261753AbVDTTpV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 15:45:21 -0400
Received: (qmail 9436 invoked by uid 2001); 20 Apr 2005 19:45:17 -0000
To: Ingo Molnar <mingo@elte.hu>
Content-Disposition: inline
In-Reply-To: <20050420100824.GB25477@elte.hu>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 20, 2005 at 12:08:24PM CEST, I got a letter
where Ingo Molnar <mingo@elte.hu> told me that...
> * Petr Baudis <pasky@ucw.cz> wrote:
> >   just FYI, Olivier Andrieu was kind enough to port his monotone-viz 
> > tool to git (http://oandrieu.nerim.net/monotone-viz/ - use the one 
> > from the monotone repository). The tool visualizes the history flow 
> > nicely; see
> > for some screenshots.
> 
> really nice stuff! Any plans to include it in git-pasky, via 'git gui' 
> option or so? Also, which particular version has this included - the 
> freshest tarball on the monotone-viz download site doesnt seem to 
> include it.

AFAIK you need Monotone and grab it from the monotone repository.

git gui sounds interesting, but perhaps in longer horizon, and perhaps
not as an integral part of git-pasky. I don't know ocaml and it's rather
large thing.

Point'n'drag merges, anyone? ;-))

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
