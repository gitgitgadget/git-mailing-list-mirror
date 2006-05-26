From: Junio C Hamano <junkio@cox.net>
Subject: Re: t8001-annotate.sh fails on Mac OS X
Date: Thu, 25 May 2006 20:02:45 -0700
Message-ID: <7vpsi1qyi2.fsf@assigned-by-dhcp.cox.net>
References: <f3d7535d0605251653m15db34f3j46403f4ed0c4c69f@mail.gmail.com>
	<20060526011153.GA27720@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 05:02:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjSbC-0005Qr-55
	for gcvg-git@gmane.org; Fri, 26 May 2006 05:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWEZDCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 23:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWEZDCr
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 23:02:47 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:56236 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030221AbWEZDCq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 23:02:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060526030246.ETMB27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 23:02:46 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060526011153.GA27720@spearce.org> (Shawn Pearce's message of
	"Thu, 25 May 2006 21:11:53 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20782>

Shawn Pearce <spearce@spearce.org> writes:

> I think we had hoped that one of the two tools would prove to be
> _the_ annotation/blame tool and would get used but thus far that
> hasn't happened.

I've been taking this as an indication that annotate/blame does
not actually matter in the real world.

Or git is not yet used in the real world.  Or perhaps a bit of
both.
