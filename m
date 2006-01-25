From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Wed, 25 Jan 2006 11:24:19 -0800
Message-ID: <7v8xt4qffg.fsf@assigned-by-dhcp.cox.net>
References: <7vy814qx6o.fsf@assigned-by-dhcp.cox.net>
	<8aa486160601250741k120f0021h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 20:25:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1qFm-0003T6-8x
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 20:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWAYTYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 14:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWAYTYW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 14:24:22 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:11393 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932129AbWAYTYW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 14:24:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125192126.OUMO20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 Jan 2006 14:21:26 -0500
To: Santi Bejar <sbejar@gmail.com>
In-Reply-To: <8aa486160601250741k120f0021h@mail.gmail.com> (Santi Bejar's
	message of "Wed, 25 Jan 2006 16:41:02 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15133>

Santi Bejar <sbejar@gmail.com> writes:

> I think we should be consistent with respect the leading dots. Now the
> diff-tree line has the dots, but the merge line do not.

This is deliberate.  Merge lines do not have to align with
anything else for readability.
