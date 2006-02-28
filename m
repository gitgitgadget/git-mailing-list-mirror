From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] First cut at libifying revlist generation
Date: Mon, 27 Feb 2006 17:13:14 -0800
Message-ID: <7vr75ouvyt.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
	<7vpsl93395.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0602270947380.5937@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 02:13:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDtQc-0006gt-8u
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 02:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbWB1BNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 20:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbWB1BNS
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 20:13:18 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:22448 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751874AbWB1BNS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 20:13:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228011204.PGFK3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Feb 2006 20:12:04 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16901>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> http://article.gmane.org/gmane.comp.version-control.git/10718, which 
> helped me tremendously in identyfing the bug.

I'm willing to accept a response to "Yup. That sounds sensible."
