From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Thu, 29 Jan 2009 15:02:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901291449150.3586@pacific.mpi-cbg.de>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 15:04:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSXUy-00044m-Kr
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 15:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbZA2OC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbZA2OC0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:02:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:53671 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751289AbZA2OCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:02:25 -0500
Received: (qmail invoked by alias); 29 Jan 2009 14:02:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 29 Jan 2009 15:02:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FZB1d2gLFtMoQu4lkyBReGuxRIE2eDbiiFqqj6T
	Y6EsVjdvjlqu5t
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107677>

Hi,

On Thu, 29 Jan 2009, Johannes Schindelin wrote:

> 	This is a companion patch to the one I sent earlier:
> 
> 	http://article.gmane.org/gmane.comp.version-control.git/13735

Hmm, maybe I should explain a little better.

That patch tried to make 'git pull' more convenient, that you could set up 
tracking information with a single flag to an explicit pull.

This patch does the same for 'git push', although I agree that the 'pull' 
patch should be done rather differently.

Ciao,
Dscho
