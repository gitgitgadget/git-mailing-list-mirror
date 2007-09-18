From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] contrib/fast-import: add perl version of simple example
Date: Tue, 18 Sep 2007 13:36:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709181334210.28586@racer.site>
References: <20070918072627.GB3506@coredump.intra.peff.net>
 <Pine.LNX.4.64.0709181115250.28586@racer.site> <46EFA84C.3080906@op5.se>
 <20070918103051.GA22239@coredump.intra.peff.net> <Pine.LNX.4.64.0709181217200.28586@racer.site>
 <46EFBD40.1070102@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 14:37:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXcKD-0007e2-7E
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 14:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026AbXIRMhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 08:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754509AbXIRMhE
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 08:37:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:49191 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751613AbXIRMhB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 08:37:01 -0400
Received: (qmail invoked by alias); 18 Sep 2007 12:36:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 18 Sep 2007 14:36:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BGu1EhgWBRnGzKRmQycviAGNFbA7viFlz/dTCtZ
	v98KATL9TFMbdX
X-X-Sender: gene099@racer.site
In-Reply-To: <46EFBD40.1070102@vilain.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58596>

Hi,

On Tue, 18 Sep 2007, Sam Vilain wrote:

> I personally want to be able to dump patches, including merges, to
> git-format-patch format, in such a way that all other information (eg,
> committer, date, etc) is preserved.

We already talked about that on IRC, and you have not even _begun_ to 
think about the fundamental issues with merges-in-a-patch.  I mentioned a 
few on IRC, and am still awaiting your reply.

Unless you tackle those fundamental issues, I am afraid it is not worth 
bothering to discuss this subject any more.

Ciao,
Dscho
