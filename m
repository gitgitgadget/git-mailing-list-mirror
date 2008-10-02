From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] format-patch: autonumber by default
Date: Thu, 2 Oct 2008 14:33:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810021433130.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1222946860-15518-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 14:28:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlNIX-0007L5-7H
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 14:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbYJBM1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 08:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbYJBM1i
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 08:27:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:33875 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753216AbYJBM1i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 08:27:38 -0400
Received: (qmail invoked by alias); 02 Oct 2008 12:27:36 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 02 Oct 2008 14:27:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HLa4qd8XHDfxn4FK1+lphaNWP6ARfQTpfSeb8++
	Hl8CB/moyl7MjI
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1222946860-15518-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97319>

Hi,

On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:

> Set auto-number true by default, allowing the format.number key to be
> set to 'noauto' to override this.
> ---
>  builtin-log.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Interesting.  No sign-off, no defense why this is actually desirable, 
after we lived for so long without this behavior... Care to elaborate?

Ciao,
Dscho
