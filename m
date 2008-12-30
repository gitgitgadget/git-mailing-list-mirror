From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: why still no empty directory support in git
Date: Tue, 30 Dec 2008 13:09:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812301308530.30769@pacific.mpi-cbg.de>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 13:10:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHdQN-0004ug-Q2
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 13:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbYL3MI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 07:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbYL3MIz
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 07:08:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:40627 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751538AbYL3MIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 07:08:55 -0500
Received: (qmail invoked by alias); 30 Dec 2008 12:08:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 30 Dec 2008 13:08:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190PyNM+Gp0o7iSjLFSaqY2PBjKU/itb406Q9Eq/T
	mefGcdmOYbXRQa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104176>

Hi,

On Tue, 30 Dec 2008, Ping Yin wrote:

> Yes, i know this topic has been discussed for many times.

We have empty directory support in Git.  It works like this: for 
directories that you do want to keep, you add an empty .gitignore file.

No problem at all,
Dscho
