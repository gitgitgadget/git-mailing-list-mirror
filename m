From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATH] sed -e '/RE/r rfile/' needs space in 'r rfile'
Date: Sat, 8 Jul 2006 18:47:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607081844580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200607081727.10837.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 18:47:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzFxp-00083c-H0
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 18:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWGHQr0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 12:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWGHQr0
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 12:47:26 -0400
Received: from mail.gmx.de ([213.165.64.21]:17878 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964898AbWGHQrZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 12:47:25 -0400
Received: (qmail invoked by alias); 08 Jul 2006 16:47:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 08 Jul 2006 18:47:24 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Michal Rokos <michal.rokos@nextsoft.cz>
In-Reply-To: <200607081727.10837.michal.rokos@nextsoft.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23491>

Hi,

On Sat, 8 Jul 2006, Michal Rokos wrote:

> Johannes,

Could you Cc me next time you address me personally? There are times when 
I am too busy to read all the mails of all the lists, and your mail would 
have been not read by me at those occasions.

> in commit 07002287f3e219a16a948a8a6eca0a41162a491f
> you cleaned up 'replace ugly and unportable sed invocation' as you said.
> Please note, that some SEDs (like HP-UX one) mandate a space between 'r' 
> and 'rfile'.

Ack. Note that this is yet-another-reason to step away from scripts.

Ciao,
Dscho
