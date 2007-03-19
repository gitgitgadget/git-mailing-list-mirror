From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: any info getting a birdview of Git and its test suite?
Date: Mon, 19 Mar 2007 13:34:04 -0400
Message-ID: <20070319173404.GB29272@fieldses.org>
References: <3b051c1a0703180043n1dec45by90e5cee3393d2b4d@mail.gmail.com> <Pine.LNX.4.63.0703190120270.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200703191152.07686.andyparkins@gmail.com> <Pine.LNX.4.63.0703191517320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	F <ff.pptux@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 19 18:34:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTLkJ-0006q7-V5
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 18:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966042AbXCSReK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 13:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966047AbXCSReK
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 13:34:10 -0400
Received: from mail.fieldses.org ([66.93.2.214]:55250 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966042AbXCSReJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 13:34:09 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HTLkC-0008AG-MW; Mon, 19 Mar 2007 13:34:04 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703191517320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42648>

On Mon, Mar 19, 2007 at 03:18:21PM +0100, Johannes Schindelin wrote:
> 
> On Mon, 19 Mar 2007, Andy Parkins wrote:
> > Can I suggest that this should be a wiki page or even 
> > Documentation/developer-tutorial.txt?
> 
> List?
> 
> I'll make the patch, or the copy & paste...

I've had this vague plan to suck more of the documentation into the user
manual: the advantage is you get an automatic table of contents that
way, and eventually maybe an index, so hopefully stuff is more findable.

So maybe consider adding this as a chapter 9, called something like
"Understanding Git's Source Code", with the "lessons" as subsections?

It stretches the definition of the "user" in "user manual" a bit, but I
kinda like that.

--b.
