From: Folkert van Heusden <folkert@vanheusden.com>
Subject: retrieving a diff from git
Date: Tue, 14 Oct 2008 16:51:12 +0200
Organization: www.unixexpert.nl
Message-ID: <20081014145112.GR22427@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 17:09:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KplS3-0004mY-Ji
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 17:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbYJNPDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 11:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbYJNPDf
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 11:03:35 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:3108 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbYJNPDe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 11:03:34 -0400
X-Greylist: delayed 739 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Oct 2008 11:03:34 EDT
Received: from keetweej.vanheusden.com (keetweej.vanheusden.com [80.126.110.251])
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id m9EEq8pI050834
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 16:52:09 +0200 (CEST)
	(envelope-from folkert@vanheusden.com)
Received: from belle.intranet.vanheusden.com (belle.intranet.vanheusden.com [192.168.64.100])
	by keetweej.vanheusden.com (Postfix) with ESMTP id 4099E82CD
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 16:52:08 +0200 (CEST)
Received: by belle.intranet.vanheusden.com (Postfix, from userid 1000)
	id 3AD8F40226; Tue, 14 Oct 2008 16:52:08 +0200 (CEST)
Content-Disposition: inline
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sat Oct 11 11:14:03 CEST 2008
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to
	me with PGP!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98190>

Hi,

How would I retrieve the 'kmemcheck' patches from git for the 2.6.27
kernel? I browsed to the url
http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Fx86%2Flinux-2.6-tip.git&a=search&h=HEAD&st=commit&s=kmemcheck
but could not find how to retrieve that diff.


Folkert van Heusden

-- 
Ever wonder what is out there? Any alien races? Then please support
the seti@home project: setiathome.ssl.berkeley.edu
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
