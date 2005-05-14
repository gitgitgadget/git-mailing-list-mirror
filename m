From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rename tracking
Date: Sat, 14 May 2005 09:05:30 -0700
Message-ID: <7v4qd523p1.fsf@assigned-by-dhcp.cox.net>
References: <7vk6m260xf.fsf@assigned-by-dhcp.cox.net>
	<20050514151159.GL3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 18:06:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWz95-0008TB-Is
	for gcvg-git@gmane.org; Sat, 14 May 2005 18:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVENQFk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 12:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVENQFj
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 12:05:39 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:34299 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261433AbVENQFe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 12:05:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514160531.KZIR22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 May 2005 12:05:31 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050514151159.GL3905@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 14 May 2005 17:11:59 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> I'll postpone it for another while since there is still some discussion
PB> about tuning the output.

What discussion did I miss???

PB> I'm thinking about using "\n---\n\n" in commit message to separate some
PB> "internal data" like this. cg-log (and web interfaces and other
PB> toolkits, if we get to agree on something common) could then by default
PB> hide it. Below it would contain something which we could hopefully embed
PB> in patches too (actually less work for extracting patches by cg-mkpatch
PB> or similar tools). What do you think?

Since I have not been particularly interested in rename tracking
(because I myself personally have not felt the need for it), I
do not offhand have much idea worth to offer.  Sorry.

