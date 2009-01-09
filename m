From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: gitweb index performance (Re: [PATCH] gitweb: support the
 rel=vcs-* microformat)
Date: Fri, 9 Jan 2009 01:19:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901090118431.30769@pacific.mpi-cbg.de>
References: <20090107042518.GB24735@gnu.kitenet.net> <gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net> <cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com> <20090107184515.GB31795@gnu.kitenet.net> <20090107190238.GA3909@gnu.kitenet.net>
 <20090107232427.GA18958@gnu.kitenet.net> <gk4bk5$9dq$1@ger.gmane.org> <20090108195446.GB18025@gnu.kitenet.net> <496691EC.1070805@eaglescrag.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Jan 09 01:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL56d-0006mw-0P
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 01:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813AbZAIASn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 19:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbZAIASn
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 19:18:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:44073 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751877AbZAIASm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 19:18:42 -0500
Received: (qmail invoked by alias); 09 Jan 2009 00:18:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 09 Jan 2009 01:18:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192NFgjPwl2DIABDT7sv4aSXhLvCTcAj+GJ5KH3IA
	pEXjb/gEGUkuY3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <496691EC.1070805@eaglescrag.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104973>

Hi,

On Thu, 8 Jan 2009, J.H. wrote:

> Look at either Lea's or my caching engines, it will help dramatically on 
> something of that size.

Speaking of which, do you have any performance comparisons between the 
two?

Ciao,
Dscho
