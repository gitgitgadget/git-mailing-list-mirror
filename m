From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add the WITH_P4IMPORT knob to the Makefile.
Date: Tue, 27 Mar 2007 03:54:16 -0700
Message-ID: <7vps6vnehz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321115004.GB14837@codelabs.ru>
	<Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321144008.GE14837@codelabs.ru>
	<Pine.LNX.4.63.0703211630160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321160126.GH14837@codelabs.ru>
	<7v1wji371q.fsf@assigned-by-dhcp.cox.net>
	<20070326073143.GB44578@codelabs.ru>
	<20070326073250.GC44578@codelabs.ru>
	<7v1wjcz9x1.fsf@assigned-by-dhcp.cox.net>
	<20070327102601.GN14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Tue Mar 27 12:54:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW9KF-0005Xh-HD
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807AbXC0KyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbXC0KyT
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:54:19 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:58651 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbXC0KyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:54:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327105418.ICI1312.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 06:54:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fmuH1W0011kojtg0000000; Tue, 27 Mar 2007 06:54:17 -0400
In-Reply-To: <20070327102601.GN14837@codelabs.ru> (Eygene Ryabinkin's message
	of "Tue, 27 Mar 2007 14:26:01 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43259>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> WITH_P4IMPORT: enables the installation of the Perforce import
> script.
>
> Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>

Thanks.  I wonder if we need to update git.spec.in file if we
were to take this patch.
