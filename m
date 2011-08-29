From: Jeff King <peff@peff.net>
Subject: git bug reporting
Date: Mon, 29 Aug 2011 15:26:18 -0400
Message-ID: <20110829192618.GF756@sigill.intra.peff.net>
References: <20110829132052.0ad7a088@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 21:26:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy7TY-0003qr-08
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 21:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab1H2T0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 15:26:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37854
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829Ab1H2T0U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 15:26:20 -0400
Received: (qmail 19490 invoked by uid 107); 29 Aug 2011 19:27:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Aug 2011 15:27:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2011 15:26:18 -0400
Content-Disposition: inline
In-Reply-To: <20110829132052.0ad7a088@robyn.woti.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180332>

On Mon, Aug 29, 2011 at 01:20:52PM -0400, Bryan Jacobs wrote:

> Dear git Developers,
> 
> Apologies if this is not the right forum for bug reports. I was unable
> to find a Bugzilla/Redmine/Flyspray instance for issue maintenance, nor
> some "proper procedure" on the git web page.

Yes, this is the right place. This question seems to be coming up a lot
lately. And indeed, looking at the webpage and the wiki, we are not very
clear that the mailing list is the place for such things.

Do you mind telling us where you looked? That will give us at least one
spot that we know should be more clear. :)

In the meantime, I've updated:

  1. The GitCommunity wiki page to mention that bug reports should go
     to the list.

  2. Added an entry "How do I report a bug in git?" to the FAQ on the
     wiki.

  3. Sent Scott a patch for git-scm.org to mention bug reporting under
     the big "Got questions" banner on the front page that points people
     to the mailing list. Pull request is here:

       https://github.com/schacon/gitscm/pull/11

     It may make sense to have a specific page on reporting bugs, and
     link to it via a bigger "how to report bugs" somewhere on the front
     page of git-scm.org.

-Peff
