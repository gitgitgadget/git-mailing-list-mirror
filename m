From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Does GIT has vc keywords like CVS/Subversion?
Date: Mon, 9 Oct 2006 09:25:47 +0800
Message-ID: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 09 03:26:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWju5-0004wn-3U
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 03:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWJIBZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 21:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWJIBZt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 21:25:49 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:59732 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751581AbWJIBZs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 21:25:48 -0400
Received: by py-out-1112.google.com with SMTP id n25so2112630pyg
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 18:25:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Gh/RwvKIQp4Gs+iRrw6Aj0o9u7yjM9Rj5vMglJ1MEx4B6n4JUp9aKl77cTGCPHURlKNxlrZVXPCNpfmtKNxnY6ZRqK4YduXFIKWqM7tG80YOafWPuVLuXThOFtQwQCYescv4B/sivqK1n4RB7s4j99XpKfKK87bs3IFqAEfP1nw=
Received: by 10.35.132.20 with SMTP id j20mr11639307pyn;
        Sun, 08 Oct 2006 18:25:47 -0700 (PDT)
Received: by 10.35.106.3 with HTTP; Sun, 8 Oct 2006 18:25:47 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28557>

I want to know whether there is a plan to add this feature, or GIT
doesn't require it at all.

Keywords like LastChangedDate, LastChangedRevision, LastChangedBy, Id
are useful for version control.

Dongsheng
