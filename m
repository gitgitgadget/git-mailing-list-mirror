From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 17:44:50 -0400
Message-ID: <BAYC1-PASMTP0154E291106F138403852FAE0F0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45349162.90001@op5.se>
	<453536AE.6060601@utoronto.ca>
	<200610172301.27101.jnareb@gmail.com>
	<45354AD0.1020107@utoronto.ca>
	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
	<45355CBB.80108@utoronto.ca>
	<BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
	<eh64tk$rug$2@sea.gmane.org>
	<20061018172945.c0c58c38.seanlkml@sympatico.ca>
	<20061018213703.GE19194@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:45:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJDf-0002oS-LE
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423022AbWJRVox (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423020AbWJRVox
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:44:53 -0400
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:27788 "EHLO
	bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1423022AbWJRVow (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 17:44:52 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 18 Oct 2006 14:44:51 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GaIHS-0002jl-9G; Wed, 18 Oct 2006 16:44:50 -0400
To: Shawn Pearce <spearce@spearce.org>
Message-Id: <20061018174450.f2108a21.seanlkml@sympatico.ca>
In-Reply-To: <20061018213703.GE19194@spearce.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Oct 2006 21:44:51.0717 (UTC) FILETIME=[A434B350:01C6F2FE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Oct 2006 17:37:03 -0400
Shawn Pearce <spearce@spearce.org> wrote:

> Today Git is typically extended (at least initially in prototyping
> mode) through Perl, Python, TCL or Bourne shell scripts.  Although
> the first three are available natively on Windows the last requires
> Cygwin... and we've had some issues with ActiveState Perl on Windows
> in the past too.

Just for kicks and giggles it would be nice if someone tried out
one of the native Windows bourne shell ports[1] just to see how much
is missing.  A bunch of command line utilities would have to be ported
as well; maybe too many.  But i've held out booting a Windows box
for a long time so.... not it!

Sean

[1] For example, http://www.steve.org.uk/Software/bash/
