From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mtimes of working files
Date: Fri, 13 Jul 2007 16:18:03 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707131617270.20061@woody.linux-foundation.org>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com> 
 <Pine.LNX.4.64.0707111940080.4516@racer.site>  <20070711202615.GE3069@efreet.light.src>
  <200707120857.53090.andyparkins@gmail.com>  <1184261246.31598.139.camel@pmac.infradead.org>
  <20070713003700.GA21304@thunk.org>
 <1184367619.2785.58.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 01:18:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9UP7-0003GH-Af
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 01:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbXGMXSZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 19:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757829AbXGMXSZ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 19:18:25 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57291 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755194AbXGMXSY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jul 2007 19:18:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6DNI9Ks026515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 13 Jul 2007 16:18:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6DNI30N027837;
	Fri, 13 Jul 2007 16:18:03 -0700
In-Reply-To: <1184367619.2785.58.camel@shinybook.infradead.org>
X-Spam-Status: No, hits=-2.609 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52422>



On Sat, 14 Jul 2007, David Woodhouse wrote:
> 
> Branches just seem like a source of complexity and hence pain. Using git
> was just starting to become sensible for newbies, and now when people
> are forced to deal with multiple branches it's all horribly painful
> again.

Why would anybody force you to do that?

The "switch between branchs in the same repo" is really convenient. But 
nobody *forces* you to do it.

			Linus
