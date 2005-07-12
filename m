From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] remove Obsoletes from cogito.spec.in
Date: Tue, 12 Jul 2005 09:30:22 +0200
Message-ID: <20050712073022.GB6363@pasky.ji.cz>
References: <20050712003345.GO19052@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 09:31:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsFE0-0006LC-HX
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 09:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVGLHa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 03:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVGLHa2
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 03:30:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25238 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261242AbVGLHaY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 03:30:24 -0400
Received: (qmail 7485 invoked by uid 2001); 12 Jul 2005 07:30:22 -0000
To: Chris Wright <chrisw@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050712003345.GO19052@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Jul 12, 2005 at 02:33:45AM CEST, I got a letter
where Chris Wright <chrisw@osdl.org> told me that...
> This is leftover from early naming, and is no longer relevant.
> 
> Signed-off-by: Chris Wright <chrisw@osdl.org>

Thanks, applied. BTW, Josh Boyer of Fedora suggested having the

	Provides: git

line in cogito.spec.in as long as it comes with git bundled (which will
be so until git stabilizes, doesn't break backwards compatibility once
in a while, and gets into some regular and reasonably frequent release
cycle). What do you think?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
