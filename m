From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 05/10] http-push: Avoid calling setup_git_directory()
 twice
Date: Tue, 11 Mar 2008 14:28:05 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111427400.3873@racer.site>
References: <cover.1204453703.git.pclouds@gmail.com> <20080302103419.GA8957@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-155414546-1205242085=:3873"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 14:28:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ4X4-0006dk-5H
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbYCKN2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbYCKN2B
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:28:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:42191 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750925AbYCKN2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:28:00 -0400
Received: (qmail invoked by alias); 11 Mar 2008 13:27:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 11 Mar 2008 14:27:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZO2F4irEZU8xqxPhIAWbj6/YxxDINkGkaf3Iaun
	/LZUK7ve3GhiXD
X-X-Sender: gene099@racer.site
In-Reply-To: <20080302103419.GA8957@laptop>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76843>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-155414546-1205242085=:3873
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 2 Mar 2008, Nguyễn Thái Ngọc Duy wrote:

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

This fix is completely independent of the rest of your series.

Ciao,
Dscho
--8323584-155414546-1205242085=:3873--
