From: "Francis Moreau" <francis.moro@gmail.com>
Subject: What about git cp ?
Date: Sun, 3 Feb 2008 19:23:12 +0100
Message-ID: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 19:23:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLjVN-0007ts-Uk
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 19:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbYBCSXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 13:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbYBCSXR
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 13:23:17 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:28367 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbYBCSXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 13:23:16 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1271560rvb.1
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=VHG23VodYbPCuCUqiJF129OrSlyDw4ifJxIWLa8l1+I=;
        b=GAOf581HZj8wdDyGCoPJeCO5XykmzLvbfesBwg6we+uQDQ/rqCj8qdv4boY0vB38Nrnf2LQENZHEbwSRr5rnAUFSgpd8E5ZFMID6jtMiGNb8/u3mGu90qGw2rqYJG1T9EVLtHihl4GGQUkZqfB+z2S9NUPrESe3YRcdplfsa3gE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sEqOADXnIDp0qOx920emLr2T8aq4K48PNf8OWnRUHuvb8FKJep0frmMIXYcgKDfaJyaNjyGpOGFn0RPrv+uzrTXsZD3Gk87Vz7w004tOCWvclYq/ZI+6lbZ8X9Gy4vTPrncxpULQ4tIP08wBUDaSu+cWTqDmFJO04DMaC4NWP5E=
Received: by 10.140.199.19 with SMTP id w19mr4084220rvf.90.1202062992549;
        Sun, 03 Feb 2008 10:23:12 -0800 (PST)
Received: by 10.141.171.17 with HTTP; Sun, 3 Feb 2008 10:23:12 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72388>

Hello,

I'm looking for a something which could be done by a git-cp command.

I'd like to copy a file with its history to a new  file but want to keep the old
one,

Thanks
-- 
Francis
