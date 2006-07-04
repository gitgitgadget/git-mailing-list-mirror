From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] t8001-annotate: fix a bash-ism in this test
Date: Tue, 04 Jul 2006 01:46:55 -0700
Message-ID: <7vhd1xkb9c.fsf@assigned-by-dhcp.cox.net>
References: <11519766021208-git-send-email-ryan@michonline.com>
	<11519766033852-git-send-email-ryan@michonline.com>
	<20060704080424.GA31612@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 10:47:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxgYe-0005WD-7n
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 10:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWGDIq5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 04:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWGDIq5
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 04:46:57 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:52215 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932148AbWGDIq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 04:46:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704084656.CPFP19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 04:46:56 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060704080424.GA31612@soma> (Eric Wong's message of "Tue, 4 Jul
	2006 01:04:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23274>

Thanks -- good catch.
