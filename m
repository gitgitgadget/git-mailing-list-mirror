From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/9] builtin-verify-tag.c: use parse_options()
Date: Sat, 26 Jul 2008 02:53:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260252520.11976@eeepc-johanness>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-2-git-send-email-barra_cuda@katamail.com> <4888B4E3.9000504@free.fr> <alpine.DEB.1.00.0807241807550.8986@racer> <4889EF22.6020604@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-139496175-1217033597=:11976"
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sat Jul 26 02:53:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMY27-0005wQ-Ud
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 02:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbYGZAwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 20:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYGZAwQ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 20:52:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:46445 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751600AbYGZAwP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 20:52:15 -0400
Received: (qmail invoked by alias); 26 Jul 2008 00:52:13 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp054) with SMTP; 26 Jul 2008 02:52:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KGadNANjKXfQ6uGz1dMM3v7pCp3nsSS9zasHhmu
	uZ4fWwzxLOa2V2
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4889EF22.6020604@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90140>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-139496175-1217033597=:11976
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 25 Jul 2008, Olivier Marin wrote:

> Johannes Schindelin a écrit :
> > 
> > That would be a bugfix.  As such, it belongs into a different commit.  
> 
> I thought, for that kind of trivial bug that probably never hit anyone, 
> a line in the commit message was enough.

So bisectability goes down the gutter?
--658432-139496175-1217033597=:11976--
