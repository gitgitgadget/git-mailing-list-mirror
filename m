From: Christian Meder <chris@absolutegiganten.org>
Subject: Re: First web interface and service API draft
Date: Fri, 22 Apr 2005 15:30:26 +0200
Message-ID: <1114176626.3233.44.camel@localhost>
References: <1114166517.3233.4.camel@localhost>
	 <2cfc4032050422043419b578cd@mail.gmail.com>
	 <20050422121059.GB7173@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:27:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOyAp-00051i-Rn
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 15:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVDVNal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 09:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVDVNal
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 09:30:41 -0400
Received: from shadow.prohost.de ([216.71.84.228]:7299 "EHLO shadow.prohost.de")
	by vger.kernel.org with ESMTP id S261434AbVDVNae (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 09:30:34 -0400
Received: from blue.office.onestepahead.de (h-62.96.100.62.host.de.colt.net [62.96.100.62] (may be forged))
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j3MDUSf19702;
	Fri, 22 Apr 2005 15:30:28 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050422121059.GB7173@pasky.ji.cz>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-22 at 14:10 +0200, Petr Baudis wrote:
> Dear diary, on Fri, Apr 22, 2005 at 01:34:45PM CEST, I got a letter
> where Jon Seymour <jon.seymour@gmail.com> told me that...
> > On 4/22/05, Christian Meder <chris@absolutegiganten.org> wrote:
> > >
> > > Comments ? Ideas ? Other feedback ?
> > > 
> > 
> > I'd suggest serving XML rather than HTML and using client side XSLT to
> > transform it into HTML. Client-side XSLT works well in IE 6 and all
> > versions of Firefox, so there is no question that it is a mature
> > technology. Provide a fall back via server transformed HTML if need
> > be, but that is trivial to do once you have the client-side XSLT
> > stylesheets.
> > 
> > Serving XML is as easy as serving HTML and gives you a much more
> > flexible outcome.
> 
> Why "rather than"? Why not "in addition to"?
> 
> You just append either .html or .xml, based on what you want.

I agree with Petr. I think we should do both.



				Christian
-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

