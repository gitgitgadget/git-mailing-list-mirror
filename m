From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH] 1/2 : (reworked) Externalizable/Serializable
 Items
Date: Mon, 16 Feb 2009 21:16:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902162115350.6289@intel-tinevez-2-302>
References: <320075ff0902161212s1980cd70r8cdc4c21550333ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git ML <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 21:53:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZASt-0005ia-53
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 21:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbZBPUvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 15:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbZBPUvr
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 15:51:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:52545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751518AbZBPUvq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 15:51:46 -0500
Received: (qmail invoked by alias); 16 Feb 2009 20:16:07 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp068) with SMTP; 16 Feb 2009 21:16:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+pY8J0Usiph8bZIq6lU2QC+7Z3R/16NUeUmgappu
	hEsvrgZu+GPFJz
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <320075ff0902161212s1980cd70r8cdc4c21550333ee@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110238>

Hi,

On Mon, 16 Feb 2009, Nigel Magnay wrote:

> JGit is used as a library in external projects such as build tools.
> Some of the representations of git data structures are useful
> in these external tools - but - it is often desirable to be able to
> either persist these objects, or serialize them across the wire.

I am still missing the description of the format.

>  Signed-off-by: Nigel Magnay <nigel.magnay@gmail.com>

And I wonder what that leading space is all about.

Ciao,
Dscho
