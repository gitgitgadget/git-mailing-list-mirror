From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] http-push: append slash if possible for
 directories
Date: Sat, 17 Jan 2009 06:19:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901170618540.3586@pacific.mpi-cbg.de>
References: <be6fef0d0901161853y6784310dgf94dadb2218001a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 06:24:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO3f8-0000jw-GA
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 06:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbZAQFTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 00:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbZAQFTD
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 00:19:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:34042 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751175AbZAQFTC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 00:19:02 -0500
Received: (qmail invoked by alias); 17 Jan 2009 05:18:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 17 Jan 2009 06:18:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0yMZnPn30QKGar9VKZs486k/dfKVjujg3YaIxRb
	IRPOd/sFZkNM9+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <be6fef0d0901161853y6784310dgf94dadb2218001a1@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106026>

Hi,

On Sat, 17 Jan 2009, Ray Chuan wrote:

>  src/git-1.6.1/http-push.c |   21 ++++++++++++++++-----

That is a, uhm, creative way of using Git...

Ciao,
Dscho
