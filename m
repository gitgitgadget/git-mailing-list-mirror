From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cvsimport: add support for cvs pserver password
 scrambling.
Date: Mon, 1 Dec 2008 14:43:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812011442530.30769@pacific.mpi-cbg.de>
References: <5794AED2-43FF-4441-8292-0C9BFB3139A2@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1235365464-1228138997=:30769"
Cc: git <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Dirk_H=F6rner?= <dirker@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 14:36:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L78wi-0002ZX-NU
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 14:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbYLANe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 08:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbYLANe7
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 08:34:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:52935 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980AbYLANe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 08:34:58 -0500
Received: (qmail invoked by alias); 01 Dec 2008 13:34:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 01 Dec 2008 14:34:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18X25483y8Xzwz2JYPFkyQ26K7WzlPM+j/xGqe0W0
	P2TYWhn65X29jV
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <5794AED2-43FF-4441-8292-0C9BFB3139A2@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102032>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1235365464-1228138997=:30769
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 28 Nov 2008, Dirk Hörner wrote:

> Instead of a cleartext password, the CVS pserver expects a scrambled one 
> in the authentication request. With this patch it is possible to import 
> CVS repositories only accessible via pserver and user/password.

The patch looks obvious enough; care to add a testcase?

Ciao,
Dscho
--8323328-1235365464-1228138997=:30769--
