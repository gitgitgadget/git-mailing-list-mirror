From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Fri, 3 Apr 2009 00:39:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904030039290.10279@pacific.mpi-cbg.de>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de> <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de> <49D53ABF.80706@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Marius Storm-Olsen <marius@trolltech.com>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 00:40:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpVa3-00076Y-Qs
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 00:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763755AbZDBWhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 18:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763838AbZDBWhe
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 18:37:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:58205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763946AbZDBWhd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 18:37:33 -0400
Received: (qmail invoked by alias); 02 Apr 2009 22:37:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 03 Apr 2009 00:37:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xLolzkfPxzqC0Jjb3KXVRPfjix/Xvmj1aNJlq8N
	B4Mrd48/kfwtAZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49D53ABF.80706@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115501>

Hi,

On Thu, 2 Apr 2009, A Large Angry SCM wrote:

> {I may be late to this change since I'm trying to catch up on the ML.]
> Johannes Schindelin wrote:
> > Commit 0925ce4(Add map_user() and clear_mailmap() to mailmap) broke the
> > lower-casing of email addresses.  This mostly did not matter if your
> > .mailmap has only lower-case email addresses;  However, we did not
> > require .mailmap to contain lowercase-only email addresses.
> 
> What part of the email address is this going to lowercase? Only the domain
> name is case agnostic.

If that were true, I would get 10% emails less.

Ciao,
Dscho
