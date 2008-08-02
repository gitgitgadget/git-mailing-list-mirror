From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: email address handling
Date: Sat, 2 Aug 2008 18:59:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808021857350.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801131127.20b3acfd.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org> <20080801135421.5ca0f6af.akpm@linux-foundation.org> <7vvdykqub6.fsf@gitster.siamese.dyndns.org> <20080801145804.85041bbd.akpm@linux-foundation.org> <20080801221539.GA8617@mit.edu>
 <20080801152720.56dbff09.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011534260.6819@nehalem.linux-foundation.org> <20080801154902.c60717e5.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011554350.6819@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808011608150.6819@nehalem.linux-foundation.org> <alpine.DEB.1.00.0808021321500.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.1.10.0808020916370.3318@nehalem.linux-foundation.org> <7vej57pe5q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 18:56:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPKP8-0000HG-RL
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 18:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817AbYHBQz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 12:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755896AbYHBQz2
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 12:55:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:36344 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755680AbYHBQz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 12:55:28 -0400
Received: (qmail invoked by alias); 02 Aug 2008 16:55:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 02 Aug 2008 18:55:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tNagQ9Y1tHZDmCOVXx9qBLFWVRt/K08qI5RK485
	dAlYb2Nw+oJrz8
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vej57pe5q.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91155>

Hi,

On Sat, 2 Aug 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > I wonder where that is_rfc2047_special() function came from.

It comes straight from cdd406e(CMIT_FMT_EMAIL: Q-encode Subject: and 
display-name part of From: fields.).

Ciao,
Dscho
