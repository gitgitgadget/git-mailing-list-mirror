From: "franky" <yinping@kooxoo.com>
Subject: should git command and git-command be equivalent?
Date: Tue, 16 Oct 2007 11:22:39 +0800
Message-ID: <20071016032240.AD2FD7E80@mail.kooxoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 05:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihd1A-0004B1-4o
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 05:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758049AbXJPDWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 23:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757828AbXJPDWm
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 23:22:42 -0400
Received: from mail.kooxoo.com ([60.28.194.208]:45584 "EHLO mail.kooxoo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757890AbXJPDWl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 23:22:41 -0400
Received: from yinping (unknown [124.42.17.129])
	by mail.kooxoo.com (Postfix) with ESMTP id AD2FD7E80
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 11:22:40 +0800 (CST)
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcgPo84DwCA0USXaSf6XlsU25mah3Q==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61067>

	I use git-init frequently and it confuses me for a long time that I
can't init a bare repository. 
	I just found I can do that by "git -bare init". However, I get used
to "git-init" and I always tried "git-init -bare" (of course failed)
	And I thought git-init and "git init" were always the same as most
newbies of git. So, should git init and git-init be equivalent? If not, I
think the document should be supplemented to clarify this.

 franky
