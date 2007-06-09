From: Jeff King <peff@peff.net>
Subject: Re: problems with cloning; http vs git protocols?
Date: Sat, 9 Jun 2007 11:55:21 -0400
Message-ID: <20070609155521.GA3577@sigill.intra.peff.net>
References: <1abe3fa90706090806m4014a680x89178bc5698fefda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "A.J. Rossini" <blindglobe@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 17:55:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx3Hk-00075G-IY
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 17:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbXFIPzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 11:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbXFIPzY
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 11:55:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2917 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933AbXFIPzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 11:55:23 -0400
Received: (qmail 2093 invoked from network); 9 Jun 2007 15:55:35 -0000
Received: from unknown (HELO sigill.intra.peff.net) (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 9 Jun 2007 15:55:35 -0000
Received: (qmail 3648 invoked by uid 1000); 9 Jun 2007 15:55:22 -0000
Content-Disposition: inline
In-Reply-To: <1abe3fa90706090806m4014a680x89178bc5698fefda@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49578>

On Sat, Jun 09, 2007 at 05:06:05PM +0200, A.J. Rossini wrote:

> I've been working to verify it to write instructions for friends, and
> here is the basic problem:
> 
> git clone http://repo.or.cz/w/rclg.git

That's the gitweb URL. Try visiting it in your web browser. The
git-over-http URL is:
  http://repo.or.cz/r/rclg.git

-Peff
