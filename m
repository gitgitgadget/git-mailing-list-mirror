From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH TAKE 2] Avoid a useless prefix lookup in
 strbuf_expand()
Date: Sun, 10 Feb 2008 02:52:21 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802100252030.11591@racer.site>
References: <1202568019-20200-1-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 03:53:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO2JT-0006FZ-Sa
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 03:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbYBJCwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 21:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754719AbYBJCwU
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 21:52:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:58525 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753043AbYBJCwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 21:52:19 -0500
Received: (qmail invoked by alias); 10 Feb 2008 02:52:17 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp008) with SMTP; 10 Feb 2008 03:52:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9pAI69CC9JJfjZ+SRrd+VKL9Ckk4KvAAHEdhXXD
	ak2kUTosOuOML4
X-X-Sender: gene099@racer.site
In-Reply-To: <1202568019-20200-1-git-send-email-mcostalba@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73298>

Hi,

On Sat, 9 Feb 2008, Marco Costalba wrote:

> +	/* bougus commit, 'sb' cannot be updated, but

s/bougus/bogus/

Ciao,
Dscho
