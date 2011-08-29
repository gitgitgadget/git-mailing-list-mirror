From: Bryan Jacobs <bjacobs@woti.com>
Subject: Re: git bug reporting
Date: Mon, 29 Aug 2011 15:34:48 -0400
Organization: White Oak Technologies
Message-ID: <20110829153448.190baaa1@robyn.woti.com>
References: <20110829132052.0ad7a088@robyn.woti.com>
	<20110829192618.GF756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 29 21:34:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy7bm-0007Rf-E8
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 21:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab1H2Tex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 15:34:53 -0400
Received: from mail02.woti.us ([66.92.158.6]:41925 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754886Ab1H2Tew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 15:34:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id 779F5504D37F0;
	Mon, 29 Aug 2011 15:34:49 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 56SPvBxX48JH; Mon, 29 Aug 2011 15:34:48 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 8F71E504D37EA;
	Mon, 29 Aug 2011 15:34:48 -0400 (EDT)
In-Reply-To: <20110829192618.GF756@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180333>

On Mon, 29 Aug 2011 15:26:18 -0400
Jeff King <peff@peff.net> wrote:

> On Mon, Aug 29, 2011 at 01:20:52PM -0400, Bryan Jacobs wrote:
> 
> > Dear git Developers,
> > 
> > Apologies if this is not the right forum for bug reports. I was
> > unable to find a Bugzilla/Redmine/Flyspray instance for issue
> > maintenance, nor some "proper procedure" on the git web page.
> 
> Yes, this is the right place. This question seems to be coming up a
> lot lately. And indeed, looking at the webpage and the wiki, we are
> not very clear that the mailing list is the place for such things.
> 
> Do you mind telling us where you looked? That will give us at least
> one spot that we know should be more clear. :)

I looked at the git-scm.com main page, the "documentation" sub-page,
the wiki front page, and googled the site for terms like "issue tracker"
and "bug reports", then read the FAQ.

> In the meantime, I've updated:
> 
>   1. The GitCommunity wiki page to mention that bug reports should go
>      to the list.
> 
>   2. Added an entry "How do I report a bug in git?" to the FAQ on the
>      wiki.
> 
>   3. Sent Scott a patch for git-scm.org to mention bug reporting under
>      the big "Got questions" banner on the front page that points
> people to the mailing list. Pull request is here:
> 
>        https://github.com/schacon/gitscm/pull/11
> 
>      It may make sense to have a specific page on reporting bugs, and
>      link to it via a bigger "how to report bugs" somewhere on the
> front page of git-scm.org.

Thank you very much for your efforts. It looks like you hit all but one
of the places I looked. I agree that having a link from some part of the
git-scm landing page would make sense, that's common practice for
software projects and seems to me a logical place for it. I (obviously)
read the text under the "got questions" bit; it was what sent me to
this list. If it had said "report a bug here" I would have felt more
confident about sending this message.

Bryan Jacobs
