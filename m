From: Jeff King <peff@peff.net>
Subject: Re: confusion over the new branch and merge config
Date: Tue, 2 Jan 2007 12:34:11 -0500
Message-ID: <20070102173410.GA25325@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net> <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net> <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net> <20070102144940.GA23932@coredump.intra.peff.net> <7vps9xwd01.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 18:34:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1nWl-0007Mw-NG
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 18:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbXABReP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 12:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753666AbXABReP
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 12:34:15 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1936 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753645AbXABReO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 12:34:14 -0500
Received: (qmail 2367 invoked from network); 2 Jan 2007 12:34:20 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 2 Jan 2007 12:34:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jan 2007 12:34:11 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vps9xwd01.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35793>

On Tue, Jan 02, 2007 at 09:32:30AM -0800, Junio C Hamano wrote:

> If we are to worry about, and I think we might have to, I think
> not worrying about mergelocal and not accepting the name of
> local tracking branch is the only sensible thing to do.

Sorry, I don't see the problem with mergelocal. Can you elaborate?

-Peff
