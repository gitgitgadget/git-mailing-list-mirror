From: Rico Secada <coolzone@it.dk>
Subject: Git pull doesn't get the tags
Date: Fri, 22 Oct 2010 05:37:47 +0200
Message-ID: <20101022053747.a5427cad.coolzone@it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 05:40:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P98UF-0001WE-79
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 05:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783Ab0JVDkC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 23:40:02 -0400
Received: from smtp.fullrate.dk ([90.185.1.42]:49679 "EHLO smtp.fullrate.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126Ab0JVDkA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 23:40:00 -0400
Received: from workp4 (4304ds5-ynoe.0.fullrate.dk [90.185.142.211])
	by smtp.fullrate.dk (Postfix) with SMTP id 12AED9D02C
	for <git@vger.kernel.org>; Fri, 22 Oct 2010 05:39:57 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159632>

Hi.

I am working on a repo on my desktop and I got a clone on my laptop.
I needed to pull the new stuff from my desktop unto my laptop, and I
noticed that tags doesn't get pulled.

The laptop access the desktop using NFS and I am using "git pull
NFS_SOURCE".

The repos are identical except that a few files has been updated and a
new tag has been added.

Why doesn't pull get the tag?

Best regards.
