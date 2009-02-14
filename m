From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sat, 14 Feb 2009 23:54:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142353530.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de> <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de> <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com>
 <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de> <gn7h17$o6t$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 23:55:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYTPi-0005uI-79
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 23:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbZBNWxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 17:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbZBNWxm
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 17:53:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:53691 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752148AbZBNWxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 17:53:42 -0500
Received: (qmail invoked by alias); 14 Feb 2009 22:53:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 14 Feb 2009 23:53:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18J1gZi47AJooY3wZBFhVmVJ88tonfDVpoAxa3NLK
	A3ufu3xjGyHCCv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <gn7h17$o6t$1@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109948>

Hi,

please do not cull the Cc: list.

On Sat, 14 Feb 2009, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> >> You mean fail if -e or -l have extra arguments?
> > 
> > Yes.
> 
> '-l' can have extra arguments: '-z'

We meant "non-option argument".

Ciao,
Dscho
