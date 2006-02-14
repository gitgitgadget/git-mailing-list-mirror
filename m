From: Junio C Hamano <junkio@cox.net>
Subject: Re: Quick question
Date: Mon, 13 Feb 2006 23:52:18 -0800
Message-ID: <7voe1atm19.fsf@assigned-by-dhcp.cox.net>
References: <43F0B577.4070608@gorzow.mm.pl>
	<Pine.LNX.4.64.0602130848220.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
X-From: git-owner@vger.kernel.org Tue Feb 14 08:52:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8uzK-0001Ix-Vj
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 08:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbWBNHwV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 02:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWBNHwU
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 02:52:20 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:14572 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030408AbWBNHwU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 02:52:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214075048.ZBXQ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 02:50:48 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602130848220.3691@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 13 Feb 2006 08:54:31 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16127>

Linus Torvalds <torvalds@osdl.org> writes:

> Which is admittedly insane. You don't want to exclude directories. Or 
> maybe you do, but then we should add the "/" to the end before we do the 
> exclusion.
>
> This patch (untested) will never exclude directories. Which may or may not 
> be the right thing. 
>
> Junio? Others? Comments?
>
> 		Linus

I might have sounded negative or happy with status quo in my
earlier messages but that was not intended.  I am swamped and
have not formed an opinion.
