From: Jeff King <peff@peff.net>
Subject: Re: Publishing on a simple HTTP server
Date: Wed, 14 Feb 2007 06:23:24 -0500
Message-ID: <20070214112324.GA5472@coredump.intra.peff.net>
References: <14870.1171311025@localhost> <Pine.LNX.4.63.0702130009010.22628@wbgn013.biozentrum.uni-wuerzburg.de> <19695.1171344721@localhost> <Pine.LNX.4.63.0702131106230.1300@wbgn013.biozentrum.uni-wuerzburg.de> <23628.1171367140@localhost> <Pine.LNX.4.63.0702131256430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <4127.1171450765@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 12:23:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHIEU-0002nk-7T
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 12:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbXBNLX1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 06:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbXBNLX1
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 06:23:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2022 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932219AbXBNLX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 06:23:26 -0500
Received: (qmail 30660 invoked from network); 14 Feb 2007 06:23:31 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 14 Feb 2007 06:23:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2007 06:23:24 -0500
Content-Disposition: inline
In-Reply-To: <4127.1171450765@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39636>

On Wed, Feb 14, 2007 at 11:59:25AM +0100, Xavier Maillard wrote:

> I double checked and yes, info/refs is really updated and yes, it
> is mirrored but it still fails when I try to clone my repository
> with this:
> 
>  git clone http://zedek01.free.fr/projetcs/your-proj2.git
> 
> (you can try by yourself).

It works fine when I try it (after correcting the typo). What's not
working?

-Peff
