From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git tree for old kernels from before the current tree
Date: Sun, 22 Jul 2007 15:10:50 -0700
Message-ID: <46A3D5EA.2050600@zytor.com>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com> <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr> <20070722211314.GA13850@linux-sh.org> <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr> <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul Mundt <lethal@linux-sh.org>, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:11:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjdx-0000kO-GE
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760583AbXGVWLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760111AbXGVWLJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:11:09 -0400
Received: from terminus.zytor.com ([198.137.202.10]:40218 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757664AbXGVWLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:11:07 -0400
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l6MMAsVG023309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jul 2007 15:10:54 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.13.8/8.13.8) with ESMTP id l6MMAs81009219;
	Sun, 22 Jul 2007 15:10:54 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.13.8/8.13.6) with ESMTP id l6MMApos023016;
	Sun, 22 Jul 2007 15:10:52 -0700
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr>
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.88.7/3731/Sun Jul 22 13:44:56 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53343>

Jan Engelhardt wrote:
> On Jul 22 2007 23:46, Jan Engelhardt wrote:
>> On Jul 23 2007 06:13, Paul Mundt wrote:
>>> Err, that's crap. Have you even looked at gitweb? There's at least:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>>> This has trees all the way back to 2.5.0.
> 
> Actually back to 2.4.0, including history. That I'd call mission done then :)
> 

Wouldn't be hard to make a git tree with all the patches all the way
back to 0.01 even...

	-hpa
