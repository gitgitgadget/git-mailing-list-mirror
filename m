From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Running gitweb under mod_perl
Date: Thu, 24 Aug 2006 14:46:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608241445420.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <eck6sq$agn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 14:46:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGEbJ-0004cJ-1R
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 14:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWHXMqW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 08:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWHXMqW
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 08:46:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:46521 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751210AbWHXMqV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 08:46:21 -0400
Received: (qmail invoked by alias); 24 Aug 2006 12:46:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 24 Aug 2006 14:46:19 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eck6sq$agn$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25958>

Hi,

On Thu, 24 Aug 2006, Jakub Narebski wrote:

> Could you tell me what should I do to run gitweb under mod_perl,
> and not as CGI script? What should I put in Apache configuration
> (Apache 2.0.54 if this matters, mod_perl 2.0.1)

I have not checked closely, but it seems that git-instaweb supports 
mod_perl. Maybe you can find out what you have to do by inspecting 
git-instaweb?

Hth,
Dscho
