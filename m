From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
 script
Date: Sat, 15 May 2010 13:51:09 +0200
Message-ID: <20100515115108.GT1951@machine.or.cz>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com>
 <201005111551.21316.jnareb@gmail.com>
 <20100513131016.GA5250@screwed.box>
 <201005141253.46956.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Vereshagin <peter@vereshagin.org>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 15 13:51:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODFtm-0003uf-68
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 13:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109Ab0EOLvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 07:51:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40317 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645Ab0EOLvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 07:51:12 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 29F35125A0E9; Sat, 15 May 2010 13:51:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201005141253.46956.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147148>

On Fri, May 14, 2010 at 12:53:42PM +0200, Jakub Narebski wrote:
> Note also that Dijkstra wrote in seminal article "Go To Statement
> Considered Harmful" that the problem with abused 'goto' is that it
> compilcates and muddles control flow of program.  But there are
> legitimate uses of 'goto' that make the program simpler to understand,
> and not harder,... among those is handling exceptions.

Also, Dijkstra is well-known for statements that were intentionally
very radical to stir a real debate in the sleepy academic circles and
probably even Dijkstra was not as radical as people would think based
on some of his statements.

For another side of the goto debate, I really recommend reading the
somewhat dated, but still interesting paper [Donald Knuth, "Structured
programming with goto statements," Computing Surveys, December 1974].

-- 
				Petr "Pasky" Baudis
When I feel like exercising, I just lie down until the feeling
goes away.  -- xed_over
