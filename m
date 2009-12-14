From: Jeff King <peff@peff.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 16:23:43 -0500
Message-ID: <20091214212343.GA11131@coredump.intra.peff.net>
References: <1260822484.9379.53.camel@localhost>
 <20091214211142.GC9364@coredump.intra.peff.net>
 <1260825629.9379.56.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:24:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKIOj-0002Pa-MS
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 22:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272AbZLNVX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 16:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758277AbZLNVXu
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 16:23:50 -0500
Received: from peff.net ([208.65.91.99]:49862 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756793AbZLNVXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 16:23:49 -0500
Received: (qmail 14886 invoked by uid 107); 14 Dec 2009 21:28:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 14 Dec 2009 16:28:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2009 16:23:43 -0500
Content-Disposition: inline
In-Reply-To: <1260825629.9379.56.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135242>

On Mon, Dec 14, 2009 at 04:20:29PM -0500, Eric Paris wrote:

> Updated to git-1.6.5.3-1 from Fedora rawhide and still git reflog ran
> for >5 minutes at 100% cpu (I killed it, it didn't finish)
> 
> I'm pushing a copy of the whole repo (all 1.9G after bzip compression)
> to
> 
> http://people.redhat.com/~eparis/git-tar/

Wowzers, that's big. Can you send just what's in .git?

-Peff
