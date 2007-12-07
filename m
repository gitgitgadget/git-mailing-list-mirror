From: Jeff King <peff@peff.net>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Fri, 7 Dec 2007 16:35:41 -0500
Message-ID: <20071207213541.GA11723@coredump.intra.peff.net>
References: <20071207093439.GA21896@elte.hu> <7v63za4yic.fsf@gitster.siamese.dyndns.org> <7vwsrq3iox.fsf@gitster.siamese.dyndns.org> <20071207213414.GA11688@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:36:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0krj-0001m6-W4
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756973AbXLGVfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756915AbXLGVfp
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:35:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3647 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613AbXLGVfo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:35:44 -0500
Received: (qmail 13357 invoked by uid 111); 7 Dec 2007 21:35:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Dec 2007 16:35:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2007 16:35:41 -0500
Content-Disposition: inline
In-Reply-To: <20071207213414.GA11688@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67466>

On Fri, Dec 07, 2007 at 04:34:14PM -0500, Jeff King wrote:

> On Fri, Dec 07, 2007 at 02:25:34AM -0800, Junio C Hamano wrote:
> 
> > git-bisect visualize: work in non-windowed environments better
> 
> Isn't this more or less the use case for the "git view" alias?

Which isn't to say that I don't think your solution is nicer; it is. But
if we don't use it here, then perhaps "git view" really is a solution in
search of a problem.

-Peff
