From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Add a basic test case for git send-email, and fix some real bugs discovered.
Date: Mon, 29 May 2006 22:57:44 -0700
Message-ID: <7v8xok3vhj.fsf@assigned-by-dhcp.cox.net>
References: <11489310153730-git-send-email-1>
	<11489310153598-git-send-email-1> <11489310151293-git-send-email-1>
	<11489310153617-git-send-email-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 07:57:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkxEk-0006qt-D0
	for gcvg-git@gmane.org; Tue, 30 May 2006 07:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWE3F5r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 01:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWE3F5r
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 01:57:47 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54207 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932132AbWE3F5q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 01:57:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060530055745.YRCM18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 May 2006 01:57:45 -0400
To: Ryan Anderson <rda@google.com>
In-Reply-To: <11489310153617-git-send-email-1> (Ryan Anderson's message of
	"Mon, 29 May 2006 12:30:15 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21016>

Ryan Anderson <rda@google.com> writes:

> Signed-off-by: Ryan Anderson <rda@google.com>
>
> ---
>
> 64ea8c0210c2e9d1711a870460eca326778a4ffc
>  t/t9001-send-email.sh |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)
>  create mode 100755 t/t9001-send-email.sh

Adds test, alright, but I do not see the fix.  Is this a thinko?
