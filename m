From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 08:04:00 -0400
Message-ID: <20090914120359.GB17172@sigill.intra.peff.net>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
 <20090914105750.GB9216@sigill.intra.peff.net>
 <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
 <40aa078e0909140456l47cfce92yc44262c96b59bf2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 14:04:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnAHu-00073B-V3
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 14:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380AbZINMD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 08:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755305AbZINMD6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 08:03:58 -0400
Received: from peff.net ([208.65.91.99]:54948 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754618AbZINMD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 08:03:57 -0400
Received: (qmail 24276 invoked by uid 107); 14 Sep 2009 12:04:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 14 Sep 2009 08:04:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Sep 2009 08:04:00 -0400
Content-Disposition: inline
In-Reply-To: <40aa078e0909140456l47cfce92yc44262c96b59bf2d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128451>

On Mon, Sep 14, 2009 at 01:56:29PM +0200, Erik Faye-Lund wrote:

> > That's odd. It's listed in my git-folder on GMail as sent to the
> > mailing-list, but I can't find it in any of the list-archives. They
> > were both sent through the same instance of "git send-email". I guess
> > I'll just re-send it.
> 
> OK, I think I figured out why: For some reason, the From-field of the
> mail had gotten changed from kus...e@gmail.com to
> kus...e@googlemail.com, and that's not the address I'm subsribed to
> this list as. I hope whoever manages the list is able to remove my
> duplicates from the moderation-queue or something ;)

I doubt that is it; you don't have to be subscribed to post.

-Peff
