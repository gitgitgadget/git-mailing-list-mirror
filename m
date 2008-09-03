From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Wed, 3 Sep 2008 19:56:51 +0200
Message-ID: <20080903175651.GZ10360@machine.or.cz>
References: <20080826171012.GO10360@machine.or.cz> <20080826171144.21328.82727.stgit@localhost> <m3y72jr80w.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, andi@firstfloor.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:59:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KawcD-0005BX-Fr
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbYICR4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbYICR4y
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:56:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59260 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048AbYICR4x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:56:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 781B13939B56; Wed,  3 Sep 2008 19:56:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3y72jr80w.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94828>

On Tue, Aug 26, 2008 at 10:38:45AM -0700, Jakub Narebski wrote:
> Petr Baudis <pasky@suse.cz> writes:
> > +		count-objects)    : plumbing;;
> 
> Plumbing (hyphenated name is a very good hint), but useful to decide
> when to repack. I'm partially to leaving it, as I use it from time to
> time from CLI.

Is this just residuum of customs developed before auto-gc was
introduced?

> > +		ls-files)         : plumbing;;
> 
> IIRC it doesn't have porcelain equivalent.

git status for the generally end-user-interesting functionality.

				Petr "Pasky" Baudis
