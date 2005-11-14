From: Franck <vagabon.xyz@gmail.com>
Subject: Can't use gitk.
Date: Mon, 14 Nov 2005 11:53:39 +0100
Message-ID: <cda58cb80511140253s92f28e2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Nov 14 11:56:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebby3-0007zv-Co
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 11:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVKNKxl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 05:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVKNKxl
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 05:53:41 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:36163 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751079AbVKNKxk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 05:53:40 -0500
Received: by zproxy.gmail.com with SMTP id 14so1234251nzn
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 02:53:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OEWIIXMlC646MmVEvJgoaVPvLnbyAlx1OSKF8HLn0c35VFVUC4dC/yzU6KIAs8bh1VQ1Cnw5G4ezUYP606EQC9orY9q8EelitgHfFT1zyEr0aLHBMJAIUV5mIA22mGRCGwuPgHAdAcuWp6N0/tWoJsGd+qHpcZgPbjcCvGeNTzw=
Received: by 10.36.224.48 with SMTP id w48mr1725599nzg;
        Mon, 14 Nov 2005 02:53:39 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Mon, 14 Nov 2005 02:53:39 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11787>

Hi,

I'm trying to use gitk --all command but it fails like this:

"""
Error executing git-rev-list: couldn't execute "git-rev-list": no such
file or directory
"""

I'm running git on a fedora core 3. Can anybody give me some help ?

Thanks
--
               Franck
