From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RESEND PATCH] fast-import: Cleanup mode setting.
Date: Wed, 14 Jan 2009 03:08:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901140308200.3586@pacific.mpi-cbg.de>
References: <1231897027-16197-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 03:09:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMvCA-0006oZ-45
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 03:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbZANCIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 21:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754285AbZANCID
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 21:08:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:51471 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754049AbZANCIB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 21:08:01 -0500
Received: (qmail invoked by alias); 14 Jan 2009 02:07:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 14 Jan 2009 03:07:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19n2/s/Kghn97sVewZvUgg4dN42mAyo4E977mNq9d
	ZzggC/fQ5s4Woo
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231897027-16197-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105572>

Hi,

On Wed, 14 Jan 2009, Felipe Contreras wrote:

> "S_IFREG | mode" probably is only required for 0644 and 0755.

Why should we want to have that patch?  IOW what does it fix, and what 
might it break?

Ciao,
Dscho
