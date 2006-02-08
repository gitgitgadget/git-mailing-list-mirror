From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the revision and person that created each line in the file.
Date: Wed, 08 Feb 2006 11:19:37 -0800
Message-ID: <7v3bitr73q.fsf@assigned-by-dhcp.cox.net>
References: <11394103753694-git-send-email-ryan@michonline.com>
	<cda58cb80602080835s38713193t@mail.gmail.com>
	<Pine.LNX.4.63.0602081843220.20568@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 20:19:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6uqs-0006FA-E7
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 20:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWBHTTk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 14:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWBHTTj
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 14:19:39 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:37036 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932426AbWBHTTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 14:19:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060208191715.DEYW17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 14:17:15 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602081843220.20568@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 8 Feb 2006 18:45:30 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15747>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Are there any rules on the choice of the script language ?
>
> Yes. Do not try to introduce unnecessary dependencies. But if it is 
> the right tool to do the job, you should use it. As of now, we have perl, 
> python and Tcl/Tk.

Very well said.  That's what currently stands.
