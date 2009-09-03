From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH 0/5] jgit diff
Date: Thu, 3 Sep 2009 12:48:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909031247310.4409@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0909030846230.8306@pacific.mpi-cbg.de> <cover.1251974493u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Sep 03 12:48:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj9re-00005V-To
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 12:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbZICKsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 06:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbZICKsN
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 06:48:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:49325 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752080AbZICKsN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 06:48:13 -0400
Received: (qmail invoked by alias); 03 Sep 2009 10:48:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 03 Sep 2009 12:48:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MLH4nJU7MPCul77oAPhdaLa2VnXqE+pzLznb8C5
	AH/KDZ132evJLy
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1251974493u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127650>

Hi,

On Thu, 3 Sep 2009, Johannes Schindelin wrote:

> This patch series provides a rudimentary, working implementation of 
> "jgit diff".  It does not provide all modes of "git diff" -- by far! -- 
> but it is robust, and should provide a good starting point for further 
> work.

I forgot to mention that this is rebased to current jgit.git's master (and 
tested there, too; took 713 seconds on this here machine).

Ciao,
Dscho
