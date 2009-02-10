From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFH: spawning pager takes long time when when unconnected from
 network
Date: Tue, 10 Feb 2009 11:24:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101124160.10279@pacific.mpi-cbg.de>
References: <loom.20090210T015515-886@post.gmane.org> <4991337B.2010102@viscovery.net> <loom.20090210T085859-630@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Raible <raible+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 11:25:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWpnq-0004v7-Hz
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 11:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbZBJKXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 05:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbZBJKXv
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 05:23:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:42888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751252AbZBJKXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 05:23:51 -0500
Received: (qmail invoked by alias); 10 Feb 2009 10:23:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 10 Feb 2009 11:23:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18XR8If2KwXv0okijLqN5ep5k9Rq3nBw7sDRXgICo
	Ns4tip15cMmS/t
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <loom.20090210T085859-630@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109196>

Hi,

On Tue, 10 Feb 2009, Eric Raible wrote:

> Johannes Sixt <j.sixt <at> viscovery.net> writes:
> 
> > Do you have a directory in your PATH that points to a disconnected network
> > drive? Do you use the default pager settings, or did you customize the pager?
> 
> All components in my path are local.

Could you run it with GIT_TRACE=<file>?

Ciao,
Dscho
