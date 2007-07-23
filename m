From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 16:49:55 -0700
Message-ID: <46A53EA3.1060204@zytor.com>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com> <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr> <20070722211314.GA13850@linux-sh.org> <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr> <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr> <46A3D5EA.2050600@zytor.com> <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org> <alpine.LFD.0.999.0707231343350.6355@xanadu.home> <alpine.LFD.0.999.0707231057480.3607@woody.linux-foundation.org> <alpine.LFD.0.999.0707231432560.6355@xanadu.home> <20070723234628.GN21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Al Viro <viro@ftp.linux.org.uk>
X-From: git-owner@vger.kernel.org Tue Jul 24 01:54:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID7jZ-00007O-Tl
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 01:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758785AbXGWXyf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 19:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755178AbXGWXye
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 19:54:34 -0400
Received: from terminus.zytor.com ([198.137.202.10]:38324 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757485AbXGWXyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 19:54:33 -0400
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l6NNnxee000739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 16:49:59 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.13.8/8.13.8) with ESMTP id l6NNnxLX021624;
	Mon, 23 Jul 2007 16:49:59 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.13.8/8.13.6) with ESMTP id l6NNnuQO019086;
	Mon, 23 Jul 2007 16:49:56 -0700
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <20070723234628.GN21668@ftp.linux.org.uk>
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.88.7/3745/Mon Jul 23 14:01:34 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53508>

Al Viro wrote:
> On Mon, Jul 23, 2007 at 03:06:09PM -0400, Nicolas Pitre wrote:
>>  - v0.96 sources
>>
>>  - v0.99.12 announcement
>>
>>  - sources for v0.99.13{abcdefghij} (got k, don't know where the serie 
>>    ends) as well as announcements for all of them
>>
>>  - all announcements for v0.99.14{a-z} except for pl14r
>>
>>  - announcements for pl15c to pl15j, 1.0-pre1, and ALPHA-1.0.
>>
>> Otherwise the archive appears fairly complete with almost 3 years of 
>> Linux development history captured in a 3MB pack file.
> 
> Umm...  IIRC, tar was unhappy with several tarballs on ftp.kernel.org.
> Do you have replacements (or instructions re combination of tar(1) options
> to make it eat them)?

There is some stuff at http://mirrors.kernel.org/oldlinux/

That's all I have, I'm afraid...

	-hpa
