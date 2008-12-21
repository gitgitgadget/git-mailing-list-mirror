From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Retrieving last tag of a working tree
Date: Sun, 21 Dec 2008 14:53:17 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngksm2t.p3b.sitaramc@sitaramc.homelinux.net>
References: <21071491.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 15:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEPhe-0000wF-Lo
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 15:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbYLUOx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 09:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYLUOx2
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 09:53:28 -0500
Received: from main.gmane.org ([80.91.229.2]:48009 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbYLUOx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 09:53:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LEPgK-0001nW-HM
	for git@vger.kernel.org; Sun, 21 Dec 2008 14:53:24 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 14:53:24 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 14:53:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103702>

On 2008-12-18, the_jack <josip@yopmail.com> wrote:
>
> output. This works, but it's not quite reliable. There has to be a better
> way for getting the last tag of current working tree. If I checkout an

git describe?
