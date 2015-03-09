From: Jeff King <peff@peff.net>
Subject: Re: Is the Git Mailing List dropping messages?
Date: Mon, 9 Mar 2015 02:33:28 -0400
Message-ID: <20150309063327.GC27128@peff.net>
References: <43504C6C-5F97-480F-8543-350E04041C11@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 07:33:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUrFv-00013O-GP
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 07:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbbCIGdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 02:33:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:59030 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750930AbbCIGdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 02:33:31 -0400
Received: (qmail 6075 invoked by uid 102); 9 Mar 2015 06:33:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 01:33:31 -0500
Received: (qmail 4288 invoked by uid 107); 9 Mar 2015 06:33:38 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 02:33:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Mar 2015 02:33:28 -0400
Content-Disposition: inline
In-Reply-To: <43504C6C-5F97-480F-8543-350E04041C11@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265130>

On Fri, Mar 06, 2015 at 09:12:45PM -0800, Kyle J. McKay wrote:

> And I responded and that response and the rest of the thread are available
> on gmane [1], but the first two messages are not.  I waited 10 days just to
> make sure there were no bounce emails or undeliverable notifications coming
> back and none did.  I have checked the other list archives [2] and cannot
> find the first two messages there either.
> 
> I have therefore concluded that the git@vger mailing list ate them for a
> late breakfast snack on 2015-02-24.

I didn't get them either. I think it's clear that vger ate them.

vger will drop anything it thinks is spam. That's often by triggering
the taboo list[1], though I don't see anything in the messages below
that would do so. Badly formatted messages can be a problem, as well
(e.g., missing message-ids or dates, I think).

-Peff

[1] Try https://github.com/git/git/blob/todo/taboo.perl to check
    the taboo list locally.
