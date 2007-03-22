From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Installation instructions for gitweb?
Date: Thu, 22 Mar 2007 19:11:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703221910350.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <etufpl$7en$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Mar 22 19:11:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HURks-0002kg-NR
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 19:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbXCVSLP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 14:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934176AbXCVSLP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 14:11:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:54263 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934170AbXCVSLO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 14:11:14 -0400
Received: (qmail invoked by alias); 22 Mar 2007 18:11:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 22 Mar 2007 19:11:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18txTogVGotvYvc1PtJQJBkXgOgsC4gbygPhEmQha
	Dg7W9aW41DWehp
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <etufpl$7en$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42875>

Hi,

On Thu, 22 Mar 2007, Han-Wen Nienhuys wrote:

> I'm trying to get gitweb to serve my local repositories on the intranet 
> here, but I am not successful in getting it to run.  I got as far as 
> getting gitweb page, containing no projects but only "403 forbidden - No 
> projects found." I tried setting the projects_list to a directory, a 
> subdirectory, a file with the projects to be published, etc.
> 
> Is there a guide on setting up gitweb for hare-brained people like me
> that don't know apache and don't know perl? In particular, the format of
> gitweb_conf.perl is not documented at all.

I never got to install gitweb myself. Instead, I used git-instaweb quite 
successfully...

Ciao,
Dscho
