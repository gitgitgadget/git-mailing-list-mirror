From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Never mind (Re: [KORG] gitweb down?)
Date: Sun, 22 Jul 2007 13:24:07 -0700
Message-ID: <46A3BCE7.90007@zytor.com>
References: <20070722174915.GI26471@cip.informatik.uni-erlangen.de> <46A39CEA.7020703@zytor.com> <alpine.LFD.0.999.0707221316050.3607@woody.linux-foundation.org> <alpine.LFD.0.999.0707221320130.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: webmaster@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 22:24:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IChyT-0001Ia-5C
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 22:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762893AbXGVUYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 16:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762871AbXGVUYO
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 16:24:14 -0400
Received: from terminus.zytor.com ([198.137.202.10]:50172 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762633AbXGVUYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 16:24:12 -0400
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l6MKO8qC003896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jul 2007 13:24:08 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.13.8/8.13.8) with ESMTP id l6MKO8Su008416;
	Sun, 22 Jul 2007 13:24:08 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.13.8/8.13.6) with ESMTP id l6MKO7tL022074;
	Sun, 22 Jul 2007 13:24:07 -0700
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <alpine.LFD.0.999.0707221320130.3607@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.88.7/3729/Sun Jul 22 09:10:33 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53315>

Linus Torvalds wrote:
> 
> On Sun, 22 Jul 2007, Linus Torvalds wrote:
>> The main git.kernel.org page loads about half-way (without any stated 
>> errors, but it's definitely broken and not complete), but the summary 
>> pages don't seem to load at all (some projects do, but git and kernel 
>> don't - it looks like the *cache* may still be working, but anything new 
>> gets a "500 Internal Server Error").
> 
> Ok, retried immediately after sending the email, and it's ok now. So never 
> mind - I probably tested just when some update was in progress..
> 

No, it ran out of disk space; I just cleaned it out.

	-hpa
