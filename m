From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: how to merge sub directory or file?
Date: Mon, 7 Nov 2011 19:37:08 +0400
Message-ID: <20111107193708.6cf2ae81.kostix@domain007.com>
References: <20111107172652.0faade61@ashu.dyn.rarus.ru>
	<8B3D19E0-2181-4E9C-943F-CA26A399E0D9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Emily <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 16:47:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNRQE-0008Ka-Be
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 16:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297Ab1KGPrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 10:47:33 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:55773 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab1KGPrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 10:47:31 -0500
X-Greylist: delayed 617 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Nov 2011 10:47:30 EST
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id pA7Fb8Mj026947;
	Mon, 7 Nov 2011 19:37:09 +0400
In-Reply-To: <8B3D19E0-2181-4E9C-943F-CA26A399E0D9@gmail.com>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.10.14; i686-pc-mingw32)
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184987>

On Mon, 7 Nov 2011 22:54:18 +0800
Emily <lingyan.ren@gmail.com> wrote:

> I have two git projects A and B, content of B is subset of A. For
> example, Project  A and B's tree are as below:
[...]
> When there's new changes in project A, how can I merge them to
> project B without changing B's directory structure?
> 
> Your help will be highly appreciated.
Subtree merging maybe?
See http://progit.org/book/ch6-7.html
