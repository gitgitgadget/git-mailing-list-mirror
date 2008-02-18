From: Jeff King <peff@peff.net>
Subject: Re: What's in git.git (stable)
Date: Mon, 18 Feb 2008 06:15:04 -0500
Message-ID: <20080218111504.GA7672@sigill.intra.peff.net>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org> <7vd4r24ox6.fsf@gitster.siamese.dyndns.org> <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org> <m3d4qvbt40.fsf@localhost.localdomain> <7vtzk7xqg3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802172050090.30505@racer.site> <7v3arrxd7q.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802180133150.30505@racer.site> <20080218014301.GA6642@sigill.intra.peff.net> <7v3arrvtxm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 12:15:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR3yL-0004SL-Bw
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 12:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756918AbYBRLPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 06:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756151AbYBRLPJ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 06:15:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1311 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756040AbYBRLPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 06:15:07 -0500
Received: (qmail 12070 invoked by uid 111); 18 Feb 2008 11:15:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 18 Feb 2008 06:15:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2008 06:15:04 -0500
Content-Disposition: inline
In-Reply-To: <7v3arrvtxm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74263>

On Sun, Feb 17, 2008 at 07:12:53PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > .... This is in contrast to the
> > current 'master' and v1.5.4, which discard the cache _three_ times
> > during the status process.
> 
> The current 'master' meaning before 959ba67 (commit: discard
> index after setting up partial commit), right?

Heh. Yes. The current 'master' meaning 'the current master when I wrote
that patch.' :)

-Peff
