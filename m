From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] 42c4b58059f.. during "make install-doc": git-add.5: No such file or directory
Date: Sun, 22 Apr 2007 10:59:25 -0700
Message-ID: <7vr6qcnvcy.fsf@assigned-by-dhcp.cox.net>
References: <86bqhgqyzg.fsf@blue.stonehenge.com>
	<867is4qyut.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Sun Apr 22 19:59:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfgLu-00083C-Fb
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 19:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbXDVR72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 13:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbXDVR71
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 13:59:27 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34117 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbXDVR71 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 13:59:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422175926.MLYW1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 13:59:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qHzS1W0041kojtg0000000; Sun, 22 Apr 2007 13:59:26 -0400
In-Reply-To: <867is4qyut.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "Sun, 22 Apr 2007 07:15:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45257>

I've fixed MAN5 related typos last night and have a fix near the
tip of the master.
