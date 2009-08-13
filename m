From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix typo in filter-branch example
Date: Thu, 13 Aug 2009 19:04:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908131903280.7429@intel-tinevez-2-302>
References: <4a843cdf.1608c00a.504c.0eed@mx.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Thu Aug 13 19:04:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbdjK-0007Tj-IC
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 19:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbZHMREV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 13:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755096AbZHMREU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 13:04:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:39355 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755078AbZHMRER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 13:04:17 -0400
Received: (qmail invoked by alias); 13 Aug 2009 17:04:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp033) with SMTP; 13 Aug 2009 19:04:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jPdZQGfpjbWm3WBhadBcCO447F6/zD0RoONyUYh
	cl5t0JczFQYwaB
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4a843cdf.1608c00a.504c.0eed@mx.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125838>

Hi,

On Thu, 13 Aug 2009, Ori Avtalion wrote:

> ---

This is not a typo. '&' is sed's way to specify the matched string.  Where 
does it occur anyway (the commit message makes a fabulous place to put 
such information)?

Ciao,
Dscho
