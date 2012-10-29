From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pathspec.c: Fix some sparse warnings
Date: Mon, 29 Oct 2012 01:55:00 -0400
Message-ID: <20121029055500.GA4457@sigill.intra.peff.net>
References: <508D9EFF.3040900@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@adamspiers.org,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Oct 29 06:55:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSiJj-00057T-1p
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 06:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399Ab2J2FzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 01:55:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41806 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754305Ab2J2FzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 01:55:03 -0400
Received: (qmail 15617 invoked by uid 107); 29 Oct 2012 05:55:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 01:55:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 01:55:00 -0400
Content-Disposition: inline
In-Reply-To: <508D9EFF.3040900@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208588>

On Sun, Oct 28, 2012 at 09:09:19PM +0000, Ramsay Jones wrote:

> I asked Adam to squash this patch into his 'as/check-ignore' branch
> when he next re-rolled the branch. However, it appears that you
> resubmitted that branch instead ... :-D
> 
> I don't know if this branch is ready to progress to next yet, but
> could somebody (yourself, Adam or Jeff?) please squash this into
> commit 1a88ae42 ("pathspec.c: move reusable code from builtin/add.c")
> before it hits next.

I squashed it into my version of as/check-ignore, but if we are
expecting a re-roll, please everybody remember to include it.

-Peff
