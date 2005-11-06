From: Paul Collins <paul@briny.ondioline.org>
Subject: Re: What's in git.git tonight
Date: Sun, 06 Nov 2005 11:57:16 +0000
Message-ID: <87y8427zvn.fsf@briny.internal.ondioline.org>
References: <7v3bmayu2r.fsf@assigned-by-dhcp.cox.net>
	<86acgiujuk.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 13:01:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYjCS-0006wi-E7
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 13:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVKFMA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 07:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVKFMA3
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 07:00:29 -0500
Received: from jenny.ondioline.org ([66.220.1.122]:30732 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP
	id S1751220AbVKFMA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 07:00:28 -0500
Received: by jenny.ondioline.org (Postfix, from userid 10)
	id 80485AE1F; Sun,  6 Nov 2005 12:00:27 +0000 (GMT)
Received: by briny.internal.ondioline.org (Postfix, from userid 1000)
	id 835FAF933; Sun,  6 Nov 2005 11:57:16 +0000 (GMT)
To: merlyn@stonehenge.com (Randal L. Schwartz)
Mail-Followup-To: merlyn@stonehenge.com (Randal L. Schwartz), Junio C Hamano
	<junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <86acgiujuk.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "06 Nov 2005 02:54:59 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11206>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> http-push.c no longer compiles on OSX:

It seems to require libexpat now.  I got the same error here on Debian.
With libexpat-dev installed it builds.

-- 
Dag vijandelijk luchtschip de huismeester is dood
