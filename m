From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 0/4] Some cleanups
Date: Thu, 31 Mar 2016 15:33:33 -0400
Message-ID: <20160331193333.GD5013@sigill.intra.peff.net>
References: <1459447446-32260-1-git-send-email-sbeller@google.com>
 <20160331191252.GB5013@sigill.intra.peff.net>
 <xmqqio02mokp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:33:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aliLh-0007V1-VG
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 21:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267AbcCaTdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 15:33:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:41881 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752654AbcCaTdg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 15:33:36 -0400
Received: (qmail 9112 invoked by uid 102); 31 Mar 2016 19:33:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 15:33:35 -0400
Received: (qmail 16937 invoked by uid 107); 31 Mar 2016 19:33:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 15:33:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 15:33:33 -0400
Content-Disposition: inline
In-Reply-To: <xmqqio02mokp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290456>

On Thu, Mar 31, 2016 at 12:31:34PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > With the exception of the comments on patch 3, these all look good. I'll
> > leave it to Junio to decide whether he wants to polish up his "get rid
> > of strbuf_split" patch for patch 2. Certainly yours is a strict
> > improvement over what is there.
> 
> I do not think there were anything further to be polished up.  Other
> than that, I agree with all of the above.

Well, by polish up, I meant "write a commit message for". :)

The patch itself looked fine to me.

-Peff
