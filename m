From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] More diff possibilities in gitweb
Date: Sat, 17 Mar 2007 19:04:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703171902200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070317151731.GA32571@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sat Mar 17 19:05:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSdH1-0001Cc-Cu
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 19:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbXCQSE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 14:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbXCQSE5
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 14:04:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:35932 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752270AbXCQSE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 14:04:56 -0400
Received: (qmail invoked by alias); 17 Mar 2007 18:04:55 -0000
X-Provags-ID: V01U2FsdGVkX18ZCscTkqkZLkvT78VbsEclRui+eJ0TdHQFI8MXdy
	/udWIpjqVAe3ds
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070317151731.GA32571@auto.tuwien.ac.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42446>

Hi,

On Sat, 17 Mar 2007, Martin Koegler wrote:

> The whole is implemented in JavaScript on the client side (tested with 
> IE 6 and Mozilla).

This is not acceptable for me. There are too many people blindly running 
JavaScript everywhere, and we should not enforce such bad behaviour.

At least, you need a way to do it with plain old HTML (which is easy 
enough).

Also I'd like to know: is there any reason you did not send a proper diff, 
given that you are so interested in diffs?

Ciao,
Dscho
