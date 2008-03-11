From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: commit 0? (or: create new empty branch)
Date: Tue, 11 Mar 2008 13:52:00 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111350550.3873@racer.site>
References: <20080311123004.GA27577@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 13:52:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ3yD-0003dJ-NK
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 13:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbYCKMv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 08:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbYCKMv5
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 08:51:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:44115 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753432AbYCKMv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 08:51:57 -0400
Received: (qmail invoked by alias); 11 Mar 2008 12:51:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 11 Mar 2008 13:51:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186NHdzhoc6LHMMGWvTRUf7QiOdSP/djJXBNSJKjF
	Y7rS45B2DFF5ac
X-X-Sender: gene099@racer.site
In-Reply-To: <20080311123004.GA27577@bit.office.eurotux.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76836>

Hi,

On Tue, 11 Mar 2008, Luciano Rocha wrote:

> I'd like to create a new branch, without any pre-existing data, for
> purposes similar to git's html/man/.....

If there is nothing to branch from, there is nothing to branch from.

You might want to rename your branch (once you have something).

But then, I do not even understand why you bother.  You can always push to 
a branch of a different name, and have your principal branch being 
"master" locally.

Hth,
Dscho
