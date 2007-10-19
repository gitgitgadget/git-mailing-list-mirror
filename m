From: Jeff King <peff@peff.net>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 22:16:18 -0400
Message-ID: <20071019021618.GE3290@coredump.intra.peff.net>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <D2EAAC6D-567D-454A-AECA-C90FA2C369AE@mit.edu> <20071019015715.GW14735@spearce.org> <7F18F52A-3D57-4510-B71B-69D43480126E@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:16:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihPc-0007iT-Ms
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760377AbXJSCQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760356AbXJSCQV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:16:21 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3210 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759798AbXJSCQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:16:20 -0400
Received: (qmail 7474 invoked by uid 111); 19 Oct 2007 02:16:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 22:16:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 22:16:18 -0400
Content-Disposition: inline
In-Reply-To: <7F18F52A-3D57-4510-B71B-69D43480126E@MIT.EDU>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61603>

On Thu, Oct 18, 2007 at 10:07:05PM -0400, Michael Witten wrote:

> I mean to say, if only the index is changed,
> then git won't be informed about the necessary
> git-{add/rm}'s, as in the following (is this
> not so?):

Eh? The changes will make it into history when you commit. Or perhaps I
don't understand your question. Can you rephrase it?

-Peff
