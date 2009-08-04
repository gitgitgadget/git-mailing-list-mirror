From: Arnaud Bailly <abailly@oqube.com>
Subject: Re: From P4 to Git
Date: Tue, 04 Aug 2009 14:31:42 +0200
Organization: OQube
Message-ID: <85ljlzvjyp.fsf@oqube.com>
References: <85ljm84lat.fsf@oqube.com> <m3fxcg3473.fsf@localhost.localdomain>
	<85r5vxbd8e.fsf@oqube.com> <200907311122.43918.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 14:35:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYJBa-0003gy-8w
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 14:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422AbZHDMcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 08:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755418AbZHDMcA
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 08:32:00 -0400
Received: from main.gmane.org ([80.91.229.2]:36493 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415AbZHDMb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 08:31:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MYJBO-0008BA-Ry
	for git@vger.kernel.org; Tue, 04 Aug 2009 12:31:58 +0000
Received: from 80.125.172.63 ([80.125.172.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 12:31:58 +0000
Received: from abailly by 80.125.172.63 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 12:31:58 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 80.125.172.63
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Cancel-Lock: sha1:D8+OdaEyji9V45NOCpCFSGlLr38=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 7.0 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  3.0 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in bl.spamcop.net
 *      [Blocked - see <http://www.spamcop.net/bl.shtml?80.125.172.63>]
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124781>

Thanks all for your detailed answers.

Playing with git on various environments, I have a couple more questions
that I could not (quickly) find answers on the web.
 1. when checkout-ing on NTFS, I got all my files marked as changed
 because of file permissions set from 100644 to 100755. I see there is a
 config flag about file permissions (core.sharedRepository ?) but not
 sure how to use it
 2. I am working with NTFS on a truecrypt managed USB HD and I noticed
 an order of magnitude difference in speed (ie. about 10x for checkout
 of 50k files) between this and my ext3 FS  on laptop HD. Is this
 expected ? Some people here reported slowness on non-encrypted NTFS and
 I think I read a couple of web fragments about speed difference between
 the 2. WDYT ?

Regards,
-- 
Arnaud Bailly -- OQube
<software engineering>
http://www.oqube.com/
