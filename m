From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] tail -n not supported in all OSs
Date: Tue, 16 Oct 2007 18:19:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161819180.25221@racer.site>
References: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihq5U-0003lP-Ej
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760696AbXJPRTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760757AbXJPRTn
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:19:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:34927 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760544AbXJPRTm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:19:42 -0400
Received: (qmail invoked by alias); 16 Oct 2007 17:19:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 16 Oct 2007 19:19:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DpaNKMMiDSfQ9FkwiwcCV+6LJQpqmF8qho3vTY7
	5kbxYgZ0Vr1mvA
X-X-Sender: gene099@racer.site
In-Reply-To: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61225>

Hi,

On Tue, 16 Oct 2007, Jari Aalto wrote:

> 
> SunOS/Solaris tail(1) does not support option '-n'.

This belongs into the commit message.

Ciao,
Dscho
