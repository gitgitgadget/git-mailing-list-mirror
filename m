From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] color-words: fix quoting in t4034
Date: Wed, 14 Jan 2009 23:41:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901142341420.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901142104400.3586@pacific.mpi-cbg.de> <3ff3ccf6e3c1cd6a002d200aee5df88a197a7bf6.1231971446.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 14 23:43:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNERr-0007bd-39
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759789AbZANWlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759683AbZANWlK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:41:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:44545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759511AbZANWlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:41:09 -0500
Received: (qmail invoked by alias); 14 Jan 2009 22:41:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 14 Jan 2009 23:41:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mRyca/k9m6/QqU6aqUOZu96WGaI5nr/6AeZxSyI
	/pp5Fnr3iqLNsy
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3ff3ccf6e3c1cd6a002d200aee5df88a197a7bf6.1231971446.git.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105722>

Hi,

On Wed, 14 Jan 2009, Thomas Rast wrote:

> Since the single quotes match the ones used to quote the test text
> itself, they'd be dropped.  Use double quotes instead.

See, I suck with quoting.

> ---
> 
> I'd squash this into Dscho's 4/4, so no SoB.

Sure, done.

Thanks,
Dscho
