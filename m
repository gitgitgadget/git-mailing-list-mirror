From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: problem with git-cvsserver
Date: Fri, 1 Sep 2006 01:13:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609010110540.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44F5B2A7.8070501@gmail.com> 
 <Pine.LNX.4.63.0608301904360.28360@wbgn013.biozentrum.uni-wuerzburg.de> 
 <44F5D6F8.50307@gmail.com> <7vlkp6gh6e.fsf@assigned-by-dhcp.cox.net> 
 <46a038f90608301329n14df4dd2tb1563cc48662cd14@mail.gmail.com> 
 <20060831090333.GA28445@fiberbit.xs4all.nl>
 <46a038f90608311600p747c8a3anbe90dbac928e9923@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Roeland <marco.roeland@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>,
	aonghus <thecolourblue@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 01 01:13:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIvj8-0005MT-Td
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 01:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWHaXNb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 19:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWHaXNb
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 19:13:31 -0400
Received: from mail.gmx.de ([213.165.64.20]:36247 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751313AbWHaXN3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 19:13:29 -0400
Received: (qmail invoked by alias); 31 Aug 2006 23:13:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 01 Sep 2006 01:13:27 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90608311600p747c8a3anbe90dbac928e9923@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26287>

Hi,

On Fri, 1 Sep 2006, Martin Langhoff wrote:

> Pg/MySQL aren't really supported, though it wouldn't be that hard.

AFAIK Pg/MySQL/all-the-others want to have a common place where to put the 
database files. This is a huge disadvantage over SQLite, where you can put 
it anywhere you want (e.g. /blabla/.git/...). This also makes installation 
way easier.

Ciao,
Dscho
