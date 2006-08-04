From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: HOWTO set up a repository which can be pushed into over HTTP
Date: Sat, 5 Aug 2006 00:45:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608050044000.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608042021300.1800@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac6kjoxh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 00:46:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G98Qd-000865-Ol
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 00:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161552AbWHDWp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 18:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161553AbWHDWp6
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 18:45:58 -0400
Received: from mail.gmx.de ([213.165.64.20]:59017 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161552AbWHDWp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 18:45:57 -0400
Received: (qmail invoked by alias); 04 Aug 2006 22:45:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 05 Aug 2006 00:45:56 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac6kjoxh.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24861>

Hi,

On Fri, 4 Aug 2006, Junio C Hamano wrote:

> Nice addition to Documentation/howto/ I would presume...

I actually planned to submit a patch with a file in that directory 
first... But then I read the files already in it, and they all look like 
they were emails first, which got -- presumably by several people finding 
it useful -- into a patch.

Do people find it useful? Or would you like to wait until I implement an 
option in git-http-push to actually init an HTTP repo remotely?

Ciao,
Dscho
