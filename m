From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] assertion failure in builtin-mv.c with "git mv -k"
Date: Wed, 14 Jan 2009 16:54:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901141653540.3586@pacific.mpi-cbg.de>
References: <vpqwscy81o8.fsf@bauges.imag.fr> <496DFC75.2000904@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 16:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN85j-00076K-7G
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 16:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbZANPxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 10:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbZANPxy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 10:53:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:43698 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752401AbZANPxy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 10:53:54 -0500
Received: (qmail invoked by alias); 14 Jan 2009 15:53:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 14 Jan 2009 16:53:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lWcNK+qJlCXOjmBqrd96FQfDpqsnwoDz4f2mrcP
	DFSIGUS3xWSs7w
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <496DFC75.2000904@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105645>

Hi,

On Wed, 14 Jan 2009, Michael J Gruber wrote:

> I'll send a patch but I'm not sure if this needs a test case.

Umm, Michael, you have been here long enough to know that the answer is a 
"YES!".  If you fix something, you want to provide a test case just to 
make sure you do not need to fix it again later.

Ciao,
Dscho
