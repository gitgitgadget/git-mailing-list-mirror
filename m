From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Compiling git-snapshot-20069831
Date: Thu, 31 Aug 2006 14:09:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608311408350.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44F6D016.4050007@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 14:09:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIlMb-0005sv-CB
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 14:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWHaMJi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 08:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbWHaMJi
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 08:09:38 -0400
Received: from mail.gmx.de ([213.165.64.20]:33704 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751599AbWHaMJh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 08:09:37 -0400
Received: (qmail invoked by alias); 31 Aug 2006 12:09:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 31 Aug 2006 14:09:36 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jorma Karvonen <karvjorm@users.sourceforge.net>
In-Reply-To: <44F6D016.4050007@users.sourceforge.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26253>

Hi,

since you do have a recent snapshot, why not try ./configure, as Pasky 
suggested?

BTW I cannot read Finnish, but it probably says that you do not have curl 
installed. configure would detect that, and automatically set NO_CURL=1.

Ciao,
Dscho
