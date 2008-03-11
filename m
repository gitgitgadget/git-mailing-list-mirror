From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/10] Make get_git_dir() and 'git rev-parse --git-dir'
 absolute path
Date: Tue, 11 Mar 2008 14:20:37 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111420080.3873@racer.site>
References: <cover.1204453703.git.pclouds@gmail.com> <20080302103348.GA8929@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-736050073-1205241638=:3873"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 14:21:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ4Q1-0004F8-Le
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbYCKNUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbYCKNUk
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:20:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:33523 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753403AbYCKNUd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:20:33 -0400
Received: (qmail invoked by alias); 11 Mar 2008 13:20:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 11 Mar 2008 14:20:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PA99HynQPdy9GLyyITPj4RKp1eoW/8Wn/B9UEdg
	/PY8DA/ezb7W1T
X-X-Sender: gene099@racer.site
In-Reply-To: <20080302103348.GA8929@laptop>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76840>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-736050073-1205241638=:3873
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 2 Mar 2008, Nguyễn Thái Ngọc Duy wrote:

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

I do not like this change.  It is IMO completely unnecessary, and might 
break assumptions.

Ciao,
Dscho

--8323584-736050073-1205241638=:3873--
