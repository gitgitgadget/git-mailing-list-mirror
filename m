From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 17:12:54 -0700
Message-ID: <46A54406.8020605@zytor.com>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com> <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr> <20070722211314.GA13850@linux-sh.org> <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr> <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr> <46A3D5EA.2050600@zytor.com> <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org> <alpine.LFD.0.999.0707231343350.6355@xanadu.home> <alpine.LFD.0.999.0707231057480.3607@woody.linux-foundation.org> <alpine.LFD.0.999.0707231432560.6355@xanadu.home> <20070723234628.GN21668@ftp.linux.org.uk> <alpine.LFD.0.999.0707231957450.6355@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Al Viro <viro@ftp.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 02:16:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID84o-0004pz-Rj
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 02:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759316AbXGXAQb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 20:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758870AbXGXAQb
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 20:16:31 -0400
Received: from terminus.zytor.com ([198.137.202.10]:57779 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411AbXGXAQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 20:16:30 -0400
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l6O0CuLT002421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 17:12:56 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.13.8/8.13.8) with ESMTP id l6O0CuKR021792;
	Mon, 23 Jul 2007 17:12:56 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.13.8/8.13.6) with ESMTP id l6O0CtHf029400;
	Mon, 23 Jul 2007 17:12:55 -0700
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <alpine.LFD.0.999.0707231957450.6355@xanadu.home>
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.88.7/3745/Mon Jul 23 14:01:34 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53513>

Nicolas Pitre wrote:
> 
> I have sanitized .tgz files that I use to stuff a Git repo with.  I 
> recall that some of them were reconstructed through patching an earlier 
> or later kernel version because the original ones were corrupted. Some 
> patches were retrieved from other archival sites, etc.  Then the result 
> was 
> cross checked with summary lists like this one: 
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0110.1/1684.html
> 
> This was a while ago so I don't remember the exact steps, but that 
> wasn't always trivial.
> 

Then there is 0.95a, 0.95c and 0.95c+, which as far as I know only ever
existed as 0.95 + patches posted to alt.os.linux.

	-hpa
