From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito-0.12: problem with local clone
Date: Tue, 12 Jul 2005 02:32:55 +0200
Message-ID: <20050712003255.GD5981@pasky.ji.cz>
References: <20050707230055.25D3B353A8B@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 02:36:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds8lC-00052L-U2
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 02:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVGLAf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 20:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVGLAdq
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 20:33:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9361 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262307AbVGLAc4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 20:32:56 -0400
Received: (qmail 18986 invoked by uid 2001); 12 Jul 2005 00:32:55 -0000
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20050707230055.25D3B353A8B@atlas.denx.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 08, 2005 at 01:00:55AM CEST, I got a letter
where Wolfgang Denk <wd@denx.de> told me that...
> Hello,

Hello,

> I have problems with Cogito-0.12 when trying to clone a "local" tree:

sorry for the late reply.

> When I try to create a local clone I get lots of error messages:

Yes, Cogito did not handle cross-filesystem local pulls correctly.
Should be fixed now.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
