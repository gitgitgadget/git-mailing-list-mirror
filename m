From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Sat, 14 Feb 2009 10:17:59 -0500
Message-ID: <20090214151759.GC3887@sigill.intra.peff.net>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net> <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu> <20090206161954.GA18956@coredump.intra.peff.net> <alpine.GSO.2.00.0902090921270.719@kiwi.cs.ucla.edu> <20090213222233.GA7424@coredump.intra.peff.net> <alpine.DEB.1.00.0902140658050.10279@pacific.mpi-cbg.de> <20090214061538.GB3223@sigill.intra.peff.net> <alpine.DEB.1.00.0902140724360.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 16:19:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYMJ2-0007Bj-Bq
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 16:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbZBNPSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 10:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbZBNPSD
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 10:18:03 -0500
Received: from peff.net ([208.65.91.99]:54254 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbZBNPSC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 10:18:02 -0500
Received: (qmail 32473 invoked by uid 107); 14 Feb 2009 15:18:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 14 Feb 2009 10:18:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Feb 2009 10:17:59 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902140724360.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109873>

On Sat, Feb 14, 2009 at 07:24:54AM +0100, Johannes Schindelin wrote:

> > Yes, I also hate the name. I have been using it in the discussion for
> > lack of a better term, but I really dislike it, as well. I think
> > "diff.defaults" makes sense, but maybe something that suggests it is
> > about command line options would be better.
> 
> Why not spell it out?  diff.defaultOptions

Yes, that is much better than my suggestion.

-Peff
