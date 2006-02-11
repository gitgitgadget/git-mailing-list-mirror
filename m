From: Junio C Hamano <junkio@cox.net>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Sat, 11 Feb 2006 11:25:44 -0800
Message-ID: <7vmzgxn1dz.fsf@assigned-by-dhcp.cox.net>
References: <87slqtcr2f.wl%cworth@cworth.org>
	<7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
	<87bqxgxfl7.wl%cworth@cworth.org>
	<7vr76c5avd.fsf@assigned-by-dhcp.cox.net>
	<87fymst399.wl%cworth@cworth.org>
	<7vfyms0x4p.fsf@assigned-by-dhcp.cox.net>
	<m31wybknuv.fsf@athena.unit.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 20:26:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F80Nf-000205-IC
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 20:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWBKTZr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 14:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWBKTZr
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 14:25:47 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:26297 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964779AbWBKTZr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 14:25:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211192551.JSYP25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 14:25:51 -0500
To: Kent Engstrom <kent@lysator.liu.se>
In-Reply-To: <m31wybknuv.fsf@athena.unit.liu.se> (Kent Engstrom's message of
	"Fri, 10 Feb 2006 20:36:24 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15961>

Kent Engstrom <kent@lysator.liu.se> writes:

> Junio C Hamano <junkio@cox.net> writes:
>> *1* Often I find myself doing that while rewriting messy
>> development history.  For example, I start doing some
>> work without knowing exactly where it leads, and end up with a
>> history like this:
>
> Perhaps this discussion could be added under Documentation/howto?

Maybe.

Traditionally, person who feels that way proofreads and
copyedits the original posting and submits a patch ;-).
