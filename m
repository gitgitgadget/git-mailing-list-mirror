From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Perl gurus: why do we need Scalar::Util?
Date: Mon, 10 Jul 2006 13:44:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607101343060.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jul 10 13:44:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzuBv-0002bg-UF
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 13:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWGJLol (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 07:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWGJLol
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 07:44:41 -0400
Received: from mail.gmx.net ([213.165.64.21]:25984 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964909AbWGJLok (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 07:44:40 -0400
Received: (qmail invoked by alias); 10 Jul 2006 11:44:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 10 Jul 2006 13:44:39 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23611>

Hi,

please do not let my die dumb: what is this "blessed" thing all about? And 
why do we need it in the private-Error.pm??

Thanks,
Dscho
