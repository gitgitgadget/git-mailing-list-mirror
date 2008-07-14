From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Closing the merge window for 1.6.0
Date: Mon, 14 Jul 2008 12:57:56 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807141256310.8950@racer>
References: <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <7vprpwhp7t.fsf@gitster.siamese.dyndns.org> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 14 13:59:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIMhl-0003S1-BB
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 13:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbYGNL56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 07:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbYGNL55
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 07:57:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:52194 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753111AbYGNL55 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 07:57:57 -0400
Received: (qmail invoked by alias); 14 Jul 2008 11:57:55 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp053) with SMTP; 14 Jul 2008 13:57:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UdCMpPhZUzM5aSMG2u7UTdYHeqXGGFMHqhgnfAx
	sOwZ627m4WVVhr
X-X-Sender: gene099@racer
In-Reply-To: <20080714085555.GJ32184@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88415>

Hi,

On Mon, 14 Jul 2008, Petr Baudis wrote:

> I'm saying this because I believe the best conservative upper bound for 
> backwards compatibility is Git version in Debian stable. It gets 
> probably the most stale from all the widely used software distributions 
> using Git, and it *is* quite widely used. Etch carries v1.4.4.4, which 
> fails miserably on the new packs.

Can't we just hit Debian's Git maintainer with a clue bat or a bus, 
whichever is easier, and force them to upgrade _in_ Etch?  It's not like 
we haven't had _several_ stable releases in-between.

Ciao,
Dscho
