From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/1] Fix rebase -p --onto
Date: Wed, 22 Jul 2009 19:07:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907221905360.7343@intel-tinevez-2-302>
References: <20090722163738.GO7503@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 19:07:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTfHt-0005Uj-U9
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 19:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbZGVRHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 13:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbZGVRHU
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 13:07:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:37163 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751415AbZGVRHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 13:07:20 -0400
Received: (qmail invoked by alias); 22 Jul 2009 17:07:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp021) with SMTP; 22 Jul 2009 19:07:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ok009XfSO59pHRTh6QC05+Z2lsufgEqOhYVLEFR
	oXN/Rdevtc8A3q
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090722163738.GO7503@vinegar-pot.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123756>

Hi,

On Wed, 22 Jul 2009, Greg Price wrote:

> [...] when the great day comes that rebase -i -p can reorder commits 
> [...]

If you want to help, I would be so thankful.  In that case, it might make 
more sense to hold off this patch and integrate it into the rebase-i-p 
patch series, rather than requiring a rebase of rebase-i-p on top of your 
patches, which will postpone said day only further.

Ciao,
Dscho
