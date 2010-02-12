From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git under Windows should warn or fail on entities differning
 only in case
Date: Fri, 12 Feb 2010 14:14:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002121412300.20986@pacific.mpi-cbg.de>
References: <1265978433.7519.6.camel@chumley>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Hagood <david.hagood@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 14:08:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfvG2-0001Ck-9r
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 14:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547Ab0BLNIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 08:08:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:59339 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755283Ab0BLNIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 08:08:24 -0500
Received: (qmail invoked by alias); 12 Feb 2010 13:08:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 12 Feb 2010 14:08:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/s0HpRktLsFOz7tRDBpMMXyj5SqI9vipLLmaGEdi
	YviEILGHc75YMf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1265978433.7519.6.camel@chumley>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.69999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139707>

Hi,

Disclaimer: I am not uninterested in the subject you talk about, but my 
reply could come over as harsh, due to lack of time. If you are likely to 
be annoyed by direct criticism, delete this mail and do not reply. Thank 
you very much.

On Fri, 12 Feb 2010, David Hagood wrote:

> I would suggest that git should check for this case, and generate a big 
> warning about it when it happens. (Yes, it sucks burdening Git with 
> Windows' problems....)

Git is burdened with Windows' problems already. That does not suck. What 
sucks is that you only suggest that Git should check the case, in effect 
asking the few Git for Windows contributors to do it, instead of 
just going ahead and scratching your own itch.

Ciao,
Dscho
