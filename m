From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow '+', '-' and '.' in remote helper names
Date: Tue, 23 Feb 2010 15:42:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002231541431.3980@intel-tinevez-2-302>
References: <1266928428-19075-1-git-send-email-ilari.liusvaara@elisanet.fi>  <alpine.DEB.1.00.1002231402350.3980@intel-tinevez-2-302>  <4B83D5CC.9030206@viscovery.net> <40aa078e1002230532n6e692fd0p8fa5d599c21a1873@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 23 15:42:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njvxr-0007Mt-Cw
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 15:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab0BWOmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 09:42:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:51648 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753042Ab0BWOmL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 09:42:11 -0500
Received: (qmail invoked by alias); 23 Feb 2010 14:42:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp029) with SMTP; 23 Feb 2010 15:42:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QpyEY1M5QT2SY8riIcSEPq3tLZ1yfzWGgXQc+jX
	mIYMha5KPR5Abh
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <40aa078e1002230532n6e692fd0p8fa5d599c21a1873@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140803>

Hi,

On Tue, 23 Feb 2010, Erik Faye-Lund wrote:

> On Tue, Feb 23, 2010 at 2:19 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> > Johannes Schindelin schrieb:
> >> May I caution against allowing "+" as part of filenames? On Windows,
> >> thanks to the DOS garb^Wheritage, "+" is not really allowed...
> >
> > I don't think that's true (and I also think it never was).
> >
> 
> Wikipedia doesn't seem to think so either:
> http://en.wikipedia.org/wiki/Filename#Reserved_characters_and_words

Okay, I stand corrected, and therefore gladly retract my objections!

Ciao,
Dscho
