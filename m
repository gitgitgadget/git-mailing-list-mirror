From: Aubrey <aubreylee@gmail.com>
Subject: git push issue
Date: Thu, 2 Mar 2006 17:47:36 +0800
Message-ID: <6d6a94c50603020147l450d1cdfp1bc1747dc79189ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Mar 02 10:47:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEkPN-0000c1-Cq
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 10:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWCBJri (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 04:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWCBJri
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 04:47:38 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:41924 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751423AbWCBJrh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 04:47:37 -0500
Received: by zproxy.gmail.com with SMTP id 13so384518nzn
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 01:47:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nnYaSW0jANQwckSpJdye0RDgSVbG6eAj8iekeWxrqwAi/Q7fJ3NqW46rtAUpqBicBXS4k+MwHVabHck0bj83i3kZi4PiGjujEth5V68m1/XbmuYWGaouqPbMdYZ5zxwJlvHb9C2cBiR+3t/YI2d1OZVtccWmF1db/bCCCCpNgJ0=
Received: by 10.65.250.11 with SMTP id c11mr570912qbs;
        Thu, 02 Mar 2006 01:47:36 -0800 (PST)
Received: by 10.65.185.6 with HTTP; Thu, 2 Mar 2006 01:47:36 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17060>

Hi all,

I followed the instruction of here:
http://www.kernel.org/pub/software/scm/git/docs/core-tutorial.html
to publish my work.
But I run into a problem when I run the command "git push", see below:
======================================================
aubrey@linux:~/public_html/u-boot.git> git push
10.99.22.20:/home/aubrey/public_html/my-git.git master
Password:
error: src refspec master does not match any.
error: dst refspec master does not match any existing ref on the
remote and does not start with refs/.
fatal: unexpected EOF
======================================================
The remote machine is in the same subnet as mine.
Many thanks to your help.

Regards,
-Aubrey
