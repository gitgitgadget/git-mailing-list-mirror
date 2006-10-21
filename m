From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: less -F ubuntu dapper.
Date: Sat, 21 Oct 2006 18:53:35 +0530
Message-ID: <cc723f590610210623sbee2075i5f2fd441cceb84ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 21 15:23:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbGpB-00070c-4g
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 15:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422627AbWJUNXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 09:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423257AbWJUNXh
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 09:23:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:51305 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422627AbWJUNXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 09:23:36 -0400
Received: by nf-out-0910.google.com with SMTP id p48so1711720nfa
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 06:23:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dzVodSv12RVdUo6B+7iHY4yWEHXCMQunGDlRnYrD9e+HQ1Glbp4/xc+aTCnHacCuIl86rYGqc2Z4fiE4maCFF06BydkgRcnJIL9f4+n8ikfCiQRxAhRoEt7V3UbiFoBvBxUCVvouaX0IGvWjNCzSX+C4s0/4s0jKwo9btIez8vU=
Received: by 10.49.19.18 with SMTP id w18mr10228412nfi;
        Sat, 21 Oct 2006 06:23:35 -0700 (PDT)
Received: by 10.49.57.9 with HTTP; Sat, 21 Oct 2006 06:23:35 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29610>

-F option for less in ubuntu Dapper is broken. It doesn't display
anyting if the file can be displayed in one page. Because of this the
recent chages to
96a035d1db9082d244867033020d0ceb571cf94e results in commands like git
show not showing the changes.

https://launchpad.net/distros/ubuntu/+source/less/+bug/67381


-aneesh
