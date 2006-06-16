From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: parsecvs and unnamed branches
Date: Fri, 16 Jun 2006 17:44:43 -0400
Message-ID: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 16 23:44:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrM7T-0002zW-HR
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 23:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWFPVoo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 17:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWFPVoo
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 17:44:44 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:21265 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751518AbWFPVoo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 17:44:44 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1244597nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 14:44:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RdRzxcHY29jModvBsYaicumlfQDenxPaTNpo4B2frnh7zapUbUIffP6zLcCpMEWqwS97EwU5OIc8N2ft2uk4e1aVpOJ1qv7syL1sxzs3h0DsF+Mcbl8qiv5DRlIPfNQtij+O5ZXoBYa/QC2/bwA5qZ5iS5eUM1JkBGZKSQfr5bo=
Received: by 10.36.252.12 with SMTP id z12mr983971nzh;
        Fri, 16 Jun 2006 14:44:43 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 16 Jun 2006 14:44:43 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21976>

I'm getting thousands of messages about unnamed branches and even
'unnamed branch from master-UNNAMED-BRANCH'.

How do you get unnamed branches into CVS, are these check-in errors or
are people actually working on unnamed branches? Or is parsecvs not
finding all of the branch info?

-- 
Jon Smirl
jonsmirl@gmail.com
