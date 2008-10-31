From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 23:53:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810312352120.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com> <20081031183601.GB8464@artemis.corp> <20081031183933.GA3577@sigill.intra.peff.net> <200810312035.20016.fg@one2team.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Francis Galiegue <fg@one2team.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:47:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw2mM-0005G9-Bb
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYJaWq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYJaWq3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:46:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:53782 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751893AbYJaWq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 18:46:28 -0400
Received: (qmail invoked by alias); 31 Oct 2008 22:46:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp031) with SMTP; 31 Oct 2008 23:46:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19L3zFAvndLB/LSuP8kZqTs9SRwJpitKHfW1DD1LN
	XbByR0Zd8GqCfz
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <200810312035.20016.fg@one2team.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99667>

Hi,

On Fri, 31 Oct 2008, Francis Galiegue wrote:

> Unless I'm mistaken (and I probably am), the $(...) construct is 
> bash-specific, isn't it?

You're mistaken,
Dscho

P.S.: 
http://www.opengroup.org/onlinepubs/000095399/utilities/xcu_chap02.html#tag_02_06_03
