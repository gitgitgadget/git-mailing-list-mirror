From: Mark Burton <markb@ordern.com>
Subject: Re: [PATCH] git-rebase.txt: Mention that --whitespace cannot be
 used with interactive rebase.
Date: Thu, 12 Feb 2009 11:32:52 +0000
Organization: Order N Ltd.
Message-ID: <20090212113252.26b9788f@crow>
References: <20090212102119.1de19087@crow>
	<alpine.DEB.1.00.0902121156550.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:34:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXZpm-0003tO-SA
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 12:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349AbZBLLc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 06:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbZBLLcz
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 06:32:55 -0500
Received: from c2beaomr08.btconnect.com ([213.123.26.186]:10162 "EHLO
	c2beaomr08.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbZBLLcy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 06:32:54 -0500
Received: from crow.ordern.com (host86-128-142-98.range86-128.btcentralplus.com [86.128.142.98])
	by c2beaomr08.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id BUX58375;
	Thu, 12 Feb 2009 11:32:52 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 91C30190DC5;
	Thu, 12 Feb 2009 11:32:52 +0000 (GMT)
In-Reply-To: <alpine.DEB.1.00.0902121156550.10279@pacific.mpi-cbg.de>
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr08.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0207.499408E5.001F,ss=1,fgs=0,
	ip=86.128.142.98,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109606>


On Thu, 12 Feb 2009 11:58:25 +0100 (CET)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Thu, 12 Feb 2009, Mark Burton wrote:
> 
> > 
> > Signed-off-by: Mark Burton <markb@ordern.com>
> > ---
> 
> Because it was not mentioned in the commit message, I only realized after 
> writing a patch that rebase -i --whitespace already errors out.
> 
> Would be nice to have important information like that (I mean that it is 
> already handled, not that I was stupid enough to write the patch) in the 
> commit message, don't you agree?

Actually, no.

I am very glad that the git guardians are diligent and careful because
it gives me confidence that my favourite software is going to work
reliably and efficiently, etc.

However, if that diligence and attention to detail, etc. extends to the
point where a humble git user (not a developer) cannot submit a patch that
he thinks will, in some small way, improve the software, without being
quizzed, grilled or, in extreme cases, mocked or abused (it happens)
because the patch is not 100% perfect in every way, then, I am happy to
let the development process continue without my feeble contributions.

So, I left something out of the commit message, did I? Oh my gawd, I
better top myself!

Johannes, you're the worst of the pedants. Ease up man, you'll bust a
blood vessel!

Cheerio list (keep up the good work),

Mark
