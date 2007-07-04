From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: git-svn dcommit fail
Date: Wed, 4 Jul 2007 17:56:33 +0800
Message-ID: <4b3406f0707040256x31f0909cie126d950c60374f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 11:56:49 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I61bI-0006DX-RK
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 11:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758318AbXGDJ4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 05:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758641AbXGDJ4g
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 05:56:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:46277 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758450AbXGDJ4d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 05:56:33 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2037149wxd
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 02:56:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KbS1TuEW5oSL2cecR7cPk320ikYi7mINq82EGFCffUS0dkN9Kk9CJa3m0SGUZbcvhi8Dq9ujB0a9tKKlyslnKIeiMvNp23baGB7IkssFC1v1oHU7IOk/3AGfLx/yN07Rp1XdiuHhIXg8CjQRGm5Z//6Fxm2eBtfL1nJS2ALefTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m25quEWbr8GOqUHppG1r3ALT705p1JzDdkswb+rqsqaW3Pb1Qj45IpAhv4R9633/CDITGNn3qh1rCnKrruO2BJ4aNVtXOYjbrT4guWvbW7bnlRepYllWKKn3AHX1/UagRqf2I3Xa5Y6M8Bl9xbpAgdvMT6XqsZb9Pe5O7sPc0O8=
Received: by 10.70.37.12 with SMTP id k12mr7112576wxk.1183542993199;
        Wed, 04 Jul 2007 02:56:33 -0700 (PDT)
Received: by 10.70.43.18 with HTTP; Wed, 4 Jul 2007 02:56:33 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51585>

After some merge operation,

$ git-svn rebase
Current branch master is up to date.
$ git-svn dcommit
Unable to extract revision information from commit
f10ff0772f96ec434b27d47efaee082190bb8516~1

Thanks for some help.

---
Dongsheng
