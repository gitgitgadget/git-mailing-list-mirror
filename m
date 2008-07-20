From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-merge-recursive.c: make merge_recursive()
 static
Date: Sun, 20 Jul 2008 14:03:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807201403070.3305@eeepc-johanness>
References: <20080720192127.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKXeF-000205-On
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 14:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234AbYGTMDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 08:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754010AbYGTMDI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 08:03:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:55597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755607AbYGTMDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 08:03:07 -0400
Received: (qmail invoked by alias); 20 Jul 2008 12:03:05 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp019) with SMTP; 20 Jul 2008 14:03:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KshQxbFZK/pmb3fuJWkHvNY+zluLTCCpjkzQRBm
	VkglMIAkwCxilW
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080720192127.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89187>

Hi,

On Sun, 20 Jul 2008, Nanako Shiraishi wrote:

> This function is not used by any other file.

And I thought it would be, in a future version of builtin-merge...

Of course, we could apply this patch now, and revert it later, increasing 
your commit count in the process :-)

Ciao,
Dscho
