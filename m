From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 2/2] MSVC: Fix an "incompatible pointer types"
 compiler warning
Date: Sat, 5 Dec 2009 15:57:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912051556290.4985@pacific.mpi-cbg.de>
References: <4B1997A0.9000004@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Dec 05 15:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGw08-0008T3-PY
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 15:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbZLEOwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 09:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755531AbZLEOwh
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 09:52:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:43183 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754654AbZLEOwg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 09:52:36 -0500
Received: (qmail invoked by alias); 05 Dec 2009 14:52:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 05 Dec 2009 15:52:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ik7E5rNUIL0Acl5vK1NZHYHurpo6LFu1htgo8DQ
	wybbPa6sol6u3A
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B1997A0.9000004@ramsay1.demon.co.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134602>

Hi,

On Fri, 4 Dec 2009, Ramsay Jones wrote:

> Changes from v1:
>     - moved the new declarations to msvc.h rather than clutter mingw.h
>       with msvc related code.

Thanks,
Dscho
