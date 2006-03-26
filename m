From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] send-email: Change from Mail::Sendmail to Net::SMTP
Date: Sat, 25 Mar 2006 17:09:42 -0800
Message-ID: <7vpskat3jd.fsf@assigned-by-dhcp.cox.net>
References: <11432834101430-git-send-email-normalperson@yhbt.net>
	<11432834102700-git-send-email-normalperson@yhbt.net>
	<20060325235859.GO26071@mythryan2.michonline.com>
	<20060326005424.GA1773@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 03:09:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNJlU-00020k-CZ
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 03:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWCZBJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 20:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWCZBJo
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 20:09:44 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:16015 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751158AbWCZBJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 20:09:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060326010943.HLE17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 20:09:43 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060326005424.GA1773@localdomain> (Eric Wong's message of "Sat,
	25 Mar 2006 16:54:24 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18013>

Eric Wong <normalperson@yhbt.net> writes:

> print gettext('Send '),$subject,"\n";

Nak; who said all languages have verb before what the verb acts
upon?
