From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Portability: returning void
Date: Wed, 30 Mar 2011 08:40:19 -0400
Message-ID: <20110330124019.GA28062@sigill.intra.peff.net>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
 <20110329234955.GB14578@elie>
 <20110330001653.GA1161@sigill.intra.peff.net>
 <20110330002921.GC14578@elie>
 <20110330033017.GA18157@sigill.intra.peff.net>
 <20110330035733.GA2793@elie>
 <20110330041339.GA26281@sigill.intra.peff.net>
 <20110330084148.GE2793@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 14:40:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4uhM-0004fr-8n
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 14:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767Ab1C3Mk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 08:40:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59802
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681Ab1C3Mk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 08:40:26 -0400
Received: (qmail 9213 invoked by uid 107); 30 Mar 2011 12:41:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Mar 2011 08:41:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2011 08:40:19 -0400
Content-Disposition: inline
In-Reply-To: <20110330084148.GE2793@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170380>

On Wed, Mar 30, 2011 at 03:41:48AM -0500, Jonathan Nieder wrote:

> I don't think any of them is worth the fuss.  So how about this?
> 
> -- 8< --
> Subject: Revert "t0081 (line-buffer): add buffering tests"

That's OK with me. Should it drop test-line-buffer, too?

-Peff
