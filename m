From: Junio C Hamano <junkio@cox.net>
Subject: vger bogofilter help.
Date: Sun, 03 Sep 2006 14:11:41 -0700
Message-ID: <7vzmdgu036.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 03 23:11:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJzFn-0000Ly-FL
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 23:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWICVL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 17:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWICVL1
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 17:11:27 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:44755 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932153AbWICVL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 17:11:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060903211126.XRKX6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Sun, 3 Sep 2006 17:11:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HxBS1V00e1kojtg0000000
	Sun, 03 Sep 2006 17:11:27 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26376>

I got a few complaints/wonders/request-for-helps from the people
on this list who got their messages bounced by bogofilter at
vger.  I got an earlier message of mine bounced too ;-).  I am
not involved in running vger mailing list in any way (I am not
even a subscriber).  Please send the bounce message you got in
full to <postmaster@vger.kernel.org>.

The announcement was sent only to the kernel list so people who
do not follow it but still on one of the mailing lists at vger
would not know what to do, which was not very nice, so here is a
reproduction of the announce.

    From: Matti Aarnio <matti.aarnio@zmailer.org>
    Subject: Bogofilter at VGER..
    Date: Fri, 1 Sep 2006 15:51:53 +0300
    Message-ID: <20060901125153.GC16047@mea-ext.zmailer.org>
    To: linux-kernel@vger.kernel.org

    Hello,

    We are considering of taking Bogofilter into use at VGER.
    So far we are using it in TEST mode - to teach it about
    SPAM and HAM.

    I have added some new "cute" email addresses to VGER to
    receive any spams that spammers wish to send to us..
    See the bottom link at vger's web front page.

    You can feed SPAM to  bogofilter-spam@vger.kernel.org,
    but do not feed there any HAM.  Not that it would
    really affect statistics in any effective way.

    IF we take it into use, it will start rejecting messages
    at SMTP input phase, so if it rejects legitimate message,
    you should get a bounce from your email provider's system.
    (Or from zeus.kernel.org, which is vger's backup MX.)

    In such case, send the bounce with some explanations to 
    <postmaster@vger.kernel.org> -- emails to that address
    are explicitely excluded from all filtering!

    Regards,
      Matti Aarnio -- one of  <postmaster@vger.kernel.org>


-- 
VGER BF report: U 0.500024
