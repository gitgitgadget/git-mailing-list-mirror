From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git checkout: add -t alias for --track
Date: Sun, 27 Apr 2008 12:48:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804271247030.16320@eeepc-johanness>
References: <20080423230448.GL4012@genesis.frugalware.org> <7vmynfj0a4.fsf@gitster.siamese.dyndns.org> <7v1w4rizlm.fsf@gitster.siamese.dyndns.org> <20080427114152.GS4012@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 13:49:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq5NX-0002ZW-Fq
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 13:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbYD0LsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 07:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754926AbYD0LsZ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 07:48:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:56845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754383AbYD0LsY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 07:48:24 -0400
Received: (qmail invoked by alias); 27 Apr 2008 11:48:22 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp036) with SMTP; 27 Apr 2008 13:48:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EaGowHRzEZA7xO/Dfft9tEy/52OYbClNpMRywZt
	4SEr5WUD1urqKj
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080427114152.GS4012@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80443>

Hi,

On Sun, 27 Apr 2008, Miklos Vajna wrote:

> On Sat, Apr 26, 2008 at 11:25:09PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > What I meant to say was that this may be useful to _some_ degree but 
> > probably _not very much_.
> 
> Yes, it's just about my "having short option aliases are good" idea. 
> Should I improve the commit message by mentioning that this is useful 
> "in case you don't want to have branch.autosetupmerge set to true for 
> some reason"?

AFAIR you still need to specify --track if you want to setup tracking 
information for local branches, and have branch.autosetupmerge different 
than "always", but as always, I might be mistaken.

Ciao,
Dscho
