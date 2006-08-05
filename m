From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 5 Aug 2006 06:44:15 -0400
Message-ID: <20060805104415.GA31560@sigio.intra.peff.net>
References: <20060805031418.GA11102@coredump.intra.peff.net> <7vpsffedkw.fsf@assigned-by-dhcp.cox.net> <20060805102117.GA28348@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 12:44:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Jdk-0006Cu-Ou
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 12:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWHEKoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 06:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWHEKoR
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 06:44:17 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:27527 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751458AbWHEKoQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 06:44:16 -0400
Received: (qmail 7413 invoked from network); 5 Aug 2006 06:43:41 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 5 Aug 2006 06:43:41 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Sat,  5 Aug 2006 06:44:15 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060805102117.GA28348@sigio.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24897>

On Sat, Aug 05, 2006 at 06:21:18AM -0400, Jeff King wrote:

> > > +    T ) color $1; echo "1change: $name"; uncolor $1;;
> > Is "1" a typo?
> Oops, yes, not sure how that got in there.

Oh, I see. It should be 'typechange' in case you didn't reference
against the original version.

-Peff
