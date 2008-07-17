From: Petr Baudis <pasky@suse.cz>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 16:51:20 +0200
Message-ID: <20080717145120.GW32184@machine.or.cz>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <7v7iblsnfh.fsf@gitster.siamese.dyndns.org> <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com> <7vmykhr6h1.fsf@gitster.siamese.dyndns.org> <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com> <alpine.DEB.1.00.0807170024310.4318@eeepc-johanness> <63BEA5E623E09F4D92233FB12A9F79430238A144@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Craig L. Ching" <cching@mqsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 16:52:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJUqE-0001tt-1d
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 16:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691AbYGQOvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 10:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbYGQOvX
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 10:51:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51430 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052AbYGQOvX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 10:51:23 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id F3D872C4C025; Thu, 17 Jul 2008 16:51:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F79430238A144@emailmn.mqsoftware.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88861>

On Thu, Jul 17, 2008 at 09:21:58AM -0500, Craig L. Ching wrote:
> Maybe if Git had a few different workflows
> documented that might help.  I know we have a "Git for SVN Users"
> workflow, but if you want to move beyond that, it might be good to have
> some of the more complex workflows documented.  I think some people have
> hinted at that suggestion but that maybe it just hasn't been explicitly
> said.

Yes, very recently, someone on #git asked about existing documented
workflows, and there is very little. It would be interesting project for
someone to build a 'Garden of Git Workflows' (or a Labyrinth) - for each
workflow, detailed self-contained documentation ranging from lone developer
with topic branches over repo.or.cz/github forks workflow, the workflows
of "leaf contributors", lieutenants and main integrators of the mail-oriented
kernel/git workflow, up to the single-central-repository workflows.

There are bits here and there, but the main problem is that they are not
self-contained. It might be nice to have something like a set of military
manuals, appropriate for the roles of the particular developers.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
