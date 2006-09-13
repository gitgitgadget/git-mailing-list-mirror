From: Nicolas Pitre <nico@cam.org>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 13:46:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609131344420.2627@xanadu.home>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
 <20060913152451.GH23891@pasky.or.cz>
 <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
 <Pine.LNX.4.63.0609131804050.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <9e4733910609131022y19327efy541ac451bdf4b009@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 19:48:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNYqC-00076d-HY
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 19:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWIMRqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 13:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWIMRqx
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 13:46:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48430 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750841AbWIMRqm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 13:46:42 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5J00F5RLDT8V40@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 13 Sep 2006 13:46:41 -0400 (EDT)
In-reply-to: <9e4733910609131022y19327efy541ac451bdf4b009@mail.gmail.com>
X-X-Sender: nico@xanadu.home
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26928>

On Wed, 13 Sep 2006, Jon Smirl wrote:

> If you delete all of your heads you can recover them by following all
> of the chains in the repo to find them. Doing this would recover the
> abandoned branches too but it would mix them up with the active heads.

Well, just don't do that then.  ;-)

> This is not a big deal but it is info that is getting stored outside
> of the object db.

Sure, but the object db is useless without them anyway.


Nicolas
