From: Jeff King <peff@peff.net>
Subject: Re: Why is it important to learn git?
Date: Thu, 23 Jul 2009 01:00:13 -0400
Message-ID: <20090723050013.GA9189@coredump.intra.peff.net>
References: <e1a5e9a00907212208t10a071d0oe59a39b357a1111a@mail.gmail.com>
 <200907220952.27385.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:01:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTqR1-0002HC-Vr
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 07:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbZGWFAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 01:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbZGWFAS
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 01:00:18 -0400
Received: from peff.net ([208.65.91.99]:34922 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbZGWFAO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 01:00:14 -0400
Received: (qmail 8508 invoked by uid 107); 23 Jul 2009 05:02:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 23 Jul 2009 01:02:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jul 2009 01:00:13 -0400
Content-Disposition: inline
In-Reply-To: <200907220952.27385.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123834>

On Wed, Jul 22, 2009 at 09:52:26AM +0200, Thomas Rast wrote:

> > How has mastering the advanced features of git helped you to be a
> > better programmer?
> 
> I came from SVN, and I guess the most important change for me was:
> 
>   Learning to make nice, reviewable, working, one-change-per-revision
>   commits.

Same here. Git makes this easy to do. But it also makes me _want_ to do
it, because I benefit later from the advanced history investigation tools
like bisecting, pickaxe, blame, and even just decent visualization like
gitk that is lacking in other systems.

And of course if your workflow is based on reviewing patches (like for
git itself), then it is almost necessary.

-Peff
