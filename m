From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Instruct how to use
 [PATCH] Subject header
Date: Mon, 4 Feb 2008 00:29:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802040029020.7372@racer.site>
References: <r6ft1sd1.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 01:30:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLpET-0006EZ-Fl
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 01:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbYBDAaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 19:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbYBDAaL
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 19:30:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:44400 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752902AbYBDAaK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 19:30:10 -0500
Received: (qmail invoked by alias); 04 Feb 2008 00:30:08 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp050) with SMTP; 04 Feb 2008 01:30:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tmZcWr1ntrXN1gVQHE2JtJ1sv19OXFgJB3wNtmF
	31mD4wuLvkb0NC
X-X-Sender: gene099@racer.site
In-Reply-To: <r6ft1sd1.fsf@blue.sea.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72436>

Hi,

On Mon, 4 Feb 2008, Jari Aalto wrote:

> @@ -37,6 +37,9 @@ Checklist (and a short version for the impatient):
>  	  maintainer (gitster@pobox.com). If you use
>  	  git-send-email(1), please test it first by sending
>  	  email to yourself.
> +        - If you rework the patch, announce the message
> +          in brackets. For example "[PATCH/RFC]", "[PATCH (resend)]",
> +          "[PATCH v2]" etc.

Whitespace error?  (Spaces instead of Tabs)

Ciao,
Dscho
