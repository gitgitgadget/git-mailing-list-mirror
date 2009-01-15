From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] checkout: implement "-" shortcut name for last
 branch
Date: Thu, 15 Jan 2009 15:17:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <496EE559.3060901@viscovery.net> <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de> <200901151500.01876.trast@student.ethz.ch> <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:18:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNT3J-0000a4-He
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758835AbZAOORJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 09:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759679AbZAOORH
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:17:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:60078 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756346AbZAOORG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 09:17:06 -0500
Received: (qmail invoked by alias); 15 Jan 2009 14:17:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 15 Jan 2009 15:17:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+H2H4DVTuHKHddbvy6ifvGoWzAzG8b3KZeXqSrAo
	UxeJbNhA2XxJ4+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105818>

Hi,

On Thu, 15 Jan 2009, Johannes Schindelin wrote:

> [PATCH] pack-objects --all: include HEAD, which could be detached

In hind sight, it would probably be better to add this to revision.c.

Ciao,
Dscho
