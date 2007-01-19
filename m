From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Fri, 19 Jan 2007 14:20:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701191420000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com>
 <Pine.LNX.4.63.0701171334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701171500.33220.jnareb@gmail.com> <200701191310.32417.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nikolai Weibull <now@bitwi.se>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 14:21:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7tfi-0002Ex-DD
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 14:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbXASNUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 08:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbXASNUn
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 08:20:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:46700 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965122AbXASNUm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 08:20:42 -0500
Received: (qmail invoked by alias); 19 Jan 2007 13:20:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 19 Jan 2007 14:20:40 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200701191310.32417.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37181>

Hi,

On Fri, 19 Jan 2007, Jakub Narebski wrote:

> From a bit of testing, as documentation of config file format is 
> woefully incomplete, (yes, I know I should use the source) _some_ of C 
> escape sequences aka. character escape codes (CEC) are parsed:

No, you should not just use the source. You should use the source _and_ 
complete the documentation.

Ciao,
Dscho
