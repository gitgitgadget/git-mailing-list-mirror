From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: valgrind
Date: Mon, 20 Apr 2009 20:34:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904202033220.6771@intel-tinevez-2-302>
References: <cover.1240249482u.git.johannes.schindelin@gmx.de> <f62793069ecb99138c435edf37533906c4aae301.1240249482u.git.johannes.schindelin@gmx.de> <872ACD6C-B99B-4BE4-BD7C-3A7B3255B3E1@petdance.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Andy Lester <andy@petdance.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:36:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvyMA-0003uB-Hm
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 20:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbZDTSfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 14:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752562AbZDTSfE
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 14:35:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:59552 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750966AbZDTSfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 14:35:03 -0400
Received: (qmail invoked by alias); 20 Apr 2009 18:34:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp042) with SMTP; 20 Apr 2009 20:34:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18suZB5jhYsMc6PUbkTkXKTzPyeShWL0m2zjyjkr0
	Q1egPHC83KPArv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <872ACD6C-B99B-4BE4-BD7C-3A7B3255B3E1@petdance.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117017>

Hi,

On Mon, 20 Apr 2009, Andy Lester wrote:

> On Apr 20, 2009, at 12:44 PM, Johannes Schindelin wrote:
> 
> >Found by valgrind.
> 
> How are you running valgrind?  Do you have a test suite for it?  A make 
> target?

Yes, it was merged into Git:

http://repo.or.cz/w/alt-git.git?a=commitdiff;h=8a61097cde387870921e822bdf90b4ffd3792845

Hth,
Dscho
