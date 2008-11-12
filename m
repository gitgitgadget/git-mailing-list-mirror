From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] t7700: demonstrate mishandling of objects in
	packs with a .keep file
Date: Wed, 12 Nov 2008 14:17:57 -0500
Message-ID: <20081112191757.GB21401@coredump.intra.peff.net>
References: <20081103161202.GJ15463@spearce.org> <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil> <20081112080909.GA29176@coredump.intra.peff.net> <7vzlk4q38q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 20:19:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0LFX-0001W0-KR
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 20:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYKLTSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 14:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbYKLTSA
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 14:18:00 -0500
Received: from peff.net ([208.65.91.99]:1414 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbYKLTR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 14:17:59 -0500
Received: (qmail 21563 invoked by uid 111); 12 Nov 2008 19:17:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 14:17:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 14:17:57 -0500
Content-Disposition: inline
In-Reply-To: <7vzlk4q38q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100805>

On Wed, Nov 12, 2008 at 09:10:45AM -0800, Junio C Hamano wrote:

> > Hmm. I'm not sure what happened, but the version in 'next' has "head -n
> > -1" in it.
> 
> You mean this one?
> 
> commit 31d92611e45d1286b805e362dbc451936af24121

Yes, exactly.

-Peff
