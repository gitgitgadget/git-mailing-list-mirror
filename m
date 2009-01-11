From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Cleanup of unused symcache variable inside diff-lib.c
Date: Sun, 11 Jan 2009 19:45:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901111944360.3586@pacific.mpi-cbg.de>
References: <1231699002-5316-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sun Jan 11 19:46:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM5KU-0000TU-UO
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 19:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbZAKSom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 13:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbZAKSom
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 13:44:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:32803 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753251AbZAKSol (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 13:44:41 -0500
Received: (qmail invoked by alias); 11 Jan 2009 18:44:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 11 Jan 2009 19:44:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DH7o05IUDY48A61rmEwgK4f8GN/UeWUQvokSHKI
	smj+W1rq892QH6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231699002-5316-1-git-send-email-barvik@broadpark.no>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105198>

Hi,

On Sun, 11 Jan 2009, Kjetil Barvik wrote:

> ---
> :100644 100644 ae96c64... e6d1d2b... M	diff-lib.c

I wonder what that line is all about, since ...

>  diff-lib.c |   40 +++++++++++-----------------------------
>  1 files changed, 11 insertions(+), 29 deletions(-)
> 
> diff --git a/diff-lib.c b/diff-lib.c
> index ae96c64ca209f4df9008198e8a04b160bed618c7..e6d1d2b34147a13aadb5019e0c8336ef5f56ee39 100644

... we have the information right there already.

Ciao,
Dscho
