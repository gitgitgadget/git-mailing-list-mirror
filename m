From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 12:54:30 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802071246320.2896@woody.linux-foundation.org>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207142322.GC18497@mail-vs.djpig.de>
 <alpine.LFD.1.00.0802071039010.2883@woody.linux-foundation.org> <20080207201445.GD18497@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu Feb 07 21:56:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNDna-0001Z9-21
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 21:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933463AbYBGUzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 15:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762525AbYBGUzf
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 15:55:35 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47669 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933396AbYBGUzc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2008 15:55:32 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m17KsV3M004463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Feb 2008 12:54:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m17KsUmb021621;
	Thu, 7 Feb 2008 12:54:31 -0800
In-Reply-To: <20080207201445.GD18497@mail-vs.djpig.de>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.714 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72999>



On Thu, 7 Feb 2008, Frank Lichtenheld wrote:
> 
> Easy to say for someone who only distributes source code... (AFAIK
> anyway)

Sure. But I'd like to point out that there are tons of distributiors of 
Linux _and_ other operating systems - with real lawyers involved - that 
distribute things compiled with OpenSSL, and nobody sane actually thinks 
it is a problem. The fact that the OpenSSL license isn't compatible with 
GPL is a total non-issue: people compile GPL'd programs against totally 
proprietary libraries or other non-GPL-compatible things.

> Anyway, since Debian will not change its opinion about this, my answer
> was in the context of the question obviously useful. Whether it was
> generally correct is probably off-topic here.

Umm. You claimed that the result would not be "distributable". I just 
both corrected that total misunderstanding (on part of the Debian crowd) 
_and_ said that even crazy Debian people can work around it.

So please don't say that things are not "distributable" when they clearly 
are. 

			Linus
