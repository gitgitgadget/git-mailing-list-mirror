From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix linking with OpenSSL
Date: Fri, 05 May 2006 01:02:46 -0700
Message-ID: <7vpsis2921.fsf@assigned-by-dhcp.cox.net>
References: <20060504222550.GA7236@mipter.zuzino.mipt.ru>
	<7vwtd12z6h.fsf@assigned-by-dhcp.cox.net>
	<7vslnp2y5x.fsf@assigned-by-dhcp.cox.net>
	<20060505075754.GA7237@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 10:02:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbvH1-0005W3-G8
	for gcvg-git@gmane.org; Fri, 05 May 2006 10:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWEEICs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 04:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWEEICs
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 04:02:48 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:10701 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030340AbWEEICr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 04:02:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505080247.UCSJ27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 May 2006 04:02:47 -0400
To: Alexey Dobriyan <adobriyan@gmail.com>
In-Reply-To: <20060505075754.GA7237@mipter.zuzino.mipt.ru> (Alexey Dobriyan's
	message of "Fri, 5 May 2006 11:57:54 +0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19604>

Alexey Dobriyan <adobriyan@gmail.com> writes:

> It does. It also crashes busybox patch applet. Oh, well...

Could you elaborate on "busybox patch" problem?
