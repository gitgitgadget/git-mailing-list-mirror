From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] Git.pm: Support for perl/ being built by a different compiler
Date: Mon, 26 Jun 2006 10:51:10 +0200
Message-ID: <20060626085110.GD9248@cip.informatik.uni-erlangen.de>
References: <20060625014703.29304.12715.stgit@machine.or.cz> <7vk676orjy.fsf@assigned-by-dhcp.cox.net> <20060626082428.G52c9608e@leonov.stosberg.net> <20060626082939.G215d3ce6@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 10:51:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FumoN-0007pH-Hu
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 10:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWFZIvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 04:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWFZIvM
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 04:51:12 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:37101 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S964944AbWFZIvL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 04:51:11 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 29E8C30E10; Mon, 26 Jun 2006 10:51:10 +0200 (CEST)
To: Dennis Stosberg <dennis@stosberg.net>
Content-Disposition: inline
In-Reply-To: <20060626082939.G215d3ce6@leonov.stosberg.net>
User-Agent: Mutt/1.5.11-2006-06-13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22665>

Hello,

> -/*
> +/*l
> +

this looks like a typo in your patch.

        Thomas
