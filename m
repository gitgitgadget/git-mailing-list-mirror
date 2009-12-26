From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/4] clone: use --progress to mean -v
Date: Sat, 26 Dec 2009 09:53:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912260952020.4985@pacific.mpi-cbg.de>
References: <18831.46833.862.196815@hungover.brentg.com> <1261761126-5784-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 26 09:49:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOSKu-0002H7-BA
	for gcvg-git-2@lo.gmane.org; Sat, 26 Dec 2009 09:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbZLZIsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2009 03:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbZLZIsw
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 03:48:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:35712 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751664AbZLZIsw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 03:48:52 -0500
Received: (qmail invoked by alias); 26 Dec 2009 08:48:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 26 Dec 2009 09:48:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4Se1ARL/4ZUjSQpbKw6mJsyyo+vuprigBn7YbzW
	ExBZIOYpw4uq5F
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1261761126-5784-1-git-send-email-rctay89@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135686>

Hi,

On Sat, 26 Dec 2009, Tay Ray Chuan wrote:

> This series makes git-clone follow the "argument convention" of 
> git-pack-objects, where the option --progress is used to force reporting 
> of reporting. This was previously done with -v/--verbose.

No objections from my side, although you might want to advertise more that 
this is a change in behavior.  (Meaning in the release notes)

> PS. If someone can enlighten me on the proper noun for the git
>     executable (I said "main git"), I would be very thankful.

I call it the "Git wrapper", although less polite words exist, too.

Ciao,
Dscho
