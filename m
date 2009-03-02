From: Emily Ren <lingyan.ren@gmail.com>
Subject: How can I merge some files rather than all files modified on one 
	branch to my branch?
Date: Mon, 2 Mar 2009 17:19:05 +0800
Message-ID: <856bfe0e0903020119y68188a39m90c683949220b2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 10:20:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le4KE-0005h1-37
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 10:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbZCBJTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 04:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbZCBJTI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 04:19:08 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:11518 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbZCBJTH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 04:19:07 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1451097ywh.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 01:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=sXrcEpLCpM7lZ4qOlGkvLvN1fnKbd361LvMgYZrDYmg=;
        b=LLm4F1hoNbZ5itJ+HQuC9FJolAYllqP0y2RHERS5umMbU8zWSQQ7mEzV7FI4Jf/QLX
         q/O2bLd6T6FNQxpQ4cvAl1ifxvkGzFigr8hqSF/NS0z4HotG2zw98/vme+WCLGZ9zwRv
         XtByZdm4+rxz7j9Lt6+VbQKLRC6MVlinQB6zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=tTdvLx8b1ca4HJXoKOoaxtslcYpWEKXTgPkVjRGVq6vInX8HD7Rw00pSJFap7ShT9g
         xMfDiP1o3Ricbr2BERSUb6yB+Jg5R22LSmM6zRYBouVqPpWOAA9kGnJIODvgbpmeBtCL
         dlOn4UyBKKDFNXgvlwAiqmEnCkchHUQ6HtW4E=
Received: by 10.150.201.2 with SMTP id y2mr9974153ybf.150.1235985545100; Mon, 
	02 Mar 2009 01:19:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111921>

Hi,

I want to merge some files rather than all files modified on one
branch to my branch, how can I do?

Thanks,
Emily
