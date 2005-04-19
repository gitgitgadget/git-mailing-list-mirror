From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] provide better committer information to commit-tree.c
Date: Tue, 19 Apr 2005 09:18:33 +0100
Message-ID: <20050419091833.C13488@flint.arm.linux.org.uk>
References: <20050419001126.GB21170@kroah.com> <Pine.LNX.4.58.0504181730130.15725@ppc970.osdl.org> <20050419004548.GA21623@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 10:15:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNnsR-0007Gj-UO
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 10:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVDSISk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 04:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVDSISk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 04:18:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23564 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261399AbVDSISi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 04:18:38 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNnwJ-0001ck-BZ; Tue, 19 Apr 2005 09:18:35 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNnwI-0003xE-1S; Tue, 19 Apr 2005 09:18:34 +0100
To: Greg KH <greg@kroah.com>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050419004548.GA21623@kroah.com>; from greg@kroah.com on Mon, Apr 18, 2005 at 05:45:48PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2005 at 05:45:48PM -0700, Greg KH wrote:
> On Mon, Apr 18, 2005 at 05:31:16PM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Mon, 18 Apr 2005, Greg KH wrote:
> > >
> > > Here's a small patch to commit-tree.c that does two things:
> > 
> > Gaah, I really was hoping that people wouldn't feel like they have to lie 
> > about their committer information.
> > 
> > I guess we don't have much choice, but I'm not happy about it.
> 
> Well Russell has stated that he has to for EU Privacy reasons.

That's author information, not committer information.  For my committing
purposes, I'm going to be the one doing the commit, and I'm unlikely to
issue a suit on myself for spreading my own personal information.

-- 
Russell King

