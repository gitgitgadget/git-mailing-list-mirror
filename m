From: Jeff King <peff@peff.net>
Subject: Re: Submitting patches from unsubscribed authors?
Date: Tue, 16 Sep 2008 19:48:11 -0400
Message-ID: <20080916234811.GB14405@coredump.intra.peff.net>
References: <57518fd10809161624u3b2937dmd36e0fc962ea7a7@mail.gmail.com> <20080916233613.GA14251@coredump.intra.peff.net> <57518fd10809161644v348bd347xeed0bc7cb35805a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 01:49:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfkIL-0006xY-H1
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbYIPXsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 19:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbYIPXsO
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:48:14 -0400
Received: from peff.net ([208.65.91.99]:3108 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbYIPXsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:48:14 -0400
Received: (qmail 25564 invoked by uid 111); 16 Sep 2008 23:48:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 16 Sep 2008 19:48:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Sep 2008 19:48:11 -0400
Content-Disposition: inline
In-Reply-To: <57518fd10809161644v348bd347xeed0bc7cb35805a1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96054>

On Wed, Sep 17, 2008 at 12:44:55AM +0100, Jonathan del Strother wrote:

> I assumed that I was confusing git-send-email with my multiple email
> addresses and that was a broken header.  git-am will work fine with
> that second From: line being embedded in the commit message, then?

Yep. It's a feature. See git-am(1), section "DISCUSSION".

-Peff
