From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add + Status patches
Date: Mon, 18 Apr 2005 15:25:28 -0700
Message-ID: <7v1x97u3hj.fsf@assigned-by-dhcp.cox.net>
References: <42641AE4.9050700@dgreaves.com>
	<7v64yju7er.fsf@assigned-by-dhcp.cox.net>
	<42643224.60407@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 00:21:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNece-0000L9-Rz
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVDRWZg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVDRWZg
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:25:36 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:59893 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261152AbVDRWZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 18:25:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418222527.YYZC1497.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Apr 2005 18:25:27 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <42643224.60407@dgreaves.com> (David Greaves's message of "Mon,
 18 Apr 2005 23:18:12 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DG" == David Greaves <david@dgreaves.com> writes:

DG> ... neither
DG> git add .
DG> nor
DG> git add -r .
DG> worked.

These would be much much much nicer than pipe the list of
filenames from stdin which reminds me of cpio ;-).

