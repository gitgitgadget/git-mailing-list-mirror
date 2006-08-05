From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/5] Merge changes in "split patch 1" series
Date: Sat, 5 Aug 2006 16:55:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608051654390.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200608050036.06490.jnareb@gmail.com> <eb2068$cm7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 16:56:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9NZ4-0003aM-2E
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 16:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWHEOzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 10:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWHEOzm
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 10:55:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:47232 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751452AbWHEOzm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 10:55:42 -0400
Received: (qmail invoked by alias); 05 Aug 2006 14:55:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 05 Aug 2006 16:55:41 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eb2068$cm7$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24916>

Hi,

On Sat, 5 Aug 2006, Jakub Narebski wrote:

> Strange that git-format-patch does not output merges...

And what exactly should it output? patch against commit^1 or commit^2, 
etc.? Both? Combined diff?

Ciao,
Dscho
