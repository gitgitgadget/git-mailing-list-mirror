From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t6024-recursive-merge.sh: hide spurious output when
	not running verbosely
Date: Fri, 29 Feb 2008 23:28:22 -0500
Message-ID: <20080301042822.GA14274@coredump.intra.peff.net>
References: <1204323805-23185-1-git-send-email-mh@glandium.org> <alpine.LSU.1.00.0802292334040.22527@racer.site> <7v1w6vb9w4.fsf@gitster.siamese.dyndns.org> <20080301041005.GA8969@coredump.intra.peff.net> <20080301042739.GX8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 05:29:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVJLJ-00033F-IX
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 05:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbYCAE2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 23:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbYCAE2Z
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 23:28:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1340 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbYCAE2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 23:28:25 -0500
Received: (qmail 30191 invoked by uid 111); 1 Mar 2008 04:28:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 29 Feb 2008 23:28:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Feb 2008 23:28:22 -0500
Content-Disposition: inline
In-Reply-To: <20080301042739.GX8410@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75608>

On Fri, Feb 29, 2008 at 11:27:39PM -0500, Shawn O. Pearce wrote:

> This is why when tests start to fail I just rerun the specific case
> with "-i -v" and let the test stop on the first failure, *fix that
> one case* and run again to see if anything else is going to barf.

Yes, exactly. I assumed that everyone did that.

-Peff
