From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Cute bug in gitweb
Date: Thu, 5 Mar 2009 17:46:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903051744340.6524@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Jakub 'CC-me' Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:49:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfGlE-0006bx-09
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 17:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbZCEQq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 11:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754374AbZCEQq2
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 11:46:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:52456 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754180AbZCEQq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 11:46:28 -0500
Received: (qmail invoked by alias); 05 Mar 2009 16:46:25 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 05 Mar 2009 17:46:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+zQJJY9LezbMhPDFd8ihIrAGP5tiMrKeLUBuNmpb
	6QXAdqTZRaeQfT
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112319>

Hi,

this was just pointed out by one of my users: if you have a blob called 
'tree', gitweb's tree view displays '(base|diff)' just after the name of 
the blob.

Ciao,
Dscho
