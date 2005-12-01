From: "Ju, Seokmann" <Seokmann.Ju@engenio.com>
Subject: HELP: How to setup git on the system
Date: Thu, 1 Dec 2005 11:48:11 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703662C6B@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Ju, Seokmann" <Seokmann.Ju@engenio.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 17:53:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhrbY-0003BD-FZ
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 17:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVLAQsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 11:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVLAQsR
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 11:48:17 -0500
Received: from mail0.lsil.com ([147.145.40.20]:36789 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932322AbVLAQsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 11:48:16 -0500
Received: from milmhbs0.lsil.com (mhbs.lsil.com [147.145.1.30])
	by mail0.lsil.com (8.12.8/8.12.8) with ESMTP id jB1GhSSW023594
	for <git@vger.kernel.org>; Thu, 1 Dec 2005 08:43:28 -0800 (PST)
Received: from EXA-ATLANTA.se.lsil.com (atl1.se.lsil.com [147.145.16.4])
	by milmhbs0.lsil.com (8.12.11/8.12.11) with ESMTP id jB1GmFbl031501
	for <git@vger.kernel.org>; Thu, 1 Dec 2005 08:48:16 -0800
Received: by exa-atlanta with Internet Mail Service (5.5.2658.27)
	id <46HA4HLS>; Thu, 1 Dec 2005 11:48:15 -0500
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-Mailer: Internet Mail Service (5.5.2658.27)
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13063>

Hi,

I'm trying to get clone image of 2.6 kernel throgh git and getting following
message during cloning.
[root@dhcp root]# git clone
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
linux-2.6
defaulting to local storage area
rsync: failed to connect to rsync.kernel.org:Connection timed out (110)
rsync error : error in socket IO (code 10) at clientserver.c(94)

I've RHEL 4 U2 on IA32 platform.
The platform has network configured with DHCP (with no firwall enabled).

Any comment would be appreciated.

Thank you,

Seokmann
