From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Tue, 1 Nov 2005 19:12:06 -0500
Message-ID: <20051102001206.GA21671@pe.Belkin>
References: <20051027203945.GC1622@pe.Belkin> <20051028015642.GA31822@vrfy.org> <20051028023833.GA19939@pe.Belkin> <20051101233035.GB1431@pasky.or.cz> <46a038f90511011533q177328fdrf4b0dd68f188282e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 01:12:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6Eu-000790-VI
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 01:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbVKBAMP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 19:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbVKBAMP
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 19:12:15 -0500
Received: from eastrmmtao05.cox.net ([68.230.240.34]:59829 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751467AbVKBAMM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 19:12:12 -0500
Received: from localhost ([24.250.31.7]) by eastrmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102001208.HOJU28234.eastrmmtao05.cox.net@localhost>;
          Tue, 1 Nov 2005 19:12:08 -0500
Received: from chris by localhost with local (Exim 4.43)
	id 1EX6EZ-0005uT-0l; Tue, 01 Nov 2005 19:12:07 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511011533q177328fdrf4b0dd68f188282e@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10975>

On Wed, Nov 02, 2005 at 12:33:38PM +1300, Martin Langhoff wrote:
> On 11/2/05, Petr Baudis <pasky@suse.cz> wrote:
> > What about having the color indicate the number of affected files (let's
> > say on a blue..red scale) and the width the size of patch?
> 
> I'm a /little bit/ colour blind on the red scale -- so I vote for 2
> bars, each half the heigth of the current bar.  ;-)

I was going to use two bars for add vs. delete, but this could work,
too.  I'm intending on getting back to this ASAP, but for now my
cvsimport problems are higher priority (see other post).

-chris

> 
> martin
