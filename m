From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetch per-repository speed issues
Date: Tue, 04 Jul 2006 14:05:32 -0700
Message-ID: <7vfyhhgjxf.fsf@assigned-by-dhcp.cox.net>
References: <1151949764.4723.51.camel@neko.keithp.com>
	<e8e28j$v8v$1@sea.gmane.org> <7vk66tgt6n.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607041219540.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 23:05:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxs5R-0004S9-0b
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 23:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWGDVFe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 17:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWGDVFe
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 17:05:34 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:62905 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932398AbWGDVFd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 17:05:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704210533.DJVU8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 17:05:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607041219540.12404@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 4 Jul 2006 12:22:05 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23315>

Linus Torvalds <torvalds@osdl.org> writes:

> But I have to say that the diffstat at least for me is absolutely 
> invaluable.

Oh, I absolutely agree with that and somebody who suggests to
turn it off by default needs a very good argument to convince
me.
