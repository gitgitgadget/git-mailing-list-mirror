From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 00:24:39 +0100
Message-ID: <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <20081031213114.GA21799@artemis.corp>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:26:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3NT-0007x7-AJ
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbYJaXYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbYJaXYu
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:24:50 -0400
Received: from frim.nl ([87.230.85.232]:57464 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750965AbYJaXYt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Oct 2008 19:24:49 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1Kw3MD-0001VV-K6; Sat, 01 Nov 2008 00:24:45 +0100
In-Reply-To: <20081031213114.GA21799@artemis.corp>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99675>


On 31 okt 2008, at 22:31, Pierre Habouzit wrote:

> Git is currently mostly "GPLv2 or later". A BSDish license was
> mentioned, because it's the most permissive one and that nobody cared
> that much, though a LGPL/GPL-with-GCC-exception would probably fly.
>
> Many of the people needing a library for libgit are probably reading  
> the
> list, I'll let them comment

As an implementor of a git GUI, I don't really care what license
libgit2 will be. GitX is currently GPLv2, though that might change
to LGPL to allow it to ship/link with non-GPL libraries. GPL and LGPL
would both suit me.

As a more concrete comment, is there anything you would like to hear
from GUI developers during the development of libgit2? I'm not sure I
can contribute much in terms of code, but if you need any constructive
comments, I can help with that.

- Pieter
