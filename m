From: Jeff King <peff@peff.net>
Subject: Re: git cherry-pick feature request
Date: Wed, 23 Aug 2006 10:35:51 -0400
Message-ID: <20060823143551.GA4592@sigio.intra.peff.net>
References: <17643.62896.396783.890223@cargo.ozlabs.ibm.com> <7vfyfnixv5.fsf@assigned-by-dhcp.cox.net> <17644.21269.128308.313284@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 16:36:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFtpl-0000r5-AP
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 16:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWHWOfy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 10:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWHWOfy
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 10:35:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:63913 "HELO
	peff.net") by vger.kernel.org with SMTP id S964901AbWHWOfy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 10:35:54 -0400
Received: (qmail 12681 invoked from network); 23 Aug 2006 10:35:12 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 23 Aug 2006 10:35:12 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Aug 2006 10:35:51 -0400
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17644.21269.128308.313284@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25919>

On Wed, Aug 23, 2006 at 11:07:33PM +1000, Paul Mackerras wrote:

> While I'm asking for features, another one that would be really useful
> for another tool I'm writing is a 3-way diff for a file between the
> working directory, the index, and the current head commit, something
> like what git diff-tree -c does for merges.  That is, it would have

Theoretically I'm working on this, but I haven't really had time to get
started on it yet this week. If you have patience, I'll get to it. If
not, then somebody else is welcome to take a crack at it.

-Peff
