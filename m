From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/3] archive: rename attribute specfile to export-subst
Date: Fri, 7 Sep 2007 11:45:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709071144450.28586@racer.site>
References: <46DC4D45.4030208@lsrfire.ath.cx> <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org>
 <46DCF0EF.9020604@op5.se> <Pine.LNX.4.64.0709041139140.28586@racer.site>
 <46DDE69C.1080908@lsrfire.ath.cx> <7vzm02klip.fsf@gitster.siamese.dyndns.org>
 <46E02FFF.8090902@lsrfire.ath.cx> <Pine.LNX.4.64.0709061811460.28586@racer.site>
 <7vd4wva4lv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 12:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITbLE-0004AY-2P
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 12:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbXIGKpa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 06:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbXIGKp3
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 06:45:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:42384 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965247AbXIGKp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 06:45:28 -0400
Received: (qmail invoked by alias); 07 Sep 2007 10:45:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 07 Sep 2007 12:45:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+J6AFCkj+JAIj6jM4TwJsTZEbOhi+Jis2YUyd3c3
	Z4/08ZEqZ5M8lG
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4wva4lv.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58020>

Hi,

On Thu, 6 Sep 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The bigger question is now if these two patches should be folded back 
> > into your original patch series, or stand alone as commits of their 
> > own...
> 
> That is no brainer, as there is a simple and hard rule that any topic 
> already in 'next' are not to be rewound ever.  Follow-up patches are the 
> right thing to do in this case.

Right.  At the time I suggested it, I was not aware that the patches were 
in next already.

Sorry,
Dscho
