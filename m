From: Jeff King <peff@peff.net>
Subject: Re: Undo git-rm without commit?
Date: Wed, 26 Mar 2008 02:39:52 -0400
Message-ID: <20080326063951.GA26859@coredump.intra.peff.net>
References: <D6386C1A-92D3-4E11-8DE6-CC7553211A33@faithfulgeek.org> <20080326062635.GC26286@coredump.intra.peff.net> <0535D2B4-0C4A-40D0-879A-7E0C5B3B48E4@faithfulgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 07:40:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JePJh-0004bR-Hc
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 07:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbYCZGkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 02:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbYCZGkO
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 02:40:14 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3408 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbYCZGkN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 02:40:13 -0400
Received: (qmail 5468 invoked by uid 111); 26 Mar 2008 06:39:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Mar 2008 02:39:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2008 02:39:52 -0400
Content-Disposition: inline
In-Reply-To: <0535D2B4-0C4A-40D0-879A-7E0C5B3B48E4@faithfulgeek.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78265>

On Wed, Mar 26, 2008 at 02:38:42AM -0400, Joe Fiorini wrote:

> Yeah, it warned me, I wasn't being careful enough.  I guess I didn't  
> think it would remove from the working tree, just the repository.  My err 
> for not reading the docs until _after_ the mistake.  Live & learn.  Thanks 
> for the help, opening lost-found/other in TextMate solved my problem 
> quickly!

OK, good. Just making sure there wasn't a bug in rm. ;)

-Peff
