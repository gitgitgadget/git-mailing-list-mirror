From: Petr Baudis <pasky@suse.cz>
Subject: Re: cogito clone, invalid cross-dev links
Date: Tue, 12 Jul 2005 02:25:27 +0200
Message-ID: <20050712002527.GC5981@pasky.ji.cz>
References: <20050711204445.GA16191@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 02:26:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds8bp-0002i0-LW
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 02:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVGLAZ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 20:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVGLAZ4
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 20:25:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:657 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262346AbVGLAZd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 20:25:33 -0400
Received: (qmail 18403 invoked by uid 2001); 12 Jul 2005 00:25:27 -0000
To: Marc Singer <elf@buici.com>
Content-Disposition: inline
In-Reply-To: <20050711204445.GA16191@buici.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Jul 11, 2005 at 10:44:45PM CEST, I got a letter
where Marc Singer <elf@buici.com> told me that...
> It complained when I cloned across devices.  
> 
>   `/git/cogito/.git/refs/tags/cogito-0.8' -> `.git/refs/tags/cogito-0.8'
>   cp: cannot create link `.git/refs/tags/cogito-0.8': Invalid cross-device link
>   `/git/cogito/.git/refs/tags/cogito-0.9' -> `.git/refs/tags/cogito-0.9'
>   cp: cannot create link `.git/refs/tags/cogito-0.9': Invalid cross-device link
> 
> and so on.  Is this a problem?

Small problem, yes - fixed now. Thanks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
