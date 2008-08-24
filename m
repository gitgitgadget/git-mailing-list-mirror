From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] mtn to git conversion script
Date: Sun, 24 Aug 2008 20:19:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808242017520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com> <20080824131405.GJ23800@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	monotone-devel@nongnu.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 20:15:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXK7b-0008Aq-9E
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 20:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbYHXSOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 14:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbYHXSOX
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 14:14:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:56954 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752013AbYHXSOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 14:14:23 -0400
Received: (qmail invoked by alias); 24 Aug 2008 18:14:21 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 24 Aug 2008 20:14:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QSWBJwJpQkRVuwKf2G88wazuifhpcO5WEPXl/if
	xv/mAsQOsRLQMX
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080824131405.GJ23800@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93543>

Hi,

On Sun, 24 Aug 2008, Miklos Vajna wrote:

> On Sun, Aug 24, 2008 at 12:18:50PM +0300, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > What do you think? Does it makes sense to have a 'write-raw' command? 
> > Or should I somehow use 'fast-import'?
> 
> Yes, you should. ;-)
> 
> The syntax of it is not so hard, see for example 'git fast-export
> HEAD~2..' on a git repo and you'll see.
> 
> This should help a lot if you are like me, who likes to learn from
> examples.

Heh.  I am glad you like fast-export.  To be honest, I never intended to 
use fast-export for anything else than as an example how to drive 
fast-import... :-)

Ciao,
Dscho
