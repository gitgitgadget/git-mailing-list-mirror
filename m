From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] tagger id
Date: Tue, 12 Jul 2005 17:14:20 +0200
Message-ID: <20050712151420.GC15794@pasky.ji.cz>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org> <m1eka574c8.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507110958400.17536@g5.osdl.org> <m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507111815180.17536@g5.osdl.org> <m1slyk63k2.fsf_-_@ebiederm.dsl.xmission.com> <m18y0c1prv.fsf@ebiederm.dsl.xmission.com> <7veka48lcw.fsf@assigned-by-dhcp.cox.net> <m14qb012x4.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 17:19:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsMWk-0002wk-MQ
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 17:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVGLPR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 11:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVGLPPZ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 11:15:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61085 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261516AbVGLPOV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 11:14:21 -0400
Received: (qmail 31087 invoked by uid 2001); 12 Jul 2005 15:14:20 -0000
To: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Disposition: inline
In-Reply-To: <m14qb012x4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Jul 12, 2005 at 05:04:23PM CEST, I got a letter
where "Eric W. Biederman" <ebiederm@xmission.com> told me that...
> > By the way, I do not particularly like the name "git-id".  There
> > could be IDs for different kinds (not just people) we would want
> > later (file IDs, for example).  Naming what you are computing
> > _the_ "id" feels a bit too generic.  I do not have a better
> > alternative to suggest, though.
> 
> Agreed.  Something like git-author or git-author-stamp is probably
> better.

Since that "infriges" the author/committer distinction, I would prefer
git-person-id.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
