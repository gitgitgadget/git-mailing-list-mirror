From: Jeff King <peff@peff.net>
Subject: Re: Side-by-side diff and patch visualization
Date: Wed, 19 Sep 2007 08:09:56 -0400
Message-ID: <20070919120956.GA20715@coredump.intra.peff.net>
References: <A92611E8-1035-46A6-AFEF-9C8A6F93AFB1@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 14:10:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXyNa-0002lm-63
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 14:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbXISMKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 08:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbXISMKA
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 08:10:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2059 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbXISMJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 08:09:59 -0400
Received: (qmail 4555 invoked by uid 111); 19 Sep 2007 12:09:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 19 Sep 2007 08:09:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2007 08:09:56 -0400
Content-Disposition: inline
In-Reply-To: <A92611E8-1035-46A6-AFEF-9C8A6F93AFB1@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58704>

On Wed, Sep 19, 2007 at 01:40:17PM +0200, Wincent Colaiuta wrote:

> Does anybody know of any tools for doing side-by-side visualizations of 
> diffs and patches which work well with Git?

Have you tried kompare?

  git-diff HEAD~5 | kompare -

-Peff
