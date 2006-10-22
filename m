From: "Lars Hjemli" <hjemli@gmail.com>
Subject: The bad patches to git-branch
Date: Sun, 22 Oct 2006 11:08:29 +0200
Message-ID: <8c5c35580610220208x4c601e8cl4a1c48e387c2e820@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 11:08:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbZJq-0002S2-Q4
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 11:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWJVJIc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 05:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWJVJIc
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 05:08:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:27012 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932304AbWJVJIb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 05:08:31 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1983361nfe
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 02:08:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Btkyu50dVStU7sGIvyBrHflOnBl+oJhZ+AE9o3zRH5VWGRQlMWS9n/jb/iRN4w3FSYMM8xrrzXvICbOKgxhCge5Ev/r8uAYrt4PvIInY4RjIdJ1p3b4H3pnP3mDIMdmkhS8KCA7JTURimU00spEX7mRunNt2m9yK0xey7BIE6uk=
Received: by 10.82.105.13 with SMTP id d13mr1012567buc;
        Sun, 22 Oct 2006 02:08:29 -0700 (PDT)
Received: by 10.82.171.10 with HTTP; Sun, 22 Oct 2006 02:08:29 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29713>

Hello

Just in case you considered applying my patches to git-branch,  please
don't, as they're too much of a wip.

I'l redo the patches (unless the whole idea of git-branch -v opposes you :-)

-- 
larsh
