From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Mon, 22 Mar 2010 11:58:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003221155200.7596@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302> <alpine.DEB.2.00.1003221012290.11364@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Mar 22 11:59:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtfLY-0000ag-C2
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 11:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548Ab0CVK6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 06:58:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:39346 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754538Ab0CVK6x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 06:58:53 -0400
Received: (qmail invoked by alias); 22 Mar 2010 10:58:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 22 Mar 2010 11:58:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/llrlVOzXlzifDXpRWcIyrp2DzCtM0RAHI5CdfQS
	chW7RE5oPtTpZn
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.2.00.1003221012290.11364@ds9.cixit.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142916>

Hi,

On Mon, 22 Mar 2010, Peter Krefting wrote:

> Johannes Schindelin:
> 
> > Git Release Notes (Git-1.7.0.2-preview20100309)
> > Last update: 9 March 2010
> 
> The redesigned installer seems to have lost the option to choose to use 
> Putty over OpenSSH, is there any documentation on how to set it up to 
> use Putty anyway?

Support for Putty has not been taken away, but it caused us so many 
problems (because people cannot easily accept new host keys). So it is 
only offered if you proved that you can accept new host keys yourself, and 
saved a session.

Hth,
Dscho
