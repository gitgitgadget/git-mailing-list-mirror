From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitk: persist and restore the window state with the
 geometry
Date: Tue, 14 Apr 2009 23:18:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904142317330.10279@pacific.mpi-cbg.de>
References: <873acbndr2.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, paulus@samba.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 23:17:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltq0J-0002SH-9k
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 23:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbZDNVPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 17:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754615AbZDNVPm
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 17:15:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:53151 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753985AbZDNVPm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 17:15:42 -0400
Received: (qmail invoked by alias); 14 Apr 2009 21:15:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 14 Apr 2009 23:15:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Nf2p9zanNk13k0ro7i1Ei/s+PJjP/1KorrmEkKR
	kDPADrkY1+vFe1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <873acbndr2.fsf@users.sourceforge.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: -0.07000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116574>

Hi,

On Tue, 14 Apr 2009, Pat Thoyts wrote:

> 
>   This patch records the window state and if the window was maximized
>   this state is re-applied.

This solves msysGit issue 235:

	http://code.google.com/p/msysgit/issues/detail?id=235

Ciao,
Dscho
