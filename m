From: Matthew Booth <matthew@heisenbug.com>
Subject: git-bundle questions
Date: Tue, 06 Nov 2007 20:54:03 +0000
Message-ID: <1194382443.5568.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 22:18:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpVoL-00069n-F9
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 22:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbXKFVRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 16:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754843AbXKFVRx
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 16:17:53 -0500
Received: from heisenbug.com ([72.249.77.208]:37664 "EHLO heisenbug.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716AbXKFVRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 16:17:52 -0500
X-Greylist: delayed 1423 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2007 16:17:52 EST
Received: from [192.168.1.201] (host81-159-251-199.range81-159.btcentralplus.com [81.159.251.199])
	by heisenbug.com (Postfix) with ESMTP id D5D624A50134
	for <git@vger.kernel.org>; Tue,  6 Nov 2007 20:54:08 +0000 (GMT)
X-Mailer: Evolution 2.8.0 (2.8.0-40.el5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63729>

First a question: when creating a git bundle, is it possible to include
tags?

Secondly, has anybody given any thought to allowing a user to create a
bundle from any of the web front-ends? The reason for this request is
that I've been doing some work for a company where only corporate
standard desktops have internet access. They run Windows, and you can't
install additional software on them. This makes interacting with an
external git repository from my development servers problematic. Git
bundles do at least make this possible, but I have to create a bundle on
my laptop when I'm at home and transfer it to a server when I get to the
office. This would be a whole lot easier if I could just download the
bundle at the office.

Thanks,

Matt
