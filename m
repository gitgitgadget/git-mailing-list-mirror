From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix symlink __stdcall problem at MSVC
Date: Thu, 20 Aug 2009 15:47:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908201546500.4719@intel-tinevez-2-302>
References: <1250774680-4720-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 15:47:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me7zP-0006kO-La
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbZHTNrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 09:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754168AbZHTNrN
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:47:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:39646 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753772AbZHTNrM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:47:12 -0400
Received: (qmail invoked by alias); 20 Aug 2009 13:47:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp042) with SMTP; 20 Aug 2009 15:47:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oIrBPP/XoGuVg2XgiQCszoDgDK0bNL68ghCdOHh
	p16z6hspfZ1HeK
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250774680-4720-1-git-send-email-lznuaa@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126620>

Hi,

On Thu, 20 Aug 2009, Frank Li wrote:

> MSVC requires that __stdcall be between return value and function name.
> Further, all Win32 API definitions look like this:
> 
> Signed-off-by: Frank Li <lznuaa@gmail.com>
> ---

Like what?  Seems you did not paste my complete commit message.

Ciao,
Dscho
