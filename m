From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Possibly-spurious 'not uptodate. Cannot merge'
Date: Mon, 15 Dec 2008 01:03:54 +0000 (UTC)
Organization: disorganised!
Message-ID: <gi4adq$cr1$1@ger.gmane.org>
References: <874p16puuq.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 02:06:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC1u8-00061Y-B3
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 02:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbYLOBER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 20:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbYLOBEL
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 20:04:11 -0500
Received: from main.gmane.org ([80.91.229.2]:51829 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbYLOBEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 20:04:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LC1sP-0007lX-TI
	for git@vger.kernel.org; Mon, 15 Dec 2008 01:04:01 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 01:04:01 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 01:04:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103120>

On 2008-12-14, Nix <nix@esperi.org.uk> wrote:
> In this situation, 'git diff' reports no changes at all, but 'git reset
> --hard' gets the tree back into a state where merging succeeds, as does
> 'git update-index --refresh'.

Wasn't there some situation in which merely running 'git
status' would have a similar effect?  I seem to recall
reading that somewhere but now I can't find any mention of
it in 'git help status'.
