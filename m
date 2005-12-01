From: "Ju, Seokmann" <Seokmann.Ju@engenio.com>
Subject: How to set-up git on my system
Date: Thu, 1 Dec 2005 10:42:18 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703662C66@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain
X-From: git-owner@vger.kernel.org Thu Dec 01 16:47:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhqZt-000710-Mp
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 16:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVLAPmX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 10:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbVLAPmX
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 10:42:23 -0500
Received: from mail0.lsil.com ([147.145.40.20]:16300 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932298AbVLAPmW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 10:42:22 -0500
Received: from milmhbs0.lsil.com (mhbs.lsil.com [147.145.1.30])
	by mail0.lsil.com (8.12.8/8.12.8) with ESMTP id jB1FbXSW020172
	for <git@vger.kernel.org>; Thu, 1 Dec 2005 07:37:33 -0800 (PST)
Received: from EXA-ATLANTA.se.lsil.com (atl1.se.lsil.com [147.145.16.4])
	by milmhbs0.lsil.com (8.12.11/8.12.11) with ESMTP id jB1FgLue012133
	for <git@vger.kernel.org>; Thu, 1 Dec 2005 07:42:21 -0800
Received: by exa-atlanta with Internet Mail Service (5.5.2658.27)
	id <46HA4HAJ>; Thu, 1 Dec 2005 10:42:20 -0500
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-Mailer: Internet Mail Service (5.5.2658.27)
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13061>

Hi,

I'm trying to use git and in the middle of installing it on the RHEL4 U2.
I have following modules in hand.
- git-core-0.99.7-1.i386.rpm
- cogito-0.15.1-1.noarch.rpm

During 'git-core-0.99.7-1.i386.rpm' installation, I'm getting following
error message,
[root@dhcp root]# rpm-ihv git-core-0.99.7-1.i386.rpm
error: Failed dependencies:
	perl(String::ShellQuote) is needed by git-core-0.99.7-1.i386
	python >= 2.4 is needed by git-core-0.99.7-1.i386

Where can I find those modules?
Also, please point out if you see any further obstacles along the way to
move forward.

Any feedback would be appreciated.

Regards,

Seokmann
