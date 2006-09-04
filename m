From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Bogofilter woes at git-list..
Date: Mon, 4 Sep 2006 12:33:57 +0300
Message-ID: <20060904093357.GL16047@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 04 11:34:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKAqD-0006XE-N3
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 11:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWIDJd7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 05:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWIDJd7
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 05:33:59 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:57055 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1751268AbWIDJd7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 05:33:59 -0400
Received: (mea@mea-ext) by mail.zmailer.org id S256124AbWIDJd6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 12:33:58 +0300
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26409>

Oops, sorry.

It looks like I forgot to add "learn what is acceptable traffic"
thing onto the git-list, and as an indirect result of that, a lot
of list traffic got blocked.  (I added this 'learn ham out of traffic'
on GIT -list too.)

Even though the messages were rejected at SMTP input phase,
they were diverted into a "freezer" from whence I have been
digging the (mostly dung-) heap for misclassifieds, and
when found some, defrosted them.

So far I have had to add a rule to exempt also majordomo
from any pre-filtering..  way too much rejects there.

If you have any questions, do contact:
     postmaster@vger.kernel.org

that address is (also) excepted of any content filtering.

  /Matti Aarnio -- one of  <postmaster@vger.kernel.org>

-- 
VGER BF report: U 0.550908
