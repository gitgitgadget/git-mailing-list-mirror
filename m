From: Junio C Hamano <junkio@cox.net>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 12:09:25 -0700
Message-ID: <7vodxpc1wa.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
	<Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>
	<44713BE4.9040505@gentoo.org>
	<Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
	<46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	<Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
	<46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	<Pine.LNX.4.64.0605221013020.3697@g5.osdl.org>
	<e4stna$o1g$1@sea.gmane.org>
	<Pine.LNX.4.64.0605221055270.3697@g5.osdl.org>
	<E1FiFgL-0003m6-Eb@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 21:09:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiFmb-0005LY-3L
	for gcvg-git@gmane.org; Mon, 22 May 2006 21:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWEVTJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 15:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWEVTJ1
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 15:09:27 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:25238 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750969AbWEVTJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 15:09:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060522190926.ZWRS5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 May 2006 15:09:26 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FiFgL-0003m6-Eb@moooo.ath.cx> (Matthias Lederhofer's message
	of "Mon, 22 May 2006 21:03:09 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20520>

Matthias Lederhofer <matled@gmx.net> writes:

> ...  Is there any way to
> delete unnecessary packs (those which would repack -a -d delete)?
> Making it possible to do a git repack -a and delete those packs the
> next night?

pack-redundant is supposed to figure it out, but I have never
used it myself so your mileage may vary.
