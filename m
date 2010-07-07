From: Yann Dirson <ydirson@free.fr>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Wed, 7 Jul 2010 09:18:55 +0000 (UTC)
Message-ID: <loom.20100707T105938-93@post.gmane.org>
References: <201007032158.57700.jnareb@gmail.com> <AANLkTilD8N6rnj9e3KzRB7_q3J0I4cJGx5EduX_UJScC@mail.gmail.com> <201007041013.40563.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 13:55:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWTDe-0005uA-0z
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 13:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997Ab0GGLzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 07:55:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:42880 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394Ab0GGLzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 07:55:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OWTDT-0005lc-3u
	for git@vger.kernel.org; Wed, 07 Jul 2010 13:55:03 +0200
Received: from host.1.68.26.195.rev.coltfrance.com ([host.1.68.26.195.rev.coltfrance.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 13:55:03 +0200
Received: from ydirson by host.1.68.26.195.rev.coltfrance.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 13:55:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.68.26.1 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.4) Gecko/20100628 Iceweasel/3.6.4 (like Firefox/3.6.4))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150465>

Jakub Narebski <jnareb <at> gmail.com> writes:
> === xx. Have you found distributed version control easy? ===
> (multiple choice)
> 
>  + Very easy
>  + Easy
>  + Reasonably easy
>  + Hard
>  + Very hard
> 
> Or something like that, with separate question if DVCS is difficult
> or not.
> 
> Alternatively we could ask about _relative_ ease of learning / use.
> But I don't think this would go well (and I don't think we could get
> good answers from that).

Related to that, would be whether the user was familiar with DVCS before
starting to use git, or even familiar with VCS - the answers would be different
for people for whom git is the first VCS they ever used, or for people having
used other DVCS before...

> Well, Git User's Surveys always served more or less accidentally as
> the source of information about git and git community ("we have wiki?"
> from the first survey )

Count me in for "we have git new-worktree ?" :)
In fact, I found nothing by that name in git's tree or in the wiki's
InterfacesFrontendsAndTools.  Google finally pointed me to contrib/ where I
noticed workdir/git-new-workdir.

It may be worth to use a URL for publicizing non-mainstream stuff.  That's
better as publicizing goes, and makes it easy to crowdsource discovery of
mistakes or outdated things.
