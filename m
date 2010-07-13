From: wiekaltheut@gmx.de
Subject: Treat submodules as normal directories/files?
Date: Tue, 13 Jul 2010 08:14:51 +0200
Message-ID: <20100713061451.308580@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 13 08:15:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYYm9-0008Hz-Tu
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 08:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab0GMGO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 02:14:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:43808 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752026Ab0GMGOx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 02:14:53 -0400
Received: (qmail 28677 invoked by uid 0); 13 Jul 2010 06:14:51 -0000
Received: from 77.7.188.198 by www051.gmx.net with HTTP;
 Tue, 13 Jul 2010 08:14:51 +0200 (CEST)
X-Authenticated: #4797103
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX18VuToENhAVQeBEdVlvXfL1CdN+zE/kVVaCVKA2va
 NVJ/dgPQAY8OVP0VRu5HaN27UR6PzJgjv5cw== 
X-GMX-UID: YzYFebE1eWUoSMdTOnVzj/kxU3U4Nw9E
X-FuHaFi: 0.68000000000000005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150879>

Hi!

Is it possible to treat submodules as normal 
directories/files?

I'm using Git not just for source code, but also for 
documents and my "projects" directory (mainly an
Eclipse Workspace) in my home directory. Though Git
may not be designed for this, it is an easy way do
create a backup and sync my home directory between
my machines :-).

This works fine, except for Git repositories inside my 
home (projects) directory. Is there a way, to treat 
them like normal directories so I can add them via git 
add?

Thank you and thanks for Git, which is just great :-).
-- 
GMX DSL: Internet-, Telefon- und Handy-Flat ab 19,99 EUR/mtl.  
Bis zu 150 EUR Startguthaben inklusive! http://portal.gmx.net/de/go/dsl
