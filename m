From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitk: Handle msysGit version during version
 comparisons
Date: Tue, 19 May 2009 10:43:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905191043320.26154@pacific.mpi-cbg.de>
References: <87hbzirso6.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue May 19 10:43:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6KvE-00005A-If
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 10:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbZESInd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 04:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbZESInc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 04:43:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:49598 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751320AbZESInc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 04:43:32 -0400
Received: (qmail invoked by alias); 19 May 2009 08:43:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 19 May 2009 10:43:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UtwEpo2GU1zMFk6F9pwyjFI2Hk/DBm7ec/eZgxz
	N5eyyN1mvMB9Oq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87hbzirso6.fsf@users.sourceforge.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119506>

Hi,

On Mon, 18 May 2009, Pat Thoyts wrote:

> 
>   msysGit generates version strings with text appended which cannot
>   be used with vcompare. Limit git_version to the first three digits
>   which are the real git version.
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Is that indent intentional?

Ciao,
Dscho
