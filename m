From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: simple use case scenario for --read-tree and --write-tree with --prefix option
Date: Mon, 19 Jun 2006 12:58:00 +0530
Message-ID: <cc723f590606190028t65c76c74t6a90d1dcec411598@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jun 19 09:28:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsEBI-00026d-VF
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 09:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWFSH2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 03:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWFSH2G
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 03:28:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:28360 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932214AbWFSH2C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 03:28:02 -0400
Received: by nf-out-0910.google.com with SMTP id y25so1222231nfb
        for <git@vger.kernel.org>; Mon, 19 Jun 2006 00:28:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CowUR451c5W1oC8Zs1wMuefZulb0MwUQcEl9IF27xIGoplTUdSB3s6JYcpiPj15WXifl9wcz0WsCdVUoxSIyBtrqyePtbkj5/w5U6fJCaA+Ys2XEyuNpCDseNMDYBsSQVjNQy6wF6FFky9wHFreOek2mCiEruD5cbZnABnewPtw=
Received: by 10.48.222.12 with SMTP id u12mr4266322nfg;
        Mon, 19 Jun 2006 00:28:00 -0700 (PDT)
Received: by 10.49.90.13 with HTTP; Mon, 19 Jun 2006 00:28:00 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22116>

Hi all,

I searched the archives but didn't find anything. If i understand
correctly the sub project idea is using the gitlink object type. So
what is read-tree and write-tree with --prefix option supposed to
achieve.

-aneesh
