From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git Wiki Move
Date: Fri, 22 Jan 2010 01:39:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001220136370.4985@pacific.mpi-cbg.de>
References: <4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr> <4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net> <vpqwrzhszye.fsf@bauges.imag.fr> <alpine.DEB.1.00.1001172357420.4985@pacific.mpi-cbg.de> <4B53AEAC.6060100@eaglescrag.net>
 <alpine.DEB.1.00.1001181044410.4985@pacific.mpi-cbg.de> <alpine.DEB.1.00.1001181258540.3044@intel-tinevez-2-302> <4B54ACBD.6000000@eaglescrag.net> <20100121213514.GD3299@machine.or.cz> <m3vdevat3m.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, "J.H." <warthog19@eaglescrag.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 01:33:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY7T9-0006bE-Fh
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 01:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab0AVAdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 19:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877Ab0AVAdm
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 19:33:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:38566 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752952Ab0AVAdk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 19:33:40 -0500
Received: (qmail invoked by alias); 22 Jan 2010 00:33:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp036) with SMTP; 22 Jan 2010 01:33:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BqFwIKX/BmD1ioPsxynpFVajaZrmvyezeQI1SYX
	XJ1eY6TGwrnEFL
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <m3vdevat3m.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137705>

Hi,

On Thu, 21 Jan 2010, Jakub Narebski wrote:

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

No.  The big ones are GitSurvey pages (except for 2007) and the SoC pages.  
I went through all others, which means that maybe the occasional bug 
slipped through, but basically the pages are sound.

Which makes me think that I finally deserve to see Henrik Nyh's logo on 
the Wiki.

> If not, then it would be good to have reference read-only copy of old
> MoinMoin-based wiki to compare against.

If it would not involve more work for Pasky, I would agree.  But mainly 
the work was done.

Ciao,
Dscho
