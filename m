From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] cvs-migration documentation update
Date: Mon, 30 Jan 2006 22:40:37 -0500
Message-ID: <20060131034036.GA17585@fieldses.org>
References: <20060129043147.GA9581@fieldses.org> <7virs13x1i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 04:40:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3mO0-00011U-7y
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 04:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWAaDkk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 22:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWAaDkj
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 22:40:39 -0500
Received: from mail.fieldses.org ([66.93.2.214]:31428 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1030304AbWAaDki (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 22:40:38 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F3mNh-0004iu-2N; Mon, 30 Jan 2006 22:40:37 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virs13x1i.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15299>

On Mon, Jan 30, 2006 at 07:18:17PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > Here's some changes to the cvs-migration.txt.  As usual, in my attempt
> > to make things clearer someone may have found I've made them less so, or
> > I may have just gotten something wrong; so any review is welcomed.
> 
> Again, thanks for doing this.

Hey, it's fun.

> > -..., and the
> > -first step to recovery is admitting you have a problem. The fact that
> > -you are reading this file means that you may be well on that path
> > -already.
> > -
> > -The thing about CVS is that it absolutely sucks...
> > -
> > -One particular suckage of CVS is very hard to work around: CVS is...
> 
> Somehow I miss the above two paragraphs and a half ;-).

Hah.  Yes, understood.  But I figured a reader trying to migrate away
from CVS is more painfully aware of the above than anyone, so better to
just get out of their way and let them get on with it....

> But listing the differences as bullet points as you did makes
> things much clearer.  I like it.

OK!  Good.

> > +If some else has updated the repository more recently, `git push`, like
> 
> some else?

Whoops, thanks for noticing, should be "someone", obviously.

Let me know if you'd like a revised patch.--b.
