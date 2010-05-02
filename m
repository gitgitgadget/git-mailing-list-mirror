From: Bron Gondwana <brong@fastmail.fm>
Subject: Re: WANTED: patch splitting tool - waypoints
Date: Mon, 3 May 2010 09:40:58 +1000
Organization: brong.net
Message-ID: <20100502234058.GA1818@brong.net>
References: <20100502115842.GA11607@brong.net>
 <vpqpr1euy7e.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 03 02:17:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8jLS-00080D-6y
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 02:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756327Ab0ECARE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 20:17:04 -0400
Received: from forward1.smtp.messagingengine.com ([66.111.4.223]:35147 "EHLO
	forward1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754959Ab0ECARA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 20:17:00 -0400
Received: from launde (vpn58.internal [10.203.0.58])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AEDF8F0D87;
	Sun,  2 May 2010 20:16:56 -0400 (EDT)
Received: by launde (Postfix, from userid 1000)
	id CBFE940BD9; Mon,  3 May 2010 09:40:58 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <vpqpr1euy7e.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146208>

On Sun, May 02, 2010 at 05:20:53PM +0200, Matthieu Moy wrote:
> Bron Gondwana <brong@brong.net> writes:
> 
> > And a graphical/
> > ncurses interface like the kernel's "make menuconfig" at
> > the very least would make it much easier than paging
> > through piles of diff fragments and hoping you never
> > made a mistake.
> 
> About the "never made a mistake" part, if you mistakenly add a hunk
> with "git add -p", then "git reset -p" (in recent enough Git's) is
> your friend.

Ooh, that's probably the bit that I was missing :)  Excellent.  I'll
have a play and see how the workflow feels.

Thanks,

Bron.
