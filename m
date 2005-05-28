From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: More gitweb queries..
Date: Sun, 29 May 2005 08:43:48 +1000
Message-ID: <1117320229.5228.18.camel@gaston>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
	 <20050527235924.GB19491@vrfy.org>
	 <f0796bb705052718035cd5dbe2@mail.gmail.com>
	 <20050528084255.GA32614@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Serpell <daniel.serpell@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 00:47:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcA4k-0000MV-If
	for gcvg-git@gmane.org; Sun, 29 May 2005 00:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVE1Wsy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 18:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVE1Wsy
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 18:48:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:21401 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261183AbVE1Wsw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2005 18:48:52 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j4SMf9Zn000927;
	Sat, 28 May 2005 17:41:10 -0500
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050528084255.GA32614@vrfy.org>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-05-28 at 10:42 +0200, Kay Sievers wrote:

> You know how that stuff works? :) It is a very nice idea for
> small stuff, but it uses a <div> for every pixel/line you draw and
> places this in the background and I expect it to kill your browser if
> you try to draw things like gitk does.
> 
> > Alternatively, you could use a fixed set of little images, a bar "|", a
> > dot "o" and branches like "Y", "7" and "\". Obviously, octopus-merges
> > are very difficult to draw using only those.
> 
> Did you look at gitk? With a all the crossing and long lines, you definitely
> need to draw the lines with colors. Otherwise you will see _nothing_, but
> random characters. :)
> 
> > BTW, I tried searching on gitweb, and I think that found a problem, see:
> > http://ehlo.org/~kay/gitweb.cgi?p=git/git.git;a=search;s=check
> > At the bottom of the page, highlighting of the search term stops and the
> > commits are all the same color.
> 
> Well, you see a list of files which contain the text, not the text
> itself. I can print the filename in red. :)

Best may be to have the server generate a picture ... ?

Ben.


