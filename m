From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Testsuite: Unset CVS_SERVER
Date: Thu, 17 Jul 2008 13:45:10 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807171344210.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1216288877-12140-1-git-send-email-lars@public.noschinski.de> <1216288877-12140-2-git-send-email-lars@public.noschinski.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, fabian.emmes@rwth-aachen.de
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 13:46:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJRw6-0005kV-RI
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 13:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbYGQLpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 07:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbYGQLpO
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 07:45:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:49746 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753208AbYGQLpN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 07:45:13 -0400
Received: (qmail invoked by alias); 17 Jul 2008 11:45:11 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp019) with SMTP; 17 Jul 2008 13:45:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uMe1+ksjuoX58z1QhNena9VrCc87hAALBL5raYX
	AsH7hu05XU6FE7
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1216288877-12140-2-git-send-email-lars@public.noschinski.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88832>

Hi,

On Thu, 17 Jul 2008, Lars Noschinski wrote:

> From: Fabian Emmes <fabian.emmes@rwth-aachen.de>
> 
> The CVS_SERVER environment variable cane cause some of the cvsimport tests

s/cane/can/

Otherwise uncontroversial, I'd say.

Ciao,
Dscho
