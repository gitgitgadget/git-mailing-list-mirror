From: Liu Yubao <yubao.liu@gmail.com>
Subject: Does GIT require property like Subversion?
Date: Sun, 08 Oct 2006 17:10:51 +0800
Message-ID: <4528C09B.3030004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 08 11:11:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWUhD-0004Ik-Fz
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 11:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWJHJLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 05:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWJHJLk
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 05:11:40 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:39596 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750972AbWJHJLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 05:11:39 -0400
Received: by py-out-1112.google.com with SMTP id n25so1874031pyg
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 02:11:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ifCxml7JODesmA0KISkw/TN8L26uastTk4vLURJdYd0q8JnMWbxVSeb9HpEbm2USkdpq0Yv45wqfJUu6ObDHKz80IBE4aCX2ntYlYsl+p6OESuytP+n5lw7UaVp59pM/BRVcFSvSNS9RC2DCNJtbXjxc+orDsTECq839Aik1A0Y=
Received: by 10.35.74.1 with SMTP id b1mr10061960pyl;
        Sun, 08 Oct 2006 02:11:38 -0700 (PDT)
Received: from ?192.168.88.85? ( [221.122.47.70])
        by mx.google.com with ESMTP id w66sm2116242pyw.2006.10.08.02.11.37;
        Sun, 08 Oct 2006 02:11:38 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28526>

I want to know whether there is a plan to add this feature, or GIT doesn't
require it at all.

Properties like encoding (path name, file content), eol-style, mime-type
are useful for editing.

BTW: I don't mean Subversion is better that GIT:-)
