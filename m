From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: how to display file history?
Date: Sun, 21 May 2006 19:35:49 +0200
Message-ID: <20060521173549.GA23347@diku.dk>
References: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com> <7v64k7wzzf.fsf@assigned-by-dhcp.cox.net> <m1ejyv7077.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0605150900510.3866@g5.osdl.org> <m164k76ylb.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	"Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 19:36:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhrqQ-0007qF-FE
	for gcvg-git@gmane.org; Sun, 21 May 2006 19:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWEURfy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 13:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWEURfy
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 13:35:54 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:34946 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S964905AbWEURfy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 13:35:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 9004C770025;
	Sun, 21 May 2006 19:35:52 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27912-04; Sun, 21 May 2006 19:35:50 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 59CD1770027;
	Sun, 21 May 2006 19:35:50 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1A7C26DF893; Sun, 21 May 2006 19:32:52 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 11DC16248E; Sun, 21 May 2006 19:35:50 +0200 (CEST)
To: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Disposition: inline
In-Reply-To: <m164k76ylb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20455>

Eric W. Biederman <ebiederm@xmission.com> wrote Mon, May 15, 2006:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Mon, 15 May 2006, Eric W. Biederman wrote:
> > People still don't seem to realize how flexible (and powerful) the git 
> > revision specifications are. It's not just limiting by path, all of these 
> > work on _all_ of the "history tools" (whether they be gitk, qgit, "git 
> > log", "git whatchanged" or your own home-cooked stuff):
> >
> > [examples]
> 
> But regardless of where we put it, it needs to be documented someplace
> besides in the email so you don't need to read the code to see that
> the option is there. 

I've put some of this on http://git.or.cz/gitwiki/RevisionSpecification
that for now may serve as an introduction ...

-- 
Jonas Fonseca
