From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Source highlight in qgit
Date: Tue, 22 Aug 2006 19:52:47 +0200
Message-ID: <e5bfff550608221052n7bd2be7fy9639c4d78db5cd08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Lorenzo Bettini" <bettini@dsi.unifi.it>
X-From: git-owner@vger.kernel.org Tue Aug 22 19:53:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFaQv-00012u-4I
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 19:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWHVRwv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 13:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWHVRwv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 13:52:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:41638 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751424AbWHVRwu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 13:52:50 -0400
Received: by nf-out-0910.google.com with SMTP id o25so122229nfa
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 10:52:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=n+mxJ6iNRTO0JTnJbXm6Sn2iRnIV0xOThAAEjKQiG6ckETbzXcta9LkqehYvy1tu20iWt7nuWxZxfRwLSLv4nirCBok12H7b9RuwDNCA14t/uAbTLsc6qiNkV933bFj42l9RKNUI0LbWXkVQ4y0le3JMN6vIJ4KU0Q7/D69PqXo=
Received: by 10.35.106.15 with SMTP id i15mr15999027pym;
        Tue, 22 Aug 2006 10:52:48 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Tue, 22 Aug 2006 10:52:47 -0700 (PDT)
To: "GIT list" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25865>

Thanks to the nice and powerful tool  GNU Source-highlight
(http://www.gnu.org/software/src-highlite/) qgit now supports file
viewer with syntax highlight.

Advertising screenshot: http://digilander.libero.it/mcostalba/src_hlt_3.png

I've found GNU Source-highlight quite easy to integrate so I post this
as an info/hint for people that could be interested (read gitweb
team).

A patch as been pushed to git://git.kernel.org/pub/scm/qgit/qgit.git

Thanks
Marco
