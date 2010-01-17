From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Git Wiki Move
Date: Sun, 17 Jan 2010 13:00:57 +0100
Message-ID: <vpqwrzhszye.fsf@bauges.imag.fr>
References: <20100113232908.GA3299@machine.or.cz>
	<20100114012449.GB3299@machine.or.cz>
	<4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr>
	<4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sun Jan 17 13:03:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWTqr-0000TF-2f
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 13:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab0AQMCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 07:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852Ab0AQMCM
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 07:02:12 -0500
Received: from mx1.imag.fr ([129.88.30.5]:42148 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab0AQMCL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 07:02:11 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o0HC0Pcp011517
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 17 Jan 2010 13:00:25 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NWToP-0004xT-Lh; Sun, 17 Jan 2010 13:00:57 +0100
In-Reply-To: <4B50F7DB.7020204@eaglescrag.net> (J. H.'s message of "Fri\, 15 Jan 2010 15\:18\:51 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 17 Jan 2010 13:00:26 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0HC0Pcp011517
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1264334426.59566@RsYSDDIgjYqySXj8VPsQlg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137295>

"J.H." <warthog19@eaglescrag.net> writes:

> Quick update - I think I've got the vast majority of the obvious and
> simple to correct problems fixed at http://git.wiki.kernel.org anyone
> want to run through and see if there's anything else that would be
> considered a show stopper?

The main page is locked, and there are some broken links formatting in
the News section: http://git.wiki.kernel.org/index.php/Main_Page#News
I'm user "Moy" there if you want to let me fix them.

You should set $wgLogo to some Git logo, among
http://git.or.cz/gitwiki/GitRelatedLogos

You can also add a few links to the sidebar, by editting:
http://git.wiki.kernel.org/index.php/MediaWiki:Sidebar

(it seems I don't have permission to do it myself). I suggest taking
the ones of the front-page:

* Starting points
** Installation|Installation
** InterfacesFrontendsAndTools|Git Tools
** GitDocumentation|Git Documentation
** GitCommunity|Git Community Support
** GitProjects|Projects using Git
** GitFaq|FAQ
** GitHosting|Git Hosting
** GitLinks|Git Links
** GitComparison|Git Compared

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
