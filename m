From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Git Wiki Move
Date: Fri, 22 Jan 2010 01:31:16 +0100
Message-ID: <20100122003116.GX25382@machine.or.cz>
References: <4B4F68E8.5050809@eaglescrag.net>
 <4B50F7DB.7020204@eaglescrag.net>
 <vpqwrzhszye.fsf@bauges.imag.fr>
 <alpine.DEB.1.00.1001172357420.4985@pacific.mpi-cbg.de>
 <4B53AEAC.6060100@eaglescrag.net>
 <alpine.DEB.1.00.1001181044410.4985@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.1001181258540.3044@intel-tinevez-2-302>
 <4B54ACBD.6000000@eaglescrag.net>
 <20100121213514.GD3299@machine.or.cz>
 <m3vdevat3m.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J.H." <warthog19@eaglescrag.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 01:31:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY7Qu-0005xe-UL
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 01:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919Ab0AVAbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 19:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889Ab0AVAbU
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 19:31:20 -0500
Received: from w241.dkm.cz ([62.24.88.241]:37225 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556Ab0AVAbT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 19:31:19 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 488EA86201E; Fri, 22 Jan 2010 01:31:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3vdevat3m.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137704>

On Thu, Jan 21, 2010 at 04:21:22PM -0800, Jakub Narebski wrote:
> Petr Baudis <pasky@suse.cz> writes:
> > On Mon, Jan 18, 2010 at 10:47:25AM -0800, J.H. wrote:
> > > On 01/18/2010 04:03 AM, Johannes Schindelin wrote:
> 
> > > > - add a link from the old Wiki (with rewrite rules)
> > > 
> > > I think the rewrites should be simple enough (the pages seem to line up
> > > 1:1 easily enough) so all I would need to do is discuss this with Petr.
> > 
> > repo.or.cz migration to new server is now finished and on the new
> > system, I chose to not even install moinwiki at all. Instead, I've
> > installed a rewrite rule so all http://git.or.cz/gitwiki/ accesses are
> > sent to the appropriate place of http://git.wiki.kernel.org/ - thus,
> > that's the master copy of git wiki now. :-) 
> 
> Are all formatting bugs from MoinMoin + media4moin -> MediaWiki fixed?
> If not, then it would be good to have reference read-only copy of old
> MoinMoin-based wiki to compare against.

I'm not sure about the current state, I didn't really have time to look
carefully, so if people will say they have concrete need for the
reference read-only copy, I will set it up. But with the local hacks and
completely new system, it won't be trivial, so I'd prefer not to do it
just proactively.

				Petr "Pasky" Baudis
