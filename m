From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [TOY PATCH] filter-branch: add option --delete-unchanged
Date: Sat, 9 Aug 2008 02:35:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808090235130.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1218153031-18443-1-git-send-email-trast@student.ethz.ch> <1218226224-25273-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Wielemaker <J.Wielemaker@uva.nl>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Aug 09 02:32:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRcNU-0005eJ-5B
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 02:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbYHIAbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 20:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbYHIAbM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 20:31:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:39514 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751827AbYHIAbL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 20:31:11 -0400
Received: (qmail invoked by alias); 09 Aug 2008 00:31:09 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 09 Aug 2008 02:31:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vgJtzUNPvrE3FlpCRTKD5QJVygH0y4G1UDjKoB1
	3Y1pYGdTV/sRce
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1218226224-25273-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91732>

Hi,

On Fri, 8 Aug 2008, Thomas Rast wrote:

> With --delete-unchanged, we nuke refs whose targets did not change
> during rewriting.

Frankly, I do not see any value in this.  Not even with your explanation.

Ciao,
Dscho
