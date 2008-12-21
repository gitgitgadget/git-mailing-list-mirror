From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Applying patches from a patch set
Date: Sun, 21 Dec 2008 08:20:19 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngkrv22.knd.sitaramc@sitaramc.homelinux.net>
References: <dac45060812200637m49c71aa5x3c25010fa00f4a63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 09:21:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEJZM-0007gC-DZ
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 09:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbYLUIUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 03:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYLUIUa
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 03:20:30 -0500
Received: from main.gmane.org ([80.91.229.2]:53617 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbYLUIU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 03:20:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LEJY2-0006Z4-Rt
	for git@vger.kernel.org; Sun, 21 Dec 2008 08:20:26 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 08:20:26 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 08:20:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103692>

On 2008-12-20, Mark Ryden <markryde@gmail.com> wrote:

>   I am subscribed to some linux kernel subsystem mailing list; in this
> list there are sometimes patchsets with more than
> 30-40 patches.
> I am using gmail web interface client.

solution 1: see if that list is mirrored by gmane and use a
newsreader like slrn to access the list via gmane

solution 2: enable pop/imap access on your gmail account and
pull emails from there using whatever command line mail
client you like (like mutt maybe).  Not tested, but should
work.  For some definition of "work" (not sure how gmail's
"tags" map to imap folders, which might trip you...)
