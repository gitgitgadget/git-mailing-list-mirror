From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git clone needs to know executability of template
 files
Date: Thu, 19 Mar 2009 11:57:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903191157120.10279@pacific.mpi-cbg.de>
References: <81b0412b0903190328n17007b4alcf5d91db562db62b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 11:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkFw8-0001Sn-75
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 11:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbZCSKzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 06:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbZCSKzu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 06:55:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:47816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751315AbZCSKzt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 06:55:49 -0400
Received: (qmail invoked by alias); 19 Mar 2009 10:55:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 19 Mar 2009 11:55:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18k00woudEkS7FO/rGCd65nWUn+rqnCc6lLzT1ygm
	3fBAUE+1Xu+u5q
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81b0412b0903190328n17007b4alcf5d91db562db62b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113755>

Hi,

On Thu, 19 Mar 2009, Alex Riesen wrote:

> Use posix_lstat for template source.
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---

As this patch builds on top of your earlier patch, you should have made a 
patch series.

But as I said, I think it is wrong.

Ciao,
Dscho
