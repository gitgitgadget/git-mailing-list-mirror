From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Include log_config module in apache.conf
Date: Wed, 11 Mar 2009 20:45:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903112044440.10279@pacific.mpi-cbg.de>
References: <alpine.LNX.1.00.0903102320170.19665@iabervon.org> <alpine.DEB.1.00.0903111240150.10279@pacific.mpi-cbg.de> <7vab7r6g59.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 20:45:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhUMh-00072S-CE
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 20:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbZCKTna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 15:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZCKTna
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 15:43:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:49223 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751256AbZCKTn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 15:43:29 -0400
Received: (qmail invoked by alias); 11 Mar 2009 19:43:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 11 Mar 2009 20:43:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KTstL6xwK5rGEgEZvBjUHSTZzY/Gf9sp6xr/HWO
	WchAnzMw1N3QwJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vab7r6g59.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112968>

Hi,

On Wed, 11 Mar 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Sorry, no:
> >
> > -- snip --
> > apache2: Syntax error on line 7 of 
> > /home/schindelin/git/t/lib-httpd/apache.conf: module log_config_module is 
> > built-in and can't be loaded
> > -- snap --
> 
> Sorry and thanks---I'll apply an interdiff and credit it to you.

Thanks...

Ciao,
Dscho
