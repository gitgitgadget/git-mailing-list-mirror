From: Jeff King <peff@peff.net>
Subject: Re: Git Benchmark
Date: Wed, 11 Dec 2013 07:08:21 +0800
Message-ID: <20131210230821.GC7643@sigill.intra.peff.net>
References: <52A77F6E.7030005@winniehell.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Winniehell <git@winniehell.de>
X-From: git-owner@vger.kernel.org Wed Dec 11 00:08:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqWPn-0002Gf-CR
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 00:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980Ab3LJXI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 18:08:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:58059 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750806Ab3LJXI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 18:08:27 -0500
Received: (qmail 3538 invoked by uid 102); 10 Dec 2013 23:08:26 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (123.127.199.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Dec 2013 17:08:26 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Dec 2013 07:08:21 +0800
Content-Disposition: inline
In-Reply-To: <52A77F6E.7030005@winniehell.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239160>

On Tue, Dec 10, 2013 at 09:54:06PM +0100, Winniehell wrote:

> There is a benchmark on the Git website [1]. Unfortunately it lacks (in
> my opinion substantial) information about what Git and what SVN version
> has been used. Can anyone give me that  information? Is there any chance
> that I can run the benchmarks myself?
>
> [1] http://www.git-scm.com/about/small-and-fast

I believe those numbers were all run by Scott (cc'd), and are probably
pretty old at this point. If you want to design and run a more modern
benchmark, I'm sure we'd all be interested to see the results on this
list.

-Peff
