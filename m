From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: GIT smart http vs GIT over ssh
Date: Tue, 31 Jul 2012 07:10:11 +0400
Message-ID: <20120731031011.GA1685@localhost.localdomain>
References: <CACbucKmOxKLpY-iHDpX3GJ7BGsipR9hhXm8UA1hdbNdCzNMMRw@mail.gmail.com>
 <CACbucKnj5tqtAX5tJRRp+O8MA=tMD_xESsREPcAwffNS6Kvfag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: vishwajeet singh <dextrous85@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 05:10:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw2ql-0003z4-IH
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 05:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab2GaDKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 23:10:17 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:57581 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab2GaDKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 23:10:16 -0400
Received: from proxysrv.domain007.com (localhost [10.8.0.42] (may be forged))
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q6V3ACSU007812;
	Tue, 31 Jul 2012 07:10:13 +0400
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 2273DB22EA4; Tue, 31 Jul 2012 07:10:11 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <CACbucKnj5tqtAX5tJRRp+O8MA=tMD_xESsREPcAwffNS6Kvfag@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202627>

On Tue, Jul 31, 2012 at 08:36:07AM +0530, vishwajeet singh wrote:

> Just wanted to know the difference between smart http and ssh and in
> what scenarios we need them
> I am setting up a git server,  can I just do with smart http support
> or I need to enable the ssh support to use git effectively.
> As I understand github provides both the protocols, what's the reason
> for supporting both protocols.
http://git-scm.com/book/en/Git-on-the-Server-The-Protocols
http://git-scm.com/2010/03/04/smart-http.html
