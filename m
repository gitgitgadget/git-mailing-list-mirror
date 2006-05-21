From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make '@' not valid in a ref name.
Date: Sat, 20 May 2006 18:42:23 -0700
Message-ID: <7vodxsywzk.fsf@assigned-by-dhcp.cox.net>
References: <20060521013751.GA7516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 03:42:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhcxg-0005jb-I2
	for gcvg-git@gmane.org; Sun, 21 May 2006 03:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWEUBmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 21:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWEUBmZ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 21:42:25 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60351 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932234AbWEUBmY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 21:42:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521014224.ZTTD24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 May 2006 21:42:24 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060521013751.GA7516@spearce.org> (Shawn Pearce's message of
	"Sat, 20 May 2006 21:37:51 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20422>

I am not a fan of retroactively disallowing what we used to
allow.  Is this unavoidable?
