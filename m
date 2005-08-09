From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: gitweb - feature request
Date: Tue, 9 Aug 2005 22:18:36 +0200
Message-ID: <20050809201836.GA11051@mars.ravnborg.org>
References: <20050809193104.GA10858@mars.ravnborg.org> <20050809195818.GA19284@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 22:17:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2aWL-00022v-Lz
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 22:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVHIUPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 16:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbVHIUPz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 16:15:55 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:43619 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S964925AbVHIUPy
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 16:15:54 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepa.post.tele.dk (Postfix) with ESMTP id 7D01A47FF05;
	Tue,  9 Aug 2005 22:15:53 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 63CD36AC01D; Tue,  9 Aug 2005 22:18:36 +0200 (CEST)
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <20050809195818.GA19284@vrfy.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 09, 2005 at 09:58:18PM +0200, Kay Sievers wrote:
> On Tue, Aug 09, 2005 at 09:31:04PM +0200, Sam Ravnborg wrote:
> > Hi Kay.
> > 
> > When browsing http://www.kernel.org/git I often find myself looking for
> > the most recently changed tree.
> > For this it is very good that you have the "last change" in italic and
> > bolded if newer than a few hours (I think).
> 
> Hmm, if last change is "minutes" it's bold, if it's "hours" old it's green.
> What do you miss?
For this part I do not miss anything - the opposite actually. I like
this highlighting you do.

> 
> > A nice additional feature would be the possibility to sort the output
> > according to last change, owner and description.
> > Using a click-able table heading would be the most intuitive way.
> > 
> > I have not looked into the source for gitweb, so I really do not know
> > how difficult this would be.
> 
> I was hoping people that want stuff like this would use a RSS reader. :)
Some day I will try to use such a beast...

	Sam
