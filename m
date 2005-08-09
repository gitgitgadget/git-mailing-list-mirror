From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb - feature request
Date: Tue, 9 Aug 2005 23:14:02 +0200
Message-ID: <20050809211402.GA21194@vrfy.org>
References: <20050809193104.GA10858@mars.ravnborg.org> <20050809195818.GA19284@vrfy.org> <20050809201836.GA11051@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 23:15:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2bQG-0000WB-1f
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 23:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVHIVOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 17:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVHIVOE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 17:14:04 -0400
Received: from soundwarez.org ([217.160.171.123]:38330 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S964974AbVHIVOD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 17:14:03 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 412343C3C2; Tue,  9 Aug 2005 23:14:02 +0200 (CEST)
To: Sam Ravnborg <sam@ravnborg.org>
Content-Disposition: inline
In-Reply-To: <20050809201836.GA11051@mars.ravnborg.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 09, 2005 at 10:18:36PM +0200, Sam Ravnborg wrote:
> On Tue, Aug 09, 2005 at 09:58:18PM +0200, Kay Sievers wrote:
> > On Tue, Aug 09, 2005 at 09:31:04PM +0200, Sam Ravnborg wrote:
> > > Hi Kay.
> > > 
> > > When browsing http://www.kernel.org/git I often find myself looking for
> > > the most recently changed tree.
> > > For this it is very good that you have the "last change" in italic and
> > > bolded if newer than a few hours (I think).
> > 
> > Hmm, if last change is "minutes" it's bold, if it's "hours" old it's green.
> > What do you miss?
> For this part I do not miss anything - the opposite actually. I like
> this highlighting you do.
> 
> > 
> > > A nice additional feature would be the possibility to sort the output
> > > according to last change, owner and description.
> > > Using a click-able table heading would be the most intuitive way.
> > > 
> > > I have not looked into the source for gitweb, so I really do not know
> > > how difficult this would be.
> > 
> > I was hoping people that want stuff like this would use a RSS reader. :)
> Some day I will try to use such a beast...

Well, I don't use these beasts myself. :) I will try the sorting with the
next round - sounds like a nice feature.

Kay
