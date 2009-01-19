From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit: more compact summary and without extra quotes
Date: Tue, 20 Jan 2009 00:46:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901200043400.3586@pacific.mpi-cbg.de>
References: <1232405116-2359-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2141651838-1232408785=:3586"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 00:47:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3qY-0006fA-KO
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbZASXqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754511AbZASXqX
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:46:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:60679 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753830AbZASXqW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 18:46:22 -0500
Received: (qmail invoked by alias); 19 Jan 2009 23:46:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 20 Jan 2009 00:46:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6Sug7G9i6wkSzjw8twEqbFJhuC/T82Osd8/wl+F
	CHwqIeZtUU3tyV
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232405116-2359-1-git-send-email-santi@agolina.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106410>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2141651838-1232408785=:3586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 19 Jan 2009, Santi Béjar wrote:

> Original:
> [master]: created d9a5491: "foo:bar"
> 
> While with the patch it becomes:
> [master d9a5491] foo:bar

Maybe you want to mention that it saves screen estate.  After all, the 
commit message is _the_ place to relate your motivation to the gentle 
reader.

> As discussed in the git mailing list:
> 
> http://marc.info/?l=git&m=122765031208922&w=2
> 
> Signed-off-by: Santi Béjar <santi@agolina.net>
> ---

You really want to move the link after the ---.  I often read commit 
messages off-line, and let me tell you: I am not really happy reading 
links then.  Not at all.

Ciao,
Dscho
--8323328-2141651838-1232408785=:3586--
