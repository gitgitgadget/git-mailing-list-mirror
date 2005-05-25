From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Wed, 25 May 2005 11:48:41 +0200
Message-ID: <20050525094841.GA24172@vrfy.org>
References: <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org> <20050524202846.GC25606@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org> <20050524213102.GB19180@vrfy.org> <7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Greaves <david@dgreaves.com>
X-From: git-owner@vger.kernel.org Wed May 25 11:47:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DasU7-0002R1-HI
	for gcvg-git@gmane.org; Wed, 25 May 2005 11:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVEYJs5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 05:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVEYJs5
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 05:48:57 -0400
Received: from soundwarez.org ([217.160.171.123]:57493 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262024AbVEYJsq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 05:48:46 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id E37C439ABB; Wed, 25 May 2005 11:48:41 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2005 at 07:23:39PM -0700, Junio C Hamano wrote:
> I was browsing www.kernel.org/git and noticed that it shows
> only files that exist at the tip.  How do I get history of a
> file that does not exist anymore at the tip?
> 
> For example, diff-helper.c history is (quite correctly)
> truncated somewhere close to where diff-tree-helper.c was
> renamed to it.  From the commit log, humans can easily tell that
> it used to be called diff-tree-helper.c.  I could not find an
> easy way to see the history of diff-tree-helper.c file.

I will add a search function when the git binaries on kernel.org get an
update. Currently it's cogito-0.10.

> On probably a bit different topic (but I do not know who is
> updating the copy on www.kernel.org, sorry).  Could somebody
> update http://www.kernel.org/pub/software/scm/git/docs/ to
> rename git-diff-tree-helper to git-diff-helper please?
> git.git/Documentation/git.txt has been corrected quite some
> time ago [*1*] and I do not know how the updates are propagated
> to the web version of the documentation; is it a manual process?

David Greaves can write to that directory. David?

Kay
