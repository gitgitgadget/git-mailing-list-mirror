From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 01:29:45 +0300
Message-ID: <20080827222945.GT11734@cs181140183.pp.htv.fi>
References: <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com> <20080827202707.GA25233@coredump.intra.peff.net> <48B5BB35.8090606@pobox.com> <20080827210555.GF18340@parisc-linux.org> <20080827211326.GI11734@cs181140183.pp.htv.fi> <20080827212217.GA3554@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthew Wilcox <matthew@wil.cx>, Jeff Garzik <jgarzik@pobox.com>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Andi Kleen <andi@firstfloor.org>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Willy Tarreau <w@1wt.eu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:32:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYTYG-00080F-BK
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 00:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbYH0Waj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 18:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbYH0Waj
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 18:30:39 -0400
Received: from smtp4.pp.htv.fi ([213.243.153.38]:52869 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbYH0Waj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 18:30:39 -0400
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 37BB05BC026;
	Thu, 28 Aug 2008 01:30:38 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080827212217.GA3554@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93970>

On Wed, Aug 27, 2008 at 05:22:17PM -0400, Jeff King wrote:
> On Thu, Aug 28, 2008 at 12:13:26AM +0300, Adrian Bunk wrote:
> 
> > BTW: I'd love to get a --pretty=noline
> 
> How about --pretty=format: ?

Thanks, that does the trick.  :-)

> -Peff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
