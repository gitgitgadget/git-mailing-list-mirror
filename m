From: Petr Baudis <pasky@suse.cz>
Subject: Re: ./configure script prototype
Date: Mon, 14 Nov 2005 14:29:56 +0100
Message-ID: <20051114132956.GT30496@pasky.or.cz>
References: <43788078.4040403@op5.se> <437880AC.3040101@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 14:32:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbePN-0005YT-JA
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 14:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVKNN37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 08:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVKNN37
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 08:29:59 -0500
Received: from w241.dkm.cz ([62.24.88.241]:21710 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751119AbVKNN37 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 08:29:59 -0500
Received: (qmail 7233 invoked by uid 2001); 14 Nov 2005 14:29:56 +0100
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <437880AC.3040101@op5.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11796>

Dear diary, on Mon, Nov 14, 2005 at 01:18:52PM CET, I got a letter
where Andreas Ericsson <ae@op5.se> said that...
> 		--prefix=*)
> 			prefix=${1##*=}

Aren't those heavy bashisms?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
