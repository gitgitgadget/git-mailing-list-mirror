From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Mon, 16 Apr 2007 14:27:49 -0400
Message-ID: <20070416182749.GG23764@fieldses.org>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org> <20070416181352.GB29569@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 20:27:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdVvi-0004BQ-VU
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 20:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbXDPS1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 14:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180AbXDPS1w
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 14:27:52 -0400
Received: from mail.fieldses.org ([66.93.2.214]:48921 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154AbXDPS1v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 14:27:51 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdVvZ-0001dh-Uo; Mon, 16 Apr 2007 14:27:49 -0400
Content-Disposition: inline
In-Reply-To: <20070416181352.GB29569@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44684>

On Mon, Apr 16, 2007 at 08:13:52PM +0200, Peter Baumann wrote:
> I'll do this gitk jump very often, too. Just to get the big picture where my
> branches are (inside the commit graph). As they stay normaly on the tip, I
> exit gitk long before it reached the root commit. What I'd like to have is
> something which shows me _visually_ the the branches, e.g.
> 
> master
> | next			commit comment for next
> o  |		commit comment for master~1
> |  o			commit comment for next~1
> o  |	[ ... guess whats next :-)		you get the idea ...]
> |  o
> |  |
> o /
> |

git show-branch?

--b.
