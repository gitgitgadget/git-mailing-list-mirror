From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Git Wiki Move
Date: Thu, 21 Jan 2010 22:35:14 +0100
Message-ID: <20100121213514.GD3299@machine.or.cz>
References: <4B4EF1E0.3040808@eaglescrag.net>
 <vpqbpgxrn32.fsf@bauges.imag.fr>
 <4B4F68E8.5050809@eaglescrag.net>
 <4B50F7DB.7020204@eaglescrag.net>
 <vpqwrzhszye.fsf@bauges.imag.fr>
 <alpine.DEB.1.00.1001172357420.4985@pacific.mpi-cbg.de>
 <4B53AEAC.6060100@eaglescrag.net>
 <alpine.DEB.1.00.1001181044410.4985@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.1001181258540.3044@intel-tinevez-2-302>
 <4B54ACBD.6000000@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 22:35:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY4gW-00025p-Ui
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 22:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab0AUVfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 16:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754984Ab0AUVfU
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 16:35:20 -0500
Received: from w241.dkm.cz ([62.24.88.241]:58487 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754891Ab0AUVfT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 16:35:19 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 08C8986201E; Thu, 21 Jan 2010 22:35:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B54ACBD.6000000@eaglescrag.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137693>

On Mon, Jan 18, 2010 at 10:47:25AM -0800, J.H. wrote:
> On 01/18/2010 04:03 AM, Johannes Schindelin wrote:
> > - add a link from the old Wiki (with rewrite rules)
> 
> I think the rewrites should be simple enough (the pages seem to line up
> 1:1 easily enough) so all I would need to do is discuss this with Petr.

repo.or.cz migration to new server is now finished and on the new
system, I chose to not even install moinwiki at all. Instead, I've
installed a rewrite rule so all http://git.or.cz/gitwiki/ accesses are
sent to the appropriate place of http://git.wiki.kernel.org/ - thus,
that's the master copy of git wiki now. :-) Thanks a lot for stepping up
to do this, J.H.!

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
