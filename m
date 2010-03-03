From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH 1/1] Add commit log message spell checking feature.
Date: Wed, 3 Mar 2010 19:50:34 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1003031947180.19842@vqena.qenxr.bet.am>
References: <alpine.LNX.2.00.1002281258340.15334@vqena.qenxr.bet.am> <7e21d6cd64aa088763c3ff11d6cbe78899ae7f10.1267314986.git.sdrake@xnet.co.nz> <20100228163339.GA9399@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 03 07:59:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmiY8-00082a-Cc
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 07:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab0CCG7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 01:59:10 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:59584 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754839Ab0CCG7J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 01:59:09 -0500
Received: from idran.drake.org.nz (ip-118-90-92-73.xdsl.xnet.co.nz [118.90.92.73])
	by ananke.wxnz.net (Postfix) with ESMTP id 7F60F170923;
	Wed,  3 Mar 2010 19:59:05 +1300 (NZDT)
In-Reply-To: <20100228163339.GA9399@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141437>

On Sun, 28 Feb 2010, Jeff King wrote:
> On Sun, Feb 28, 2010 at 01:03:00PM +1300, Steven Drake wrote:
> 
> > Add 'git commit --spell' to run a spell checker on commit log message.
> > The `commit.spell` configuration variable can be used to enable the spell
> > checker by default and can be turned off by '--no-spell'.
> 
> Isn't this exactly the sort of thing the commit-msg hook is for?

Accept then there would be no way of having '--spell'/'--no-spell' (Yet!).

> Though personally I would probably just invoke interactive spell-checking
> from the editor.

I would probably forget to.

-- 
Steven
I'm such a prick!  --- The Bastard Operator from Hell
