From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH 3/7] Add buffer pool library
Date: Mon, 24 May 2010 09:47:57 +0200
Message-ID: <20100524074757.GC3412@m62s10.vlinux.de>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
 <1274650832-7411-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 09:48:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGSOR-0005Cw-8w
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 09:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442Ab0EXHsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 03:48:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:43418 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753508Ab0EXHsC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 03:48:02 -0400
Received: (qmail invoked by alias); 24 May 2010 07:48:00 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp039) with SMTP; 24 May 2010 09:48:00 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/+82gwz8T+IxEMRa6Mtyty/NQTqvM+1J7pMusIHR
	dNdJO00jdVqmWB
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 7DB40DC58E; Mon, 24 May 2010 09:47:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1274650832-7411-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147606>

On Sun, May 23, 2010 at 11:40:28PM +0200, Ramkumar Ramachandra wrote:
> line_buffer creates a couple of static buffers and expose an API for
> using them. The idea is to maintain a fixed static memory pool to
> avoid constant allocation and de-allocation of memory. Taken directly
> from David Michael Barr's svn-dump-fast-export repository.
> 

If this is David's code, shouldn't you then preserve authorship?
