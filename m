From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Hash algorithm choice
Date: Sun, 9 Aug 2009 19:49:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908091949090.8306@pacific.mpi-cbg.de>
References: <f448a46a0908090907v68542e4dw1f1c4f610cb46ca2@mail.gmail.com> <f448a46a0908090917s102b4c83pbad6f298a8e127cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jerome Baum <jerome@jeromebaum.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 19:49:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaCWI-0000Hw-3H
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 19:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbZHIRtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 13:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbZHIRtP
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 13:49:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:42106 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752446AbZHIRtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 13:49:14 -0400
Received: (qmail invoked by alias); 09 Aug 2009 17:49:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 09 Aug 2009 19:49:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19szE4+Qc5siFKPMP58GmLtd+Jz7V2vai2WsJHt7b
	RPiazvSTI47Im8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <f448a46a0908090917s102b4c83pbad6f298a8e127cc@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125356>

Hi,

On Sun, 9 Aug 2009, Jerome Baum wrote:

> I just had an idea regarding git and hashing. Couldn't find any previous 
> discussion on the subject so here's what I'm thinking of:
> 
> How difficult would it be to allow users to choose a hash function 
> during git-init which is then globally used in the repo? Are there many 
> changes needed or are changes in git-hash-object and git-init 
> sufficient?

A quick search revealed this:

http://thread.gmane.org/gmane.comp.version-control.git/25632/focus=25735

Hth,
Dscho
