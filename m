From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 'mail' link on http://repo.or.cz/w/git.git no workee?
Date: Fri, 16 Jan 2009 12:27:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901161224360.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901151651460.3586@pacific.mpi-cbg.de> <20090116015439.GF12275@machine.or.cz> <7vmydsovs5.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901160315170.3586@pacific.mpi-cbg.de> <20090116022408.GG12275@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jan 16 12:28:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNms6-00064Q-5w
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 12:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbZAPL0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 06:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbZAPL0y
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 06:26:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:52826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751549AbZAPL0x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 06:26:53 -0500
Received: (qmail invoked by alias); 16 Jan 2009 11:26:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 16 Jan 2009 12:26:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RSRp9VvOR1WxKTbYVzIfRmP/H5Z31xWQ1bGu1rF
	Vg2mlsOJqn6D9z
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090116022408.GG12275@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105939>

Hi,

On Fri, 16 Jan 2009, Petr Baudis wrote:

> On Fri, Jan 16, 2009 at 03:17:14AM +0100, Johannes Schindelin wrote:
> 
> > I wondered what the point was, and I would _welcome_ links that 
> > pointed to the mails containing the patches (identified either by 
> > patch ids or by manual editing; best would be to have both methods at 
> > the same time).
> 
> Well, but you already have that, or at least an approximation.

Oh, I see!  Somehow I missed that this link exists for all non-merge 
commits...

> I was not actually planning to carry the patch over the next gitweb 
> update since I got no feedback on it (IIRC) since I implemented it.

Well, now you got one: I find it nice.  And I agree with you on the false 
positive thing: it is better to have that link also for commits for which 
no mails can be found.

I just had to scratch my head about what "mail" is about...

Ciao,
Dscho
