From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] multi_ack protocol v2
Date: Thu, 27 Oct 2005 12:15:14 -0700
Message-ID: <7v4q723h6l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510270149590.12163@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmov4elu.fsf@assigned-by-dhcp.cox.net>
	<20051027141619.0e8029f2.vsu@altlinux.ru>
	<Pine.LNX.4.63.0510271227490.2724@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwtjy3lch.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510272003060.22251@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 21:15:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVDDd-0005Sp-BR
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 21:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbVJ0TPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 15:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbVJ0TPR
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 15:15:17 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:18885 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751561AbVJ0TPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 15:15:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051027191435.OSMI11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Oct 2005 15:14:35 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510272003060.22251@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 27 Oct 2005 20:04:30 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10724>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> A completely tested patch (unfortunately in the middle of my work) does 
> not touch get_remote_heads() at all:

Much nicer.
