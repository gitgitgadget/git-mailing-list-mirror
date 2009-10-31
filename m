From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: ef/msys-imap, was Re: What's cooking in git.git (Oct 2009, #06; Fri,
 30)
Date: Sat, 31 Oct 2009 13:12:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910311311060.4985@pacific.mpi-cbg.de>
References: <7vljis9pks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 13:09:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Clh-0000ms-JV
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 13:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbZJaMJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 08:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757610AbZJaMJH
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 08:09:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:53800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757590AbZJaMJF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 08:09:05 -0400
Received: (qmail invoked by alias); 31 Oct 2009 12:09:09 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 31 Oct 2009 13:09:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/W8RgSyD3WhccO0a7vthCjAqy03TD+oJerIB0aR8
	bmyKb/cn36uyXj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vljis9pks.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131842>

Hi,

On Fri, 30 Oct 2009, Junio C Hamano wrote:

> * ef/msys-imap (2009-10-22) 9 commits.
>  - Windows: use BLK_SHA1 again
>  - MSVC: Enable OpenSSL, and translate -lcrypto
>  - mingw: enable OpenSSL
>  - mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
>  - imap-send: build imap-send on Windows
>  - imap-send: fix compilation-error on Windows
>  - imap-send: use run-command API for tunneling
>  - imap-send: use separate read and write fds
>  - imap-send: remove useless uid code
> 
> This is pulled from J6t; I'll merge it to 'next' if Dscho is Ok with it.

Dscho is Ok with it.

Ciao,
Dscho
