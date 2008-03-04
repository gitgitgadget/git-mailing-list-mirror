From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-submodule: Make update verbose for up to date path
Date: Tue, 4 Mar 2008 15:04:02 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041503360.22527@racer.site>
References: <1204642691-3220-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 16:06:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWYhs-0000UT-Am
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 16:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475AbYCDPEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 10:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756410AbYCDPEu
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 10:04:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:56033 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750941AbYCDPEu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 10:04:50 -0500
Received: (qmail invoked by alias); 04 Mar 2008 15:04:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp026) with SMTP; 04 Mar 2008 16:04:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GjY19ep/GGaPaQ9prCoHFnX90PV7N6pc1OX80SK
	y6enIYspDSNfnT
X-X-Sender: gene099@racer.site
In-Reply-To: <1204642691-3220-1-git-send-email-pkufranky@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76096>

Hi,

On Tue, 4 Mar 2008, Ping Yin wrote:

> When 'git submodule update' runs for multiple modules, give 'up to date'
> info for up to date modules should be a good idea to show the progress.

Does this not go contrary to our efforts to make Git less chatty?  See 
e.g. the output of push and fetch...

Ciao,
Dscho
