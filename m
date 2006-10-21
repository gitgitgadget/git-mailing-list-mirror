From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] GIT 1.4.3
Date: Sat, 21 Oct 2006 02:22:51 +0200
Message-ID: <20061021002251.GO20017@pasky.or.cz>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 02:23:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb4dd-00017Z-N2
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 02:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992741AbWJUAWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 20:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWJUAWy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 20:22:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59096 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030205AbWJUAWx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 20:22:53 -0400
Received: (qmail 28093 invoked by uid 2001); 21 Oct 2006 02:22:51 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29564>

> That said, "LESS=FRS" doesn't really help that much. It still clears the 
> screen. Using "LESS=FRSX" fixes that, but the alternate display sequence 
> is actually nice _if_ the pager is used.

Hmm, what terminal emulator do you use? The reasonable ones should
restore the original screen. At least xterm does, and I *think*
gnome-terminal does too (although I'm too lazy to boot up my notebook
and confirm).

(I personally consider alternate screen an abomination. It would be so
nice if the terminal emulators would just make it optional.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
