From: Junio C Hamano <junkio@cox.net>
Subject: Re: nit: missing branch error message
Date: Fri, 16 Sep 2005 16:09:35 -0700
Message-ID: <7vhdckfw40.fsf@assigned-by-dhcp.cox.net>
References: <432A67C3.2010205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 01:10:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGPKt-0004Bj-Hj
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 01:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVIPXJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 19:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVIPXJh
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 19:09:37 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56207 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750766AbVIPXJg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 19:09:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916230936.ZMKF3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 19:09:36 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <432A67C3.2010205@pobox.com> (Jeff Garzik's message of "Fri, 16
	Sep 2005 02:35:47 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8743>

Jeff Garzik <jgarzik@pobox.com> writes:

>> [jgarzik@pretzel libata-dev]$ git checkout -f upstream
>> fatal: Needed a single revision
>
> Better error message would be "hey dummy, branch doesn't exist"

Thanks.
