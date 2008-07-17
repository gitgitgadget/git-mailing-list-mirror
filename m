From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsserver: Add testsuite for packed refs
Date: Thu, 17 Jul 2008 13:54:28 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807171351520.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1216288877-12140-1-git-send-email-lars@public.noschinski.de> <1216288877-12140-2-git-send-email-lars@public.noschinski.de> <1216288877-12140-3-git-send-email-lars@public.noschinski.de>
 <1216288877-12140-4-git-send-email-lars@public.noschinski.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, fabian.emmes@rwth-aachen.de
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 13:55:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJS54-0000rQ-Uf
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 13:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbYGQLyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 07:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754894AbYGQLyb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 07:54:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:44378 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754275AbYGQLyb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 07:54:31 -0400
Received: (qmail invoked by alias); 17 Jul 2008 11:54:29 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp061) with SMTP; 17 Jul 2008 13:54:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18A5NZiGBsAtPnyLqTn89XUfsw635k6g34k1jtb2R
	arp7pl5vdKMH/3
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1216288877-12140-4-git-send-email-lars@public.noschinski.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88834>

Hi,

On Thu, 17 Jul 2008, Lars Noschinski wrote:

> +    grep "^M master[	 ]\+master$" < out

As I said, I am not versed enough in the Teachings of CVS to know if this 
is correct.

If the old behaviour ("E cvs ...") was "more" correct, this needs 
changing, too.

Ciao,
Dscho
