From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/fast-export: Document --import-marks and
 --export-marks options
Date: Sat, 7 Jun 2008 16:20:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806071619580.1783@racer>
References: <1212663163-43064-1-git-send-email-pdebie@ai.rug.nl> <1212845104-79789-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sat Jun 07 17:22:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K50Fa-0001OW-VN
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 17:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172AbYFGPVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 11:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757156AbYFGPVq
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 11:21:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:60791 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757151AbYFGPVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 11:21:45 -0400
Received: (qmail invoked by alias); 07 Jun 2008 15:21:43 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp007) with SMTP; 07 Jun 2008 17:21:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++w+IDUr6+4+gAW7QzTUwZ6HdWVraLXhZ9NPiGeG
	Goo03fA84Qkl8t
X-X-Sender: gene099@racer
In-Reply-To: <1212845104-79789-1-git-send-email-pdebie@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84205>

Hi,

On Sat, 7 Jun 2008, Pieter de Bie wrote:

> This adds a description for git-fast-export's --import-marks and
> --export-marks options to its man page.
> ---
> 
> I forgot to add the options to the man page. Perhaps this should be 
> squashed on top of the other patch?

Yes, that and the patch to use the existing functions to set/get the 
marks instead of duplicating code.

Ciao,
Dscho
