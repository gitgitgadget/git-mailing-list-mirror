From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH][COGITO] Add .deb build support to Makefile
Date: Tue, 20 Sep 2005 02:31:02 +0200
Message-ID: <20050920003102.GB13537@pasky.or.cz>
References: <7c278d0c05091917232c79b909@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 02:33:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHW2Q-0000i7-NJ
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVITAbF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVITAbE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:31:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23465 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964801AbVITAbE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 20:31:04 -0400
Received: (qmail 15060 invoked by uid 2001); 20 Sep 2005 02:31:02 +0200
To: Stefhen Hovland <stefhen.hovland@gmail.com>
Content-Disposition: inline
In-Reply-To: <7c278d0c05091917232c79b909@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8935>

Dear diary, on Tue, Sep 20, 2005 at 02:23:56AM CEST, I got a letter
where Stefhen Hovland <stefhen.hovland@gmail.com> told me that...
> Attached is a simple patch adding support to cogito for "make deb".
> Please use if useful or let me know if this patch is offbase..

Thanks, applied. I just changed it so that the temporary directory is
removed after fakeroot completes successfully.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
