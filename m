From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 10/13] credentials: add "cache" helper
Date: Wed, 11 Jan 2012 22:07:46 -0500
Message-ID: <20120112030746.GB26363@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103407.GJ16529@sigill.intra.peff.net>
 <20120110015038.GA17754@burratino>
 <20120110044430.GA23619@sigill.intra.peff.net>
 <20120110174420.GA22184@burratino>
 <20120110175312.GA7289@sigill.intra.peff.net>
 <20120111235009.GB30243@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 04:07:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlB17-0000s2-I4
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 04:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab2ALDHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 22:07:49 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35616
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918Ab2ALDHs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 22:07:48 -0500
Received: (qmail 27447 invoked by uid 107); 12 Jan 2012 03:14:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Jan 2012 22:14:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2012 22:07:46 -0500
Content-Disposition: inline
In-Reply-To: <20120111235009.GB30243@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188425>

On Wed, Jan 11, 2012 at 05:50:10PM -0600, Jonathan Nieder wrote:

> Thanks again for the fix.  Here's another quick nit.

My favorite form for nits to come in: a patch.

> -- >8 --
> Subject: unix-socket: do not let close() or chdir() clobber errno during cleanup
> [...]

Looks good to me. Thanks.

-Peff
