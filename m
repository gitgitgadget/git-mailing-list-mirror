From: Jeff King <peff@peff.net>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 23:24:07 -0400
Message-ID: <20071019032407.GA10622@coredump.intra.peff.net>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <20071019015419.GV14735@spearce.org> <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu> <20071019031959.GE14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@MIT.EDU>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:24:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiiTY-00087N-EP
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760377AbXJSDYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759939AbXJSDYL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:24:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4787 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758625AbXJSDYK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:24:10 -0400
Received: (qmail 8398 invoked by uid 111); 19 Oct 2007 03:24:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 23:24:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 23:24:07 -0400
Content-Disposition: inline
In-Reply-To: <20071019031959.GE14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61628>

On Thu, Oct 18, 2007 at 11:19:59PM -0400, Shawn O. Pearce wrote:

> touch the working tree".  Here we want to touch the working tree
> in the sense of moving the file.  So --cached is not the correct
> option name.

Doesn't "mv" do that?

-Peff
