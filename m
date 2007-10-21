From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] On error, do not list all commands, but point to
	--help option.
Date: Sat, 20 Oct 2007 23:24:27 -0400
Message-ID: <20071021032427.GB8545@coredump.intra.peff.net>
References: <bqaujirk.fsf@blue.sea.net> <Pine.LNX.4.64.0710202126430.25221@racer.site> <odetifoh.fsf@blue.sea.net> <Pine.LNX.4.64.0710210001390.25221@racer.site> <20071021020653.GA14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 05:24:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjRQh-0008Vd-GZ
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 05:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbXJUDYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 23:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbXJUDYb
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 23:24:31 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3993 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbXJUDYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 23:24:30 -0400
Received: (qmail 24015 invoked by uid 111); 21 Oct 2007 03:24:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 20 Oct 2007 23:24:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Oct 2007 23:24:27 -0400
Content-Disposition: inline
In-Reply-To: <20071021020653.GA14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61872>

On Sat, Oct 20, 2007 at 10:06:53PM -0400, Shawn O. Pearce wrote:

> I actually had to do `git config alias.upsh push` just to keep
> myself from screaming every time I made a small typo and Git gave
> me a screenful of "helpful reminders".

Yeah, somebody should really work on bash completion...

-Peff
