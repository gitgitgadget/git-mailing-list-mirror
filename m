From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fatal: git write-tree failed to write a tree
Date: Sun, 1 Mar 2009 22:10:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903012210230.10279@pacific.mpi-cbg.de>
References: <81bfc67a0902280825t507e385bvd25c846add2a299c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 22:10:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldsw4-00071F-Q0
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 22:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbZCAVJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 16:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbZCAVJ1
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 16:09:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:34274 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753438AbZCAVJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 16:09:27 -0500
Received: (qmail invoked by alias); 01 Mar 2009 21:09:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp022) with SMTP; 01 Mar 2009 22:09:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XdapeM4KXITA1hw2yPUAzlMm7qwU5mpfax8AiEv
	qqblgAbsEHN3oc
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81bfc67a0902280825t507e385bvd25c846add2a299c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111871>

Hi,

On Sat, 28 Feb 2009, Caleb Cushing wrote:

> profiles/package.mask/java-overlay: unmerged
> (f67eeb638e2593b2bee5c9b476e3044a8404916a)
> fatal: git write-tree failed to write a tree

A tree cannot contain unmerged files.

Ciao,
Dscho
