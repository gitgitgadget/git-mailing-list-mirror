From: "Steve Hoelzer" <shoelzer@gmail.com>
Subject: No "pull" in git gui?
Date: Fri, 26 Sep 2008 09:37:57 -0500
Message-ID: <588192970809260737i46ce0c30y191e29156bbf6396@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 26 16:39:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjETR-0006wq-0b
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 16:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbYIZOiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 10:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbYIZOiA
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 10:38:00 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:44873 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYIZOiA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 10:38:00 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1134975wfd.4
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=/AIm0YFg72rYHnRnlUcWkRgUAyyS/bdQOgcZuZ5/EWU=;
        b=mBq+uHW2g9kYcoUtKf0PacgHt2zZ6L0coCmLxpfN+1ENyf9mX6/hqQSFZ8S0oS81JQ
         2kunjKZr/euZqTblYk4OoeGhyjBWHeoCT8Z+hOZSvTZmBWk7IfeAaMiaJwAwehhzUASH
         CNI4GKu737J49it5o2uy6fIBqntFjflUWbQuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=uYIrTWC7NpjUYkJIBV5icNsLJsx9KFouJMfZsrx+DX3JiC+Kx4HZ9dRuRl5Ejs19dx
         7VMp10g1iNUPKlBBTHDCwqiCFi/kWJf6u1DfuOzR3rRW53FtfZuEpAeEcIhofcc1PDGp
         Xbc9FCPlrG3dg4Q+ixiUwqxfaxJJClFkcZXd8=
Received: by 10.114.39.5 with SMTP id m5mr1451542wam.113.1222439877345;
        Fri, 26 Sep 2008 07:37:57 -0700 (PDT)
Received: by 10.114.153.17 with HTTP; Fri, 26 Sep 2008 07:37:57 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96859>

Why isn't there a pull command in git gui's remote menu? Am I supposed
to fetch and then merge? Is that preferred over pull for some reason?

Steve
