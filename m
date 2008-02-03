From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere
 (unify examples)
Date: Sun, 3 Feb 2008 02:07:04 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802030204400.7372@racer.site>
References: <3asc6spe.fsf@blue.sea.net> <7v7iho6p2m.fsf@gitster.siamese.dyndns.org> <20080202084406.GA15305@glandium.org> <8x235xa8.fsf@blue.sea.net> <m3d4rf7a4r.fsf@localhost.localdomain> <abmj3ysj.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Feb 03 03:08:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLUHH-0002FO-Dm
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 03:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935926AbYBCCHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 21:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935840AbYBCCHl
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 21:07:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:59314 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935387AbYBCCHk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 21:07:40 -0500
Received: (qmail invoked by alias); 03 Feb 2008 02:07:38 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp057) with SMTP; 03 Feb 2008 03:07:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uRgxqUfruIgddqI3U3pkwCNy2YxXw3rfX7ZuBLH
	V5a0OAxQMkdDOB
X-X-Sender: gene099@racer.site
In-Reply-To: <abmj3ysj.fsf@blue.sea.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72315>

Hi,

[don't cut the Cc' list.  It is rude.  _Especially_ if you cull the one 
you are responding to.  Or do you like people looking the other way when 
they talk to you?]

On Sat, 2 Feb 2008, Jari Aalto wrote:

> * Sat 2008-02-02 Jakub Narebski <jnareb@gmail.com>
> * Message-Id: m3d4rf7a4r.fsf@localhost.localdomain
> > Jari Aalto <jari.aalto@cante.net> writes:
> >> I use HEAD~1 always, because I think the consistency in learning the
> >> most important factor.
> >
> > "HEAD~1" and "HEAD~2" are not shorter than original notation.
> 
> I'm afreaid that "optiomization" is seen a virtua in the manual pages. I 
> certainly do not wish to use "shorter", if it would mean "less readable"

IMO this is not just a matter of "shorter" or "longer".  People familiar 
with Git use both forms.  So if you want to be able to receive help from 
Git experts, you better understand both forms.

That's why Git newbies have to learn about _both_ syntaxes right away.  
Keeping them dumb serves _noone_.

Ciao,
Dscho
