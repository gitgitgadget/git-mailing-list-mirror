From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Wed, 2 Nov 2005 01:26:31 +0100
Message-ID: <20051102002631.GA18529@vrfy.org>
References: <20051027203945.GC1622@pe.Belkin> <20051028015642.GA31822@vrfy.org> <20051028023833.GA19939@pe.Belkin> <20051101233035.GB1431@pasky.or.cz> <46a038f90511011533q177328fdrf4b0dd68f188282e@mail.gmail.com> <20051102001206.GA21671@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 01:27:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6Sf-0002En-FL
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 01:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbVKBA0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 19:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbVKBA0i
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 19:26:38 -0500
Received: from soundwarez.org ([217.160.171.123]:954 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751475AbVKBA0i (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 19:26:38 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id 3BBFB6BFEE; Wed,  2 Nov 2005 01:26:31 +0100 (CET)
To: Chris Shoemaker <c.shoemaker@cox.net>
Content-Disposition: inline
In-Reply-To: <20051102001206.GA21671@pe.Belkin>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10980>

On Tue, Nov 01, 2005 at 07:12:06PM -0500, Chris Shoemaker wrote:
> On Wed, Nov 02, 2005 at 12:33:38PM +1300, Martin Langhoff wrote:
> > On 11/2/05, Petr Baudis <pasky@suse.cz> wrote:
> > > What about having the color indicate the number of affected files (let's
> > > say on a blue..red scale) and the width the size of patch?
> > 
> > I'm a /little bit/ colour blind on the red scale -- so I vote for 2
> > bars, each half the heigth of the current bar.  ;-)
> 
> I was going to use two bars for add vs. delete, but this could work,
> too.  I'm intending on getting back to this ASAP, but for now my
> cvsimport problems are higher priority (see other post).

Guys, I'm not convinced, that we should make gitweb look like Konqueror. :)

Kay
