From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] shortlog: remove --help option parsing
Date: Mon, 1 Oct 2007 12:42:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710011241430.28395@racer.site>
References: <20071001102020.GA8315@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Oct 01 13:44:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcJhC-00023F-QV
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 13:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbXJALoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 07:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbXJALoJ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 07:44:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:56240 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751516AbXJALoI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 07:44:08 -0400
Received: (qmail invoked by alias); 01 Oct 2007 11:44:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 01 Oct 2007 13:44:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186oHdEUuw6KAi/rARLwKkwVJoQxPYSpxIyb0CF/p
	VadtXImbBMjh9Y
X-X-Sender: gene099@racer.site
In-Reply-To: <20071001102020.GA8315@diku.dk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59603>

Hi,

On Mon, 1 Oct 2007, Jonas Fonseca wrote:

> -		else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
> +		else if (!strcmp(argv[1], "-h"))

I see that this is my fault.

Thanks,
Dscho
