From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 02:36:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610170233110.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
 <200610170155.10536.jnareb@gmail.com> <Pine.LNX.4.63.0610170157270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0610161714590.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 02:37:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZcwH-0004gX-4Q
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 02:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422988AbWJQAgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 20:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422989AbWJQAgJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 20:36:09 -0400
Received: from mail.gmx.de ([213.165.64.20]:53681 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422988AbWJQAgH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 20:36:07 -0400
Received: (qmail invoked by alias); 17 Oct 2006 00:36:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 17 Oct 2006 02:36:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610161714590.3962@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29008>

Hi,

On Mon, 16 Oct 2006, Linus Torvalds wrote:

> On Tue, 17 Oct 2006, Johannes Schindelin wrote:
> 
> > (How about making git-cat be a short cuut to "git -p cat-file -p"?)
> 
> Well, you can just add
> 
> 	[alias]
> 		cat=-p cat-file -p
> 
> to your ~/.gitconfig file, and you're there.

Ha! I have that for a long time! Although I named it "s", since "git s 
todo:TODO" is two letters shorter...

Ciao,
Dscho

P.S.: BTW a certain person complained about ~/.gitconfig not being 
documented, but evidently the itch was not big enough for that person to 
document it himself...
