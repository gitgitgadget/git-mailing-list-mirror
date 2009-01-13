From: Vladimir Pouzanov <farcaller@gmail.com>
Subject: Re: git-svn fails to fetch repository
Date: Tue, 13 Jan 2009 20:46:55 +0000 (UTC)
Message-ID: <loom.20090113T204616-845@post.gmane.org>
References: <loom.20090113T145019-951@post.gmane.org> <loom.20090113T150220-345@post.gmane.org> <496CD49D.1070201@drmicha.warpmail.net> <loom.20090113T185918-397@post.gmane.org> <20090113203922.GD30404@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 21:50:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMqBb-0000zK-BF
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 21:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbZAMUrM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 15:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbZAMUrL
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 15:47:11 -0500
Received: from main.gmane.org ([80.91.229.2]:58003 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbZAMUrK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 15:47:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LMqAD-0006Lg-Dj
	for git@vger.kernel.org; Tue, 13 Jan 2009 20:47:05 +0000
Received: from 122-249-112-92.pool.ukrtel.net ([122-249-112-92.pool.ukrtel.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 20:47:05 +0000
Received: from farcaller by 122-249-112-92.pool.ukrtel.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 20:47:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.112.249.122 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105533>

Bj=C3=B6rn Steinbrink <B.Steinbrink <at> gmx.de> writes:
> Is that Linux box using Gentoo? If so, try emerging subversion with -=
dso
> in your build flags.

Yeah, that's gentoo. Will try rebuilding svn now. Any hints about OSX
perl problem?
