From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 2/5] Don't display passwords on the console in fetch/push output
Date: Fri, 11 Jul 2008 00:42:42 +0200
Message-ID: <200807110042.42752.robin.rosenberg.lists@dewire.com>
References: <1215670403-19191-1-git-send-email-spearce@spearce.org> <200807102217.38459.robin.rosenberg.lists@dewire.com> <alpine.DEB.1.00.0807110024480.3279@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:50:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4xn-0004xo-5F
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbYGJWrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbYGJWru
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:47:50 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13215 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753738AbYGJWru (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:47:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F060E802846;
	Fri, 11 Jul 2008 00:47:48 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wi-eKyRIluvm; Fri, 11 Jul 2008 00:47:48 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 7DFF28027F7;
	Fri, 11 Jul 2008 00:47:48 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807110024480.3279@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88046>

fredagen den 11 juli 2008 00.25.27 skrev Johannes Schindelin:
> Hi,
> 
> On Thu, 10 Jul 2008, Robin Rosenberg wrote:
> 
> > >From 99c09cf2321f36eb81043aed2fa6834811ee762b Mon Sep 17 00:00:00 2001
> > From: Robin Rosenberg <robin.rosenberg@dewire.com>
> > Date: Thu, 10 Jul 2008 22:16:19 +0200
> > Subject: [PATCH] Avoid password leak from URIIsh
> 
> What is this new fashion of sending them headers in the mail body?  Robin, 
> I thought you knew better.

Laziness, I suppose, and that's not a new fashion. I'll try to have better in the future.

-- robin
