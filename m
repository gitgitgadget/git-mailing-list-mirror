From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 3/3] pretty: support multiline subjects with format:
Date: Sun, 28 Dec 2008 15:08:02 +0100
Message-ID: <200812281508.02658.markus.heidelberg@web.de>
References: <200812280024.59096.markus.heidelberg@web.de> <1230338961.8363.101.camel@ubuntu.ubuntu-domain> <20081228090909.6117@nanako3.lavabit.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 15:09:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGwKg-0000f9-Ts
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 15:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbYL1OIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 09:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754671AbYL1OIA
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 09:08:00 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:57583 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642AbYL1OH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 09:07:59 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6AF45F5FA46F;
	Sun, 28 Dec 2008 15:07:58 +0100 (CET)
Received: from [91.19.28.232] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LGwJC-00030H-00; Sun, 28 Dec 2008 15:07:58 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20081228090909.6117@nanako3.lavabit.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX185KYBeurGeduFtE42ls2eIqyjayCG4L37FqeuY
	VBxgHir5zbkwjNSXeKOhACaENQ/ke+o2n0p1Sbn8KHv5GjhPpG
	jJlpm7BrBWXRaq+Lz7+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104048>

Nanako Shiraishi, 28.12.2008:
> Quoting Markus Heidelberg <markus.heidelberg@web.de>:
> 
> >> For consistency and increased code reuse, change format: to do the
> >> same as the other options.
> >
> > What's wrong with using the first line instead of the first paragraph
> > for the other pretty options and for cases where only a small subject
> > line is desired?
> 
> There were too many issues. The mail archive tells us that there were
> considerable discussions and thoughts behind the current behavior:

Many thanks for all the pointers. I thought there were reasons, but this
thread just made me ask.

Markus
