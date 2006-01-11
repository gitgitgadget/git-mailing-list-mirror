From: Beber <beber.lkml@gmail.com>
Subject: Proxy and authentication
Date: Wed, 11 Jan 2006 15:53:23 +0100
Message-ID: <4615f4910601110653k5e2e8ffapb962a8b0829eeb11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Jan 11 15:53:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwhLt-0006z6-Cg
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 15:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWAKOx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 09:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWAKOx0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 09:53:26 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:17080 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751537AbWAKOxZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 09:53:25 -0500
Received: by uproxy.gmail.com with SMTP id s2so45982uge
        for <git@vger.kernel.org>; Wed, 11 Jan 2006 06:53:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DWEZoRb9noVBHktERWytZhiUxOeMNM3B2lwys6hc1BmgulfmZjjN8ecvUQxVmDY9p0EHF6f6/CDsKcCQ6mu0zsUl9lElrcREL128uPc9xy9t8H9lVpFfhBas0iookdsE9tPQiYvP2ld29nGLAQegL94z4vnOjEm1cYJ3/VSmW5w=
Received: by 10.66.251.13 with SMTP id y13mr312961ugh;
        Wed, 11 Jan 2006 06:53:23 -0800 (PST)
Received: by 10.66.242.15 with HTTP; Wed, 11 Jan 2006 06:53:23 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14485>

Hi,

Is there plan to allow proxy authentication and http/webdav remote
repository authentication ?
It seem that's it's quiet non-working for now.

Thanks
Beber
