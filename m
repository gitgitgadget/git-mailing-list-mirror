From: Ryan Anderson <ryan@michonline.com>
Subject: Re: t8001-annotate.sh fails on Mac OS X
Date: Fri, 26 May 2006 18:40:38 -0700
Message-ID: <20060527014037.GA11935@h4x0r5.com>
References: <f3d7535d0605251653m15db34f3j46403f4ed0c4c69f@mail.gmail.com> <20060526011153.GA27720@spearce.org> <7vpsi1qyi2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 03:41:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjnnZ-0005uF-IZ
	for gcvg-git@gmane.org; Sat, 27 May 2006 03:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWE0Bk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 21:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWE0Bk6
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 21:40:58 -0400
Received: from h4x0r5.com ([70.85.31.202]:60432 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751234AbWE0Bk5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 21:40:57 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1FjnnC-0006Rn-VS; Fri, 26 May 2006 18:40:39 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsi1qyi2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20826>

On Thu, May 25, 2006 at 08:02:45PM -0700, Junio C Hamano wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > I think we had hoped that one of the two tools would prove to be
> > _the_ annotation/blame tool and would get used but thus far that
> > hasn't happened.
> 
> I've been taking this as an indication that annotate/blame does
> not actually matter in the real world.

It probably doesn't matter in the real world.

At the moment, I'd blame annotate for being wrong, I know it does the
wrong thing on some merges, and I had a plan to try to fix it, but I got
distracted by finding a new job and moving across the country, so I
haven't really had a chance to fix it, something to look at shortly, I
hope.  (I'm having problems getting one of my machines back up, so
that's going to slow me down slightly)

> Or git is not yet used in the real world.  Or perhaps a bit of
> both.

It's just that "annotate" isn't a common operation in the communities
that Git has made it into.
