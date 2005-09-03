From: Junio C Hamano <junkio@cox.net>
Subject: Re: Moved files and merges
Date: Sat, 03 Sep 2005 12:32:03 -0700
Message-ID: <7voe7arlqk.fsf@assigned-by-dhcp.cox.net>
References: <4318E754.9000703@zytor.com>
	<7vek87djat.fsf@assigned-by-dhcp.cox.net>
	<7vek867e29.fsf@assigned-by-dhcp.cox.net>
	<7vy86erntu.fsf@assigned-by-dhcp.cox.net>
	<20050903190500.GB8379@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 21:33:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBdkL-000379-6z
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 21:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVICTcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 15:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVICTcK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 15:32:10 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14474 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751211AbVICTcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2005 15:32:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050903193203.HIAQ7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Sep 2005 15:32:03 -0400
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050903190500.GB8379@mars.ravnborg.org> (Sam Ravnborg's message
	of "Sat, 3 Sep 2005 21:05:00 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8047>

Sam Ravnborg <sam@ravnborg.org> writes:

> As explained in another mail what we want to do is actually to
> transpose the changes made to F to the now renamed file G.
> So we end up with G containing the modifications made to F.
>
> Also we want to include the new file K.

Thanks for the clarification.  But the principles are the same.
