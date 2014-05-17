From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/10] replace: add option to edit a Git object
Date: Sat, 17 May 2014 03:24:51 -0400
Message-ID: <20140517072451.GG13003@sigill.intra.peff.net>
References: <20140517062418.18932.21200.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat May 17 09:24:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlYzJ-0004XW-Sn
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 09:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbaEQHYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 03:24:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:53696 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757109AbaEQHYx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 03:24:53 -0400
Received: (qmail 11812 invoked by uid 102); 17 May 2014 07:24:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 May 2014 02:24:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 May 2014 03:24:51 -0400
Content-Disposition: inline
In-Reply-To: <20140517062418.18932.21200.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249457>

On Sat, May 17, 2014 at 08:41:22AM +0200, Christian Couder wrote:

> This patch series comes from what Peff sent in the following thread:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/243361/focus=243528
> 
> The first 4 patches (1/4, 2/4, 3/4 and 4/4) didn't change since v1.
> I added 6 more small patches to add tests, documentation and a few
> small improvements. 

Thanks, I think these look pretty good. I made a few small comments in
reply to the individual patches.

-Peff
