From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-pull documentation: fix linkgit in the --rebase
 option description.
Date: Mon, 11 Feb 2008 21:13:49 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802112112560.3870@racer.site>
References: <20080211132800.GV25954@genesis.frugalware.org> <alpine.LSU.1.00.0802111514400.3870@racer.site> <20080211182907.GB25954@genesis.frugalware.org> <7vve4v8g2e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:14:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOfyh-0007pI-0L
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 22:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758798AbYBKVNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 16:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757629AbYBKVNn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 16:13:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:50620 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756218AbYBKVNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 16:13:42 -0500
Received: (qmail invoked by alias); 11 Feb 2008 21:13:40 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp041) with SMTP; 11 Feb 2008 22:13:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kTrxSM/dkMg8zcaG5MNC7TrGq4UzQZ7sX/fV35N
	ouQq3hUNSfRvif
X-X-Sender: gene099@racer.site
In-Reply-To: <7vve4v8g2e.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73584>

Hi,

On Mon, 11 Feb 2008, Junio C Hamano wrote:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > I see your point and i played with it a bit, no success so far. If it
> > becomes a new paragraph, the linkgit: is not processed. maybe it's an
> > asciidoc bug?
> 
> You probably meant to do this, then.

Thanks.  At some point, it feels (at least to me) that the ease of 
use of asciidoc just vanishes...

Ciao,
Dscho
