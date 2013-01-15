From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/14] Remove unused code from imap-send.c
Date: Tue, 15 Jan 2013 06:42:21 -0800
Message-ID: <20130115144220.GA19023@sigill.intra.peff.net>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 15 15:42:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv7ix-0004JK-It
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 15:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194Ab3AOOmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 09:42:25 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34026 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756394Ab3AOOmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 09:42:25 -0500
Received: (qmail 29711 invoked by uid 107); 15 Jan 2013 14:43:41 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Jan 2013 09:43:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2013 06:42:21 -0800
Content-Disposition: inline
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213638>

On Tue, Jan 15, 2013 at 09:06:18AM +0100, Michael Haggerty wrote:

> This is a re-roll, incorporating the feedback of Jonathan Nieder
> (thanks!).

Thanks, I don't see anything wrong with this from a cursory reading.

> * Added some comments to lf_to_crlf(), simplified the code a bit
>   further, and expanded the commit message.

I found this version pretty easy to read (the comments helped a lot).

-Peff
