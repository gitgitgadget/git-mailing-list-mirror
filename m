From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: problem installing egit into eclipse
Date: Fri, 4 Apr 2008 19:51:01 -0400
Message-ID: <p06240811c41c6f55e17f@[63.138.152.125]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 05 01:51:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhvhK-0001Tg-DU
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 01:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbYDDXvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 19:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbYDDXvK
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 19:51:10 -0400
Received: from deanbrook.org ([66.160.189.173]:60350 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751454AbYDDXvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 19:51:09 -0400
Received: from 63.138.152.125 ([63.138.152.125]) by deanbrook.org for <git@vger.kernel.org>; Fri, 4 Apr 2008 16:51:08 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78824>

>I've been able to build egit but I'm getting these errors when I Export the Deployable plug-ins and fragments to my eclipse folder.
>
>BUILD Failed
>java.lang.IllegalArgumentException
>BUILD Failed
>java.lang.IllegalArgumentException

The problem was a space in one of the dir names on the path -- works fine now.
