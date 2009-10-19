From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fsck not identifying corrupted packs
Date: Mon, 19 Oct 2009 12:04:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de>
References: <loom.20091019T094924-194@post.gmane.org> <4ADC2D45.3020803@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sergio Callegari <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 12:01:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzp3o-0005W8-2g
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 12:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbZJSKBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 06:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754077AbZJSKBm
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 06:01:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:37677 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753830AbZJSKBl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 06:01:41 -0400
Received: (qmail invoked by alias); 19 Oct 2009 10:01:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 19 Oct 2009 12:01:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+CO0ZVh1qCJ7Z3BJ3St9HuHBEOpMxpSu6LzNZkvt
	7WqG24W+t4G3yl
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4ADC2D45.3020803@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130686>

Hi,

On Mon, 19 Oct 2009, Johannes Sixt wrote:

> Sergio Callegari schrieb:
> > Is there a means to have fsck to a truly full check on the sanity of a 
> > repo?
> 
> git fsck --full
> 
> RTFM, please.

Now, now.

If you were to test a new filesystem, say, wonderfulfs, and wanted to 
check its integrity, would you not just run "fsck-wonderfulfs" if that 
exists, rather than reading the fantamagastic manual?  Would you not 
expect that it Does The Right Thing?  Would you not expect that it 
follows the Law Of Minimal Surprise?

So FWIW I can see where Sergio is coming from.

Ciao,
Dscho
