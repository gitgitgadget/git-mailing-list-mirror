From: "=?utf-8?Q?David_Ond=C5=99ich?=" <david.ondrich@aveco.com>
Subject: QNX support
Date: Thu, 21 Feb 2013 14:05:21 +0100
Message-ID: <430B4DD0-B796-4DB2-861D-C1F81302A4D1@aveco.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 14:11:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8VvP-0005r0-MH
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 14:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab3BUNKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 08:10:35 -0500
Received: from debian.aveco.com ([194.149.122.58]:62678 "EHLO debian.aveco.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332Ab3BUNKe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2013 08:10:34 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2013 08:10:34 EST
Received: from macbook-do-w.aveco.com (MacBook-DO-W.aveco.com [172.16.2.243])
  (AUTH: PLAIN david.ondrich@aveco.com, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by debian.aveco.com with esmtp; Thu, 21 Feb 2013 14:05:31 +0100
  id 00005C40.51261B9B.000177FD
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216771>

Hi,

I've read [1] recently, there's been some QNX port being initiated. Does that involve also old versions of QNX 4?

Since we are using QNX both internally and for our customers we started porting Git on QNX ourselves some time ago and we do have some experiences. Basically, it's possible to get Git up and running but there are some limitations, and some hacks have to be applied.

If some additional info wanted, please contact me.

dond

[1] http://lkml.indiana.edu/hypermail/linux/kernel/1302.2/00406.html