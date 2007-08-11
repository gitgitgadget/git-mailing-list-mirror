From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Git on Windows (MinGW port)
Date: Sat, 11 Aug 2007 16:39:18 -0700
Message-ID: <a1bbc6950708111639o6faa898cqec5ec109587abfe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 12 01:39:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK0YE-000735-KG
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 01:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbXHKXjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 19:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbXHKXjU
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 19:39:20 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:34866 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbXHKXjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 19:39:19 -0400
Received: by rv-out-0910.google.com with SMTP id k20so936174rvb
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 16:39:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dS4W1+ZjFOKFNolj+6JfjwjeSqej6uM4DX+MNd+Y3Mk/JfIErkxek0fE+c4PEttKH2+LhtF1yCkGFIS4jQ/eR/TgWrFGk1LZNR0t5nJOcuAFThJOhwpXsRzQlde1lNwJJrxGXvkGoYAPP38NlMNOnlIw1EGeKEsijDAN4h50XNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Jl68YfEcc3OjHNdbRgF8CqNC2KLU4uvC5E6cRkHsSvI1y3wCpdJYFSqx0USWBYoiMhX4XY0+uwMlGe27WifkEIdB/4fXfboQrM+y0z7HKiKSyGSEKq4EorhwJgC3a67aIwAKMqANzHiI2+5XXzTfmxiUkVs/4AbqTojEyMtQROM=
Received: by 10.140.251.1 with SMTP id y1mr1959219rvh.1186875558561;
        Sat, 11 Aug 2007 16:39:18 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Sat, 11 Aug 2007 16:39:18 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55650>

A lot has happened since I first requested to send me MinGW build
environment for building Git on this mailing list.
Long story short, we now have a Git repo with MinGW build environment
(msysgit) and automatic installer called GitMe that sets up build
environment and source code ready for hacking.

Please consider joining our small team working on MinGW port of Git.
To join go here: http://code.google.com/p/msysgit/, look around and
then join Google Group http://groups.google.com/group/msysgit.
There is plenty of work: http://code.google.com/p/msysgit/issues/list

-- 
- WinGit Team
