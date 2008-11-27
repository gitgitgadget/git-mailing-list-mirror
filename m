From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add / command in add --patch (feature request)
Date: Thu, 27 Nov 2008 02:46:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811270245210.30769@pacific.mpi-cbg.de>
References: <492DB6C8.7010205@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 02:39:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Vqt-0006iV-DP
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 02:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbYK0BiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 20:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbYK0BiK
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 20:38:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:35084 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751157AbYK0BiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 20:38:09 -0500
Received: (qmail invoked by alias); 27 Nov 2008 01:38:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 27 Nov 2008 02:38:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+g5ZVPKi2guS1fYIBwUSeUjpyKTZndcsWcpTR5f/
	6aLfDlOupzTXoU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <492DB6C8.7010205@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101785>

Hi,

On Wed, 26 Nov 2008, William Pursell wrote:

> This sequence of 2 patches adds a '/' command to
> add --patch that allows the user to search for
> a hunk that matches a regex, and deals with j,k slightly
> more gracefully.  (Rather than printing the
> help menu if k is invalid, it will print
> a relevant error message.)

I find these references to j and k not only confusing, but slightly 
unnerving.  Care to be a bit more explicit?

> (Please CC me in any response)

Always on this list; we respect netiquette.

Ciao,
Dscho
