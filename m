From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: added missing warn function
Date: Wed, 4 Jul 2007 12:21:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041221170.4071@racer.site>
References: <11835381843502-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 13:21:46 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I62vW-0004d3-9V
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 13:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758684AbXGDLVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 07:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757740AbXGDLVj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 07:21:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:46766 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755534AbXGDLVi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 07:21:38 -0400
Received: (qmail invoked by alias); 04 Jul 2007 11:21:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 04 Jul 2007 13:21:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qez9YVFbqU0B4DzA9OB4teuIO7XJWzhycQ5UJeu
	CSOnMCnJiS7qq1
X-X-Sender: gene099@racer.site
In-Reply-To: <11835381843502-git-send-email-prohaska@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51594>

Hi,

On Wed, 4 Jul 2007, Steffen Prohaska wrote:

> --tag-name-filter may have failed before because
> warn is used for reporting but was not available.

Ooops. Thanks.

Ciao,
Dscho
