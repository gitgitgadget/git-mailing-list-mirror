From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Commit ID in exported Tar Ball
Date: Thu, 17 May 2007 19:14:57 +0200
Message-ID: <20070517171457.GG4095@cip.informatik.uni-erlangen.de>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu May 17 19:15:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HojZJ-0001WW-Bk
	for gcvg-git@gmane.org; Thu, 17 May 2007 19:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758040AbXEQRO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 13:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758012AbXEQRO7
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 13:14:59 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:64306 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758043AbXEQRO6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2007 13:14:58 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 3D69F3F316; Thu, 17 May 2007 19:14:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070517171150.GL5272@planck.djpig.de>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47542>

Hello,

> Another possibility might be to add a commandline switch to
> git-archive so you can decide whether the commit id should be added as
> a header to the tar file (which it already supports) or as a ordinary
> file (which should be reasonable trivial to implement). The question
> if whether it would be worth to add that feature. Don't know if there
> are many other users out there that need it.

that would be very good aproach I guess. At least from my point of view.
Because it doesn't break diffs, it concentrates on what matters and if
you don't like it you don't use it.

        Thomas
