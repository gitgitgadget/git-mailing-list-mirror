From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Fix 'url.*.insteadOf' for submodule URLs
Date: Mon, 4 Aug 2008 01:27:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808040126170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <200808040057.00221.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 01:24:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPmwE-0005at-1y
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 01:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758865AbYHCXXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 19:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758840AbYHCXXc
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 19:23:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:49705 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758757AbYHCXXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 19:23:32 -0400
Received: (qmail invoked by alias); 03 Aug 2008 23:23:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp010) with SMTP; 04 Aug 2008 01:23:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ljUcg+avljVgWcOA0DTUQs8lu/gCmuXTIwVco6e
	Ug81uUMcWS/81h
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <200808040057.00221.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91292>

Hi,

On Mon, 4 Aug 2008, Johan Herland wrote:

> As suggested in a thread some time ago, one could redefine the URL used 
> to fetch submodules by adding a 'url.*.insteadOf' rule prior to the 
> first invocation of 'git submodule update'.

If I suggested it, but forgot the "--global" flag to "git config", I 
apologize.

Ciao,
Dscho
