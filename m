From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config_set_multivar(): disallow newlines in keys
Date: Fri, 19 Jan 2007 17:40:12 -0800
Message-ID: <7vzm8ea32b.fsf@assigned-by-dhcp.cox.net>
References: <200701150144.56793.jnareb@gmail.com>
	<200701191310.32417.jnareb@gmail.com>
	<Pine.LNX.4.63.0701191420000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<200701192344.11972.jnareb@gmail.com>
	<7v8xfyczxi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200224180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 02:40:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H85DT-0006Qw-9h
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 02:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbXATBkO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 20:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbXATBkO
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 20:40:14 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:54970 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965051AbXATBkN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 20:40:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120014012.TNFB15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 20:40:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DDgV1W0161kojtg0000000; Fri, 19 Jan 2007 20:40:30 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701200224180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 02:25:37 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37246>

Thanks.
