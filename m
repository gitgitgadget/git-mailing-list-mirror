From: zhifeng hu <zf@ancientrocklab.com>
Subject: How to resume broke clone ?
Date: Thu, 28 Nov 2013 11:13:54 +0800
Message-ID: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 04:21:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlsAD-0004FW-QF
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 04:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758763Ab3K1DVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 22:21:10 -0500
Received: from relay1.ox.registrar-servers.com ([199.188.203.171]:34817 "EHLO
	relay1.ox.registrar-servers.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758758Ab3K1DVI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 22:21:08 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Nov 2013 22:21:08 EST
Received: (qmail 616 invoked by uid 89); 28 Nov 2013 03:14:26 -0000
Received: from unknown (HELO imap1.ox.registrar-servers.com) (198.187.29.233)
  by relay.ox.registrar-servers.com with SMTP; 28 Nov 2013 03:14:26 -0000
Received: from localhost (localhost [127.0.0.1])
	by oxmail.registrar-servers.com (Postfix) with ESMTP id 1A559200081
	for <git@vger.kernel.org>; Wed, 27 Nov 2013 22:14:04 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at imap1.ox.registrar-servers.com
Received: from oxmail.registrar-servers.com ([127.0.0.1])
	by localhost (imap1.ox.registrar-servers.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jVNndlHb--6A for <git@vger.kernel.org>;
	Wed, 27 Nov 2013 22:14:04 -0500 (EST)
Received: from [192.168.1.101] (unknown [111.172.231.216])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by oxmail.registrar-servers.com (Postfix) with ESMTPSA id BF96A200089
	for <git@vger.kernel.org>; Wed, 27 Nov 2013 22:14:02 -0500 (EST)
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238472>

Hello all:
Today i want to clone the Linux Kernel git repository.
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

I am in china. our bandwidth is very limitation. Less than 50Kb/s.

The clone progress is very slow, and broken times and time.
I am very unhappy. 
Because i could not easily to clone kernel.

I had do some research about resume clone , but no good plan how to resolve this problem .


Would it be possible add resume transfer clone repository after the transfer broken?

such as bittorrent  download. or what ever.

zhifeng hu 
