From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: parsecvs fails
Date: Thu, 25 May 2006 17:02:12 +0530
Message-ID: <cc723f590605250432r7dd0b75xe5ff17b11da06e3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu May 25 13:32:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjE4p-0007wT-AI
	for gcvg-git@gmane.org; Thu, 25 May 2006 13:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWEYLcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 07:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWEYLcN
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 07:32:13 -0400
Received: from wx-out-0102.google.com ([66.249.82.201]:31001 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965080AbWEYLcN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 07:32:13 -0400
Received: by wx-out-0102.google.com with SMTP id s6so1285587wxc
        for <git@vger.kernel.org>; Thu, 25 May 2006 04:32:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AgYned4drcZ3HJ4TkJMsdmqbvjekoofabEEN+cD/s9pMLWUgaxCMuFbXcOXETBmiEfeppriccO3csWPfVPloQanEi9SWqFlCsr2M2gk1dg87FqS+phxp8KR/duZz4XJfuQvZkaCqWIl2RW0n1dZbSqbBzmP0oyVatnhphPP9zVE=
Received: by 10.70.80.11 with SMTP id d11mr45313wxb;
        Thu, 25 May 2006 04:32:12 -0700 (PDT)
Received: by 10.70.38.19 with HTTP; Thu, 25 May 2006 04:32:12 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20734>

The tagging used by the repository given below is quiet complex.
But it can be used as a test case for all the cvs to git converter.
Even ViewVC and ViewCVS doesn't work with this repository.

Any help in converting it to git ?

rsync -av rsync://ci-linux.cvs.sourceforge.net/cvsroot/ci-linux/ci/ ci-linux/ci/

-aneesh
