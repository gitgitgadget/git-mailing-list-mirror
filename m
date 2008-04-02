From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] help: Add a missing OPT_END().
Date: Tue, 1 Apr 2008 23:44:31 -0400
Message-ID: <20080402034430.GA10360@coredump.intra.peff.net>
References: <20080402054741.24d95299.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio Hamano <junkio@cox.net>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 05:45:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgtuW-0006Ds-7Y
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 05:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743AbYDBDoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 23:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689AbYDBDoe
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 23:44:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3630 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755017AbYDBDod (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 23:44:33 -0400
Received: (qmail 21084 invoked by uid 111); 2 Apr 2008 03:44:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 01 Apr 2008 23:44:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2008 23:44:31 -0400
Content-Disposition: inline
In-Reply-To: <20080402054741.24d95299.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78678>

On Wed, Apr 02, 2008 at 05:47:41AM +0200, Christian Couder wrote:

> 	Some comments in "parse-options.h" say it is needed,
> 	though I did not see a crash without it.

There was no particular reason I didn't put it in; I just didn't know
about it. So ack from me, assuming it is supposed to be there.

-Peff
