From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] What's the best UI for 'git submodule split'?
Date: Thu, 12 Feb 2009 22:59:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902122258060.10279@pacific.mpi-cbg.de>
References: <431341160902121348n71df3185p2ec998c297d449fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Kidd <git@randomhacks.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 23:00:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXjbK-0003g7-U2
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 23:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760000AbZBLV6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759437AbZBLV6l
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:58:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:50777 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758113AbZBLV6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:58:40 -0500
Received: (qmail invoked by alias); 12 Feb 2009 21:58:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 12 Feb 2009 22:58:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+o//wXRWuow47E0SpIl4zz4aVt2rr3WsI9Lg5x4q
	671Mbw9WGDXOhD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <431341160902121348n71df3185p2ec998c297d449fc@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109670>

Hi,

On Thu, 12 Feb 2009, Eric Kidd wrote:

>   rm .git/refs/original # or just use --force below

BTW I wanted to get rid of this for a long time now, but I cannot seem to 
find the time to work on it.  The 'original' refs should not be needed, as 
that's a job for the reflogs (yeah, people tried to convince me back then, 
but I finally got it, okay?)

Ciao,
Dscho
