From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document --ignore-if-in-upstream in git-format-patch
Date: Thu, 18 Jan 2007 15:18:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701181518150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8764b4fuc8.fsf@morpheus.local>
 <Pine.LNX.4.63.0701181437200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <87wt3ke82t.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1992434887-1169129927=:22628"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 15:18:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Y6N-0000rP-Ej
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 15:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbXAROSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 09:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbXAROSt
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 09:18:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:43160 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752040AbXAROSt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 09:18:49 -0500
Received: (qmail invoked by alias); 18 Jan 2007 14:18:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 18 Jan 2007 15:18:48 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <87wt3ke82t.fsf@morpheus.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37095>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1992434887-1169129927=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 18 Jan 2007, David Kågedal wrote:

> +--ignore-if-in-upstream::
> +       Do not include a patch that matches a commit in
> +       <until>..<since>.  This will examine all patches reachable
> +       from <since> but not from <until> and compare them with the
> +       patches being generated, and any patch that matches is
> +       ignored.

Melikes.

---1148973799-1992434887-1169129927=:22628--
