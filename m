From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitk errors out if launched in a subdirectory
Date: Fri, 12 Jan 2007 09:59:39 -0800
Message-ID: <7vvejct9bo.fsf@assigned-by-dhcp.cox.net>
References: <20070109143019.GA24688@xp.machine.xx>
	<20070112174340.GA6262@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 18:59:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Qgq-0001ht-9d
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 18:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbXALR7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 12:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbXALR7l
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 12:59:41 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:43787 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964801AbXALR7k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 12:59:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112175940.MONV20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 12:59:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AHyo1W00T1kojtg0000000; Fri, 12 Jan 2007 12:58:48 -0500
To: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
In-Reply-To: <20070112174340.GA6262@xp.machine.xx> (Peter Baumann's message of
	"Fri, 12 Jan 2007 18:43:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36686>

Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de> writes:

> Is there something obviously wrong with this patch? It is the second
> time I send this (or a slight variant; last time I even removed the
> enviroment checking) and nobody answered.
>
> Please say so if it is NAKed.

I am Ok with it if Paul is.  I think it makes sense.
