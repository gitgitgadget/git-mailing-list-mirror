From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix git-shell build error when NO_SETENV is defined
Date: Mon, 21 Jul 2008 03:33:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807210333330.3305@eeepc-johanness>
References: <g60la4$diu$1@ger.gmane.org> <1216601017-7871-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807210321190.3305@eeepc-johanness> <20080721012928.GG5950@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: SungHyun Nam <namsh@posdata.co.kr>, git@vger.kernel.org,
	gitster@pobox.com
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jul 21 03:33:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKkHj-0007IM-6v
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 03:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbYGUBc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 21:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbYGUBc4
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 21:32:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:60327 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754238AbYGUBcz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 21:32:55 -0400
Received: (qmail invoked by alias); 21 Jul 2008 01:32:53 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp014) with SMTP; 21 Jul 2008 03:32:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/O/upPqFfONkibpbSwB8e35m8L/BJibMfecAVwYu
	YMoOzkn4fowZAr
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080721012928.GG5950@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89292>

Hi,

On Mon, 21 Jul 2008, Stephan Beyer wrote:

> Johannes Schindelin wrote:
> > Funny.  It was not 24 hours ago that Hannes reported a related issue.  And 
> > he was testing with different options.
> 
> Oh, seems that I have missed that topic. Gna :)
> 
> But fine if everything is working again then.

No, it is not.

Ciao,
Dscho
