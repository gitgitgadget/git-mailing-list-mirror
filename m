From: Alan Hourihane <alanh@fairlite.co.uk>
Subject: Re: new platform & S_IFGITLINK problem
Date: Tue, 04 May 2010 08:21:36 +0100
Message-ID: <1272957697.13488.1319.camel@jetpack.demon.co.uk>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk>
	 <7vfx2b2ft5.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1005032035310.5478@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 04 09:21:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9CRt-0003bI-D0
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 09:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390Ab0EDHVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 03:21:40 -0400
Received: from fairlite.demon.co.uk ([80.176.228.186]:59369 "EHLO
	fairlite.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab0EDHVj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 03:21:39 -0400
Received: from localhost (unknown [127.0.0.1])
	by fairlite.demon.co.uk (Postfix) with ESMTP id 0D070223F54;
	Tue,  4 May 2010 07:21:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at demon.co.uk
Received: from fairlite.demon.co.uk ([127.0.0.1])
	by localhost (server.demon.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hc7nLqUGCIS4; Tue,  4 May 2010 08:21:37 +0100 (BST)
Received: from [192.168.0.226] (unknown [192.168.0.226])
	by fairlite.demon.co.uk (Postfix) with ESMTP id 6E164221EEA;
	Tue,  4 May 2010 08:21:37 +0100 (BST)
In-Reply-To: <alpine.LFD.2.00.1005032035310.5478@i5.linux-foundation.org>
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146299>

On Mon, 2010-05-03 at 20:39 -0700, Linus Torvalds wrote:
> 
> On Sat, 1 May 2010, Junio C Hamano wrote:
> > 
> > Yes, that assumption is a gross POSIX violation but we so far haven't seen
> > any platform that matters in real life that assigns the IFMT bits
> > differently.
> 
> Indeed. Just out of interest - Alan, what _is_ the crazy platform that 
> doesn't match what absolutely everybody else has always done?

You don't want to know :-)

But if you really must, it's an Atari platforms running FreeMiNT, but
was also essentially Atari's own MultiTOS as well which they adopted
from the original MiNT project.

Alan.
