From: Franck <vagabon.xyz@gmail.com>
Subject: Question on GIT tutorial.
Date: Mon, 14 Nov 2005 11:20:23 +0100
Message-ID: <cda58cb80511140220n26da3edm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Nov 14 11:23:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbbS1-0001B4-Tm
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 11:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVKNKUZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 05:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVKNKUZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 05:20:25 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:2202 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751067AbVKNKUY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 05:20:24 -0500
Received: by zproxy.gmail.com with SMTP id 14so1227642nzn
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 02:20:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FWfoLUVWN+8GrwdtepE+zT+0RmJl2YJOyinrxj5z4BP8C0vm5G8keg6B9lUEhxl4coCWQ1hRAWOKD3mXMYoBThSCEXrGtqHQJ5fLDRdD3tFUIZ3dJajjVQk7fumkEZA7/eEmiy0PA+OxGvF+K+1XVKacHjtDygu+LcHqLy5QgqQ=
Received: by 10.36.39.14 with SMTP id m14mr3952995nzm;
        Mon, 14 Nov 2005 02:20:23 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Mon, 14 Nov 2005 02:20:23 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11783>

Hi,

I have a question about the GIT tutorial. At page 21, there is a
description of "subsystem maintainer" work cycle, I don't understand
why point 3 is needed. This point tells:

"""
Copy over the packed files from "project lead" public repository to
your public repository.
"""

Why is it needed ?

Thanks
--
               Franck
