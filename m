From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: pruning recipe for destructive
 filter-branch
Date: Sat, 14 Feb 2009 12:48:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902141248220.10279@pacific.mpi-cbg.de>
References: <1234545279-23153-1-git-send-email-trast@student.ethz.ch> <20090214025115.615119bf@perceptron> <alpine.DEB.1.00.0902140642520.10279@pacific.mpi-cbg.de> <20090214074954.7e423dd2@perceptron>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-742129532-1234612141=:10279"
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Feb 14 12:49:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYJ1e-0003Uf-VW
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 12:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbZBNLsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 06:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbZBNLsK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 06:48:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:49831 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751337AbZBNLsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 06:48:09 -0500
Received: (qmail invoked by alias); 14 Feb 2009 11:48:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 14 Feb 2009 12:48:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GjCMeTd4GBJHHooy1XGZYNA9bjwrbGS312h+UKU
	j27mXcrfI4hD/j
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090214074954.7e423dd2@perceptron>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109863>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-742129532-1234612141=:10279
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 14 Feb 2009, Jan Krüger wrote:

> Subject: [PATCH] gc: add --prune-expire option equivalent to gc.pruneExpire

I like it, and if nobody beats me to it, I will add a test for this 
option tonight.

Ciao,
Dscho
--8323328-742129532-1234612141=:10279--
