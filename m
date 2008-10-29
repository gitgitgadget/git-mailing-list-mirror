From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff
 --cached'.
Date: Wed, 29 Oct 2008 20:23:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810292022480.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081029003931.GA7291@sigill.intra.peff.net> <1225241048-99267-1-git-send-email-dsymonds@gmail.com> <C0BD1E4B-130F-4A16-8865-8EEABE1431FD@wincent.com> <alpine.DEB.1.00.0810291604200.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <08FC4756-8890-449D-BB55-90E4761C9B93@wincent.com> <alpine.DEB.1.00.0810291801580.22125@pacific.mpi-cbg.de.mpi-cbg.de> <E4E10B61-FA92-417C-9046-F9DE3B48C2A6@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1558255168-1225308230=:22125"
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:17:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvGY9-000484-Qi
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 20:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbYJ2TQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 15:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbYJ2TQg
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 15:16:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:45513 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753445AbYJ2TQf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 15:16:35 -0400
Received: (qmail invoked by alias); 29 Oct 2008 19:16:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 29 Oct 2008 20:16:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MEcBXZLgMVdy3V5Ul6/4BL6YxBbcLN9E59gcKXJ
	6S3MOAhAxH17jZ
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <E4E10B61-FA92-417C-9046-F9DE3B48C2A6@wincent.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99391>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1558255168-1225308230=:22125
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 29 Oct 2008, Wincent Colaiuta wrote:

> El 29/10/2008, a las 18:03, Johannes Schindelin escribió:
> 
> >On Wed, 29 Oct 2008, Wincent Colaiuta wrote:
> >
> > >Git already has too many commands. Adding more is not going to clear 
> > >up newbie confusion, and will only waste time because people will 
> > >complain about it and ask why there is this kind of duplication.
> >
> >I completely disagree.  If the existing set of commands causes 
> >confusion, we need to deprecate those parts and add new commands.  
> >Even if we have a ton of commands already.
> 
> The confusion isn't at the command level; it's at the switch/option 
> level. The solution isn't to add a new command.

Seems that at leat one guy who does Git training disagrees with you, _in 
addition_ to me.

Ciao,
Dscho
--8323328-1558255168-1225308230=:22125--
