From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC - draft] List of proposed future changes that are backward
 incompatible
Date: Mon, 16 Feb 2009 11:23:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902161121290.10279@pacific.mpi-cbg.de>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <alpine.DEB.1.00.0902152358330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0902151613110.14911@asgard.lang.hm> <alpine.DEB.1.00.0902160016230.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.10.0902151636510.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 11:24:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ0dr-0000a3-SM
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 11:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbZBPKWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 05:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753795AbZBPKWc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 05:22:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:33625 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753495AbZBPKWb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 05:22:31 -0500
Received: (qmail invoked by alias); 16 Feb 2009 10:22:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 16 Feb 2009 11:22:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ApQRmSHGAMbg+RxHPWxXmppQDP7etYw0uqy7eho
	IPkaOqCD9XP3cR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.10.0902151636510.14911@asgard.lang.hm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110162>

Hi,

On Sun, 15 Feb 2009, david@lang.hm wrote:

> please be careful with the term 'deprecated', just becouse you would do 
> something a different way doesn't make it 'deprecated', that term should 
> only be used for features that are on their way out of the product, but 
> haven't been removed yet.

It is not deprecated because I do not like it.  Actually, I am pretty 
indifferent about the pushing into a non-bare repository.

It is deprecated because a lot of people active in the Git community spend 
a real lot of time explaining to a whole bunch of new users on IRC and 
recently even on this list why their pushing into a non-bare repository 
does not work, and why their suggestions how to solve the issue does not 
work either.

Hth,
Dscho
