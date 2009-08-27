From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Use a 16-tree instead of a 256-tree for storing notes
Date: Thu, 27 Aug 2009 13:56:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908271356020.7562@intel-tinevez-2-302>
References: <1248834326-31488-1-git-send-email-johan@herland.net>  <200908261231.01616.johan@herland.net>  <81b0412b0908260505m233d9a5cmefdd81e1ef51a299@mail.gmail.com>  <200908261456.55906.johan@herland.net> <81b0412b0908260624v30d32cc1m96e798076b51cbc9@mail.gmail.com>
 <4A95383A.4080104@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	gitster@pobox.com, trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Aug 27 13:56:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgdb2-0007RU-M2
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 13:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbZH0L4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 07:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbZH0L4k
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 07:56:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:59863 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750963AbZH0L4k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 07:56:40 -0400
Received: (qmail invoked by alias); 27 Aug 2009 11:56:40 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp050) with SMTP; 27 Aug 2009 13:56:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ES8Zlt6CEv9IrwUh2HIOKhs1YshoAmPt8v5LlBl
	k+p1HgMWdvb7CB
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A95383A.4080104@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127156>

Hi,

On Wed, 26 Aug 2009, Andreas Ericsson wrote:


> If it's to be squashed in, why mention the 256-tree at all

It was labeled RFC, so I think it is perfectly fine to compare with other 
contenders.

Thanks,
Dscho
