From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/3] archive: rename attribute specfile to export-subst
Date: Thu, 6 Sep 2007 18:13:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709061811460.28586@racer.site>
References: <46DC4D45.4030208@lsrfire.ath.cx> <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org>
 <46DCF0EF.9020604@op5.se> <Pine.LNX.4.64.0709041139140.28586@racer.site>
 <46DDE69C.1080908@lsrfire.ath.cx> <7vzm02klip.fsf@gitster.siamese.dyndns.org>
 <46E02FFF.8090902@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-2030771671-1189098809=:28586"
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:14:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKvN-0000Ec-W7
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 19:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbXIFRNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 13:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbXIFRNp
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 13:13:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:36339 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751516AbXIFRNo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 13:13:44 -0400
Received: (qmail invoked by alias); 06 Sep 2007 17:13:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 06 Sep 2007 19:13:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UMssZEvdU7siG992KCHry3Wf/led8Rkx6n7V3B9
	2fy/D2yKJVUOv8
X-X-Sender: gene099@racer.site
In-Reply-To: <46E02FFF.8090902@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57909>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-2030771671-1189098809=:28586
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 6 Sep 2007, René Scharfe wrote:

> As suggested by Junio and Johannes, change the name of the former
> attribute specfile to export-subst to indicate its function rather
> than purpose and to make clear that it is not applied to working tree
> files.
> 
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

ACK!

(Even if I did not really suggest "export-subst", which I like very 
much...)

The bigger question is now if these two patches should be folded back into 
your original patch series, or stand alone as commits of their own...

Ciao,
Dscho
--8323584-2030771671-1189098809=:28586--
