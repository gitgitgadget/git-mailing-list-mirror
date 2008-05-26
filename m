From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: [ANNOUNCE] Java Git (aka jgit) has switched to 3-clause BSD
Date: Mon, 26 May 2008 14:12:59 -0400
Message-ID: <20080526181259.GA17449@foursquare.net>
References: <20080526044640.GB30245@spearce.org> <19f34abd0805260113w1341a26bg140d1dbb7438bf46@mail.gmail.com> <alpine.DEB.1.00.0805261106470.30431@racer> <19f34abd0805260422m6d8c414dy746623ed609440eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Dave Watson <dwatson@mimvista.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org,
	laforge@gnumonks.org
To: Vegard Nossum <vegard.nossum@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 20:14:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0hD7-0006iJ-Dj
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 20:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649AbYEZSNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 14:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbYEZSNY
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 14:13:24 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:33537 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbYEZSNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 14:13:23 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4QICx4l003663;
	Mon, 26 May 2008 14:12:59 -0400
Content-Disposition: inline
In-Reply-To: <19f34abd0805260422m6d8c414dy746623ed609440eb@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.723, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00, TW_JG 0.08)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82945>

On Mon, May 26, 2008 at 01:22:25PM +0200, Vegard Nossum wrote:
> It does concern me, because I enjoy git and free software in general.
> I am not trolling or trying to stop the change of license in any way,
> but simply give a heads up to what I believe might potentially be a
> legal issue. Maybe there are in fact no other authors that have
> participated, but in that case I think it is a fact worthy of explicit
> mention.

I share your concerns about licensing and keeping things accurate when it
comes to things like changing licenses, so I took a quick look at the
bsd branch of the jgit git tree, to see if there were any glaring
omissions.

I'm not sure that git-blame is the best way to deal with this kind of task,
but in this case, it worked out well.  From my analysis of git-log output,
the lines of code from contributors who haven't explicitly consented are
maybe 10 lines.  Looks like a job well done to me.

- Chris
