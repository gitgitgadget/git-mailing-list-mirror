From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sun, 6 Aug 2006 02:16:33 -0400
Message-ID: <20060806061633.GA19148@coredump.intra.peff.net>
References: <20060805031418.GA11102@coredump.intra.peff.net> <20060806050138.GN23246@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 08:16:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9bwI-0002OU-4O
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 08:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbWHFGQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 02:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbWHFGQg
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 02:16:36 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:26838 "HELO
	peff.net") by vger.kernel.org with SMTP id S932692AbWHFGQf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 02:16:35 -0400
Received: (qmail 5278 invoked from network); 6 Aug 2006 02:16:00 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 6 Aug 2006 02:16:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun,  6 Aug 2006 02:16:33 -0400
To: Joel Becker <Joel.Becker@oracle.com>
Content-Disposition: inline
In-Reply-To: <20060806050138.GN23246@ca-server1.us.oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24966>

On Sat, Aug 05, 2006 at 10:01:38PM -0700, Joel Becker wrote:

> Please do one of two things:
> 1) Add code to discover a terminal is white-on-black and use bright colors
> or
> 2) Default this to off.

It defaults to off. The colors are also easily customizable should you
want to use it.

-Peff
