From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/5] mingw: move unlink wrapper to mingw.c
Date: Fri, 18 Feb 2011 00:18:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1102180018250.1541@bonsai2>
References: <20101214220604.GA4084@sandbox> <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com> <7vmxo6pxyi.fsf@alter.siamese.dyndns.org> <20110207204818.GA63976@book.hvoigt.net> <20110207204932.GB63976@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 00:19:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqD7p-0005b4-Ez
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 00:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab1BQXS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 18:18:59 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:48354 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752476Ab1BQXS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 18:18:57 -0500
Received: (qmail invoked by alias); 17 Feb 2011 23:18:55 -0000
Received: from pD9EB1FE7.dip0.t-ipconnect.de (EHLO noname) [217.235.31.231]
  by mail.gmx.net (mp047) with SMTP; 18 Feb 2011 00:18:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WkoFwiiUWDuzpWFwsHgpex0zdgyvV8ThKdOgvh3
	WfV7pQZPdTzB9d
X-X-Sender: gene099@bonsai2
In-Reply-To: <20110207204932.GB63976@book.hvoigt.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167134>

Hi,

On Mon, 7 Feb 2011, Heiko Voigt wrote:

> The next patch implements a workaround in case unlink fails on Windows.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

I merged the current 'next', which has them all.

Thanks!
Dscho
