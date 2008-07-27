From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up log messages
Date: Sun, 27 Jul 2008 20:33:09 +0200
Message-ID: <20080727183309.GD32184@machine.or.cz>
References: <9e4733910807271050y7fb5f77coec05bd68421baaab@mail.gmail.com> <alpine.DEB.1.00.0807272000270.5526@eeepc-johanness> <9e4733910807271116q29323664l8d44fdded1de8c8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 20:41:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNBBD-0001Tq-25
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 20:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbYG0SdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 14:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbYG0SdM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 14:33:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38851 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbYG0SdL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 14:33:11 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 227C8393B31D; Sun, 27 Jul 2008 20:33:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807271116q29323664l8d44fdded1de8c8e@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90354>

On Sun, Jul 27, 2008 at 02:16:30PM -0400, Jon Smirl wrote:
> On 7/27/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Something like .mailmap?
> >
> >  And to show the mapped author name instead of the committed one, you would
> >  use "--pretty=format:%aN"?  (Needs 1.6.0-rc0 at least, IIRC)
> 
> So we can already do this? Where is a .mailmap for the kernel tree?

	http://repo.or.cz/w/linux-2.6.git?a=blob;f=.mailmap

...right there. :-)

				Petr "Pasky" Baudis
