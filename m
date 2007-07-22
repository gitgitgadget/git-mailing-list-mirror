From: Michael Tharp <gxti@partiallystapled.com>
Subject: Re: Git tree for old kernels from before the current tree
Date: Sun, 22 Jul 2007 19:26:50 -0400
Message-ID: <46A3E7BA.6030609@partiallystapled.com>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com> <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr> <20070722211314.GA13850@linux-sh.org> <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr> <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr> <46A3D5EA.2050600@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 01:59:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IClL4-0003iu-EN
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 01:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764881AbXGVX7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 19:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758822AbXGVX7q
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 19:59:46 -0400
Received: from osiris.atheme.org ([69.60.119.211]:49900 "EHLO
	osiris.atheme.org" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756192AbXGVX7p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 19:59:45 -0400
X-Greylist: delayed 2008 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jul 2007 19:59:45 EDT
Received: by osiris.atheme.org (Postfix, from userid 65534)
	id EAD8090790; Sun, 22 Jul 2007 23:25:43 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on osiris.atheme.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.2.0
Received: from sidhe.atheme.org (sidhe.atheme.org [204.15.224.234])
	by osiris.atheme.org (Postfix) with ESMTP id 8FAB38F9FB;
	Sun, 22 Jul 2007 23:25:41 +0000 (GMT)
Received: from [192.168.1.64] (cpe-066-057-099-027.nc.res.rr.com [66.57.99.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sidhe.atheme.org (Postfix) with ESMTP id B3F586FC0EA;
	Sun, 22 Jul 2007 16:26:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070619)
In-Reply-To: <46A3D5EA.2050600@zytor.com>
X-Enigmail-Version: 0.95.2
OpenPGP: id=94C1C841
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53372>

H. Peter Anvin wrote:
> Wouldn't be hard to make a git tree with all the patches all the way
> back to 0.01 even...

It'd be delightful from a completeness standpoint (and I do love
completeness), but considering it already takes a good 20 minutes to
clone the 2.6 tree over a respectable cable connection, I'd have to
object on the grounds of size. Now, if it was kept off in its own tree
for people who don't mind ravaging kernel.org resources to satisfy their
own curiosity, that's fine too.

  -- m. tharp
