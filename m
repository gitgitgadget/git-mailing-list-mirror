From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] GIT 1.5.5-rc2
Date: Fri, 28 Mar 2008 14:13:45 -0400
Message-ID: <20080328181345.GB8299@coredump.intra.peff.net>
References: <7viqz72we4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 19:14:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfJ5x-0001Qc-FY
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 19:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbYC1SNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 14:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754521AbYC1SNr
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 14:13:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4709 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754173AbYC1SNr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 14:13:47 -0400
Received: (qmail 26696 invoked by uid 111); 28 Mar 2008 18:13:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 28 Mar 2008 14:13:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2008 14:13:45 -0400
Content-Disposition: inline
In-Reply-To: <7viqz72we4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78432>

On Thu, Mar 27, 2008 at 11:30:27PM -0700, Junio C Hamano wrote:

> GIT 1.5.5-rc2 was tagged tonight, and it is available from the usual
> places.

I never got a response to my patches to fix encoding issues in
"send-email --compose". It _is_ a bugfix, but I don't know if it is
1.5.5-worthy.  Forgotten (and I should resubmit now), or should I wait
until after the release?

-Peff
