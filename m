From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Initialize lock_file struct to all zero.
Date: Mon, 19 Jun 2006 17:04:36 -0700
Message-ID: <7vr71k7kvf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606200054290.26329@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 02:04:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsTjY-00006U-1e
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 02:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWFTAEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 20:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWFTAEl
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 20:04:41 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8380 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965002AbWFTAEk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 20:04:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620000439.EEZQ11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Jun 2006 20:04:39 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606200054290.26329@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 20 Jun 2006 00:55:20 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22149>

Good catch.  Thanks.
