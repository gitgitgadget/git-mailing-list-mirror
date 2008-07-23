From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: RFC: git rebase -i and root commits
Date: Wed, 23 Jul 2008 04:02:32 +0200
Message-ID: <20080723020232.GF5904@leksak.fem-net>
References: <loom.20080723T013019-412@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 04:03:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLTha-0006lS-7j
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 04:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbYGWCCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 22:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752972AbYGWCCi
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 22:02:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:39211 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752275AbYGWCCi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 22:02:38 -0400
Received: (qmail invoked by alias); 23 Jul 2008 02:02:36 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp055) with SMTP; 23 Jul 2008 04:02:36 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18cj0kfS+ccqwzrakQfJL2GWrGaSG0SU3LMY/Xp3+
	7SUh/giwIce2ho
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KLTgW-0005ja-P1; Wed, 23 Jul 2008 04:02:32 +0200
Content-Disposition: inline
In-Reply-To: <loom.20080723T013019-412@post.gmane.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89598>

Hi,

Eric Raible wrote:
> My normal workflow is to create a .gitignore in my initial commit.
> 
> When I later realize that I've forgotten something from that file
> I could of course just commit the changes, but I'd rather use "git rebase -i"
> in the normal way to make myself appear smarter than I am.
> Especially since this realization usually comes early on
> (and certainly before publishing).
> 
> But rebase can't go all the way to a root ("fatal: Needed a single revision").

I think this has been fixed recently.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
