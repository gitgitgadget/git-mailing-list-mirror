From: Petr Baudis <pasky@ucw.cz>
Subject: Re: First web interface and service API draft
Date: Fri, 22 Apr 2005 14:10:59 +0200
Message-ID: <20050422121059.GB7173@pasky.ji.cz>
References: <1114166517.3233.4.camel@localhost> <2cfc4032050422043419b578cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Meder <chris@absolutegiganten.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 14:07:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOwvc-0001Zz-Ia
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 14:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVDVMLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 08:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVDVMLG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 08:11:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50071 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262033AbVDVMLA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 08:11:00 -0400
Received: (qmail 10369 invoked by uid 2001); 22 Apr 2005 12:10:59 -0000
To: Jon Seymour <jon.seymour@gmail.com>
Content-Disposition: inline
In-Reply-To: <2cfc4032050422043419b578cd@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 01:34:45PM CEST, I got a letter
where Jon Seymour <jon.seymour@gmail.com> told me that...
> On 4/22/05, Christian Meder <chris@absolutegiganten.org> wrote:
> >
> > Comments ? Ideas ? Other feedback ?
> > 
> 
> I'd suggest serving XML rather than HTML and using client side XSLT to
> transform it into HTML. Client-side XSLT works well in IE 6 and all
> versions of Firefox, so there is no question that it is a mature
> technology. Provide a fall back via server transformed HTML if need
> be, but that is trivial to do once you have the client-side XSLT
> stylesheets.
> 
> Serving XML is as easy as serving HTML and gives you a much more
> flexible outcome.

Why "rather than"? Why not "in addition to"?

You just append either .html or .xml, based on what you want.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
