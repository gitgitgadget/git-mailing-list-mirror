From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] There are several undocumented dependencies
Date: Sun, 11 Sep 2005 23:16:23 -0700
Message-ID: <7vvf16izew.fsf@assigned-by-dhcp.cox.net>
References: <200509120000.j8C00n9M012603@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 08:17:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEhcy-0003Ee-E3
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 08:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVILGQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 02:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVILGQZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 02:16:25 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:7089 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751174AbVILGQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 02:16:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912061623.OTHL3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 02:16:23 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8369>

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> There are several undocumented dependencies in the .spec and in the
> INSTALL files. The following is from Fedora, perhaps other RPM
> distributions call the packages differently.

Thanks.  Earlier, I was told that it does not make much sense to
target for RPM based distributions in general because of the
package naming issue you mention here, and explicitly targetting
for Fedora is fine by me.
