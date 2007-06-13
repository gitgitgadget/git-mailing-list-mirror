From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Interpret :/<pattern> as a regular expression
Date: Wed, 13 Jun 2007 14:41:10 -0400
Message-ID: <20070613184109.GG10941@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:41:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyXmd-0002rK-N2
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 20:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbXFMSlQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 14:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759987AbXFMSlO
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 14:41:14 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4064 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759975AbXFMSlN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 14:41:13 -0400
Received: (qmail 14326 invoked from network); 13 Jun 2007 18:41:25 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 13 Jun 2007 18:41:25 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jun 2007 14:41:10 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706130148080.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50114>

On Wed, Jun 13, 2007 at 01:50:22AM +0100, Johannes Schindelin wrote:

> Earlier, Git interpreted the pattern as a strict prefix, which made
> the operator unsuited in many cases.

Thank you for working on this...I really like the :/ concept, but find
myself wishing for a regex all the time. I have been meaning to do it
since you introduced the original. :)

-Peff
