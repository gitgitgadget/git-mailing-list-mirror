From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: core.autocrlf and merge conflict output
Date: Sun, 22 Jun 2008 21:47:36 -0400
Message-ID: <g3mvbh$mmj$1@ger.gmane.org>
References: <g3miho$se5$1@ger.gmane.org> <7vy74xj7ww.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 03:48:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAbAZ-0004Rc-Pq
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 03:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbYFWBrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 21:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbYFWBrk
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 21:47:40 -0400
Received: from main.gmane.org ([80.91.229.2]:53652 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbYFWBrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 21:47:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KAb9d-0004AP-N9
	for git@vger.kernel.org; Mon, 23 Jun 2008 01:47:37 +0000
Received: from ool-18e45099.dyn.optonline.net ([24.228.80.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 01:47:37 +0000
Received: from edwardzyang by ool-18e45099.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 01:47:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18e45099.dyn.optonline.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041206 Thunderbird/1.0 Mnenhy/0.6.0.104
In-Reply-To: <7vy74xj7ww.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
OpenPGP: id=869C48DA;
	url=http://www.thewritingpot.com/gpgpubkey.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85825>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Junio C Hamano wrote:
> Is this an old news before 249c61a (merge-recursive: respect core.autocrlf
> when writing out the result, 2008-06-09) happened?

Apparently, yes. :o) Thus are the perils of working off a "downstream"
branch. I'll go bug the git/mingw/4msysgit.git maintainers to get this
change merged in. Thanks!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIXwC4qTO+fYacSNoRAi8RAJ4/ZF0C0XB9QSPgCnQYae/33YSRUgCff/y5
5Dd9vy/pQQsNJbyQ+xfc4lY=
=fyGn
-----END PGP SIGNATURE-----
