From: sylvain@demarque.qc.ca
Subject: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 01:28:26 -0400
Message-ID: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 07:39:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxDcY-00039A-UH
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 07:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbZJLFg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 01:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbZJLFg0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 01:36:26 -0400
Received: from secure01.megaquebec.net ([199.202.64.88]:55861 "EHLO
	mqplesk1l.megaquebec.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbZJLFgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 01:36:25 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2009 01:36:25 EDT
Received: (qmail 11785 invoked by uid 48); 12 Oct 2009 01:28:26 -0400
Received: from modemcable009.10-130-66.mc.videotron.ca
	(modemcable009.10-130-66.mc.videotron.ca [66.130.10.9]) by
	webmail.demarque.qc.ca (Horde MIME library) with HTTP; Mon, 12 Oct 2009
	01:28:26 -0400
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129984>

Git is good, Git is great! All praise the Git! :-D

What do you people think about this strange phenomena?

localhost / # git --version
git version 1.6.4.4

localhost / # git init
Initialized empty Git repository in //.git/

localhost / # cd etc
localhost etc # git add X11/xorg.conf
fatal: pathspec 'etc/X11/xorg.conf' did not match any files

Aside from the obvious question of why would I want to Git the whole
tree ("But all files deserve the Holy Presence of the Git!"), why does
Git refuse the love offering from "/etc/X11/xorg.conf"? Is it because
it contains font directory configurations?

Commit and [ENTER] to all,

S! :-)
