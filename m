From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] "clone --naked"?
Date: Sun, 15 Jan 2006 23:47:50 -0800
Message-ID: <7vfynoy5p5.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0601121556240.3535@g5.osdl.org>
	<43CB57A0.29999.F89D30F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: users@kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 08:48:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyP5s-0001Y2-UK
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 08:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWAPHr6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 02:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWAPHr6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 02:47:58 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:27028 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932241AbWAPHr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 02:47:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060116074531.CNXD17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 02:45:31 -0500
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.DE>
In-Reply-To: <43CB57A0.29999.F89D30F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	(Ulrich Windl's message of "Mon, 16 Jan 2006 08:21:53 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14726>

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.DE> writes:

> On 14 Jan 2006 at 15:39, Junio C Hamano wrote:
>
> [...]
>> BTW, I have been meaning to make this easier, by introducing a
>> new option to "git clone", like this:
> ...
> You must be over 21 to use --naked, however ;-)
> Maybe you find a better word.

Linus seems to use word "bare" sometimes.  Checking the git-core
documentation, repository-layout documentation first used the
word naked on Sep 1 2005, while there is no mention of "bare"
repository anywhere.  Maybe "bare" is preferred?

I hope you do not mind my sending this message out to git list
to take a quick poll.
