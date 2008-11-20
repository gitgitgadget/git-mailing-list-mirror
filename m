From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fatal: did you run git update-server-info on the server? mv
 post-update.sample post-update
Date: Thu, 20 Nov 2008 12:05:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811201204300.30769@pacific.mpi-cbg.de>
References: <155056.88492.qm@web37905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 11:58:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L37Ey-0004AV-Ky
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 11:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbYKTK5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 05:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbYKTK5I
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 05:57:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:39284 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752995AbYKTK5H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 05:57:07 -0500
Received: (qmail invoked by alias); 20 Nov 2008 10:57:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 20 Nov 2008 11:57:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ylwxiXyyyM4T7GoTdqrDHrc/t7/NCRrF6jHfFmC
	sn1NrhddQZi7lT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <155056.88492.qm@web37905.mail.mud.yahoo.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101404>

Hi,

On Wed, 19 Nov 2008, Gary Yang wrote:

> I did not run post-update at public repository manually. Do I need to 
> run it for the very first time?

You need to run it when you installed the hook _after_ seeing the message 
"did you run...".

Ciao,
Dscho
