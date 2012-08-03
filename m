From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v1.7.12-rc1
Date: Fri, 3 Aug 2012 15:23:37 -0400
Message-ID: <20120803192337.GA5091@sigill.intra.peff.net>
References: <7v8ve0q4yy.fsf@alter.siamese.dyndns.org>
 <20120803161916.GA16973@sigill.intra.peff.net>
 <20120803170336.GA24237@sigill.intra.peff.net>
 <7vk3xfbxe6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 21:23:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxNTN-0006Fe-N1
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 21:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab2HCTXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 15:23:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50853 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448Ab2HCTXj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 15:23:39 -0400
Received: (qmail 27363 invoked by uid 107); 3 Aug 2012 19:23:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Aug 2012 15:23:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2012 15:23:37 -0400
Content-Disposition: inline
In-Reply-To: <7vk3xfbxe6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202851>

On Fri, Aug 03, 2012 at 12:14:57PM -0700, Junio C Hamano wrote:

> >> Here's a repost for convenience.
> >
> > And here's an update to the release notes.
> 
> Thanks.  Both are signed-off (I expect regulars to lead newbies by
> example, so...).

[s/are/are not/, I assume you mean]

Oops. I recently refactored my "print one patch so I can stuff it in an
email" alias and it lost its "add-signoff" functionality.  Both should
be signed-off, obviously; can you forge for me this time, and I'll fix
my alias? I can also re-send if you want to make an example of me. :)

-Peff
