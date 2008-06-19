From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add option to git-branch to set up automatic rebasing
Date: Thu, 19 Jun 2008 15:00:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806191459150.6439@racer>
References: <1213836802-3163-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Jun 19 16:03:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9KjH-0002sd-NT
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 16:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbYFSOB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 10:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbYFSOB5
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 10:01:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:56904 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751583AbYFSOB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 10:01:57 -0400
Received: (qmail invoked by alias); 19 Jun 2008 14:01:54 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp057) with SMTP; 19 Jun 2008 16:01:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7ut4jWRL7ZgSwb+WMt7YSW6mtftKYk1WGdbT0ho
	GETjaiPXIe3QYH
X-X-Sender: gene099@racer
In-Reply-To: <1213836802-3163-1-git-send-email-pdebie@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85475>

Hi,

On Thu, 19 Jun 2008, Pieter de Bie wrote:

> This functionality was actually introduced in
>  0a02186f924aee1bd69f18ed01f645aa332ce0d1, but can only be activated by the
> configuration flag. Now we can also setup auto rebasing using the --rebase
> flag in git-branch or git-checkout, similar to how --track works.

How about "--rebasing"?  I would scratch my head a bit how a new branch 
and a rebase would go together.

Ciao,
Dscho
