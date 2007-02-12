From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: git-gui blametool
Date: Mon, 12 Feb 2007 20:02:22 +0530
Message-ID: <45D07A76.1070009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 15:32:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGcES-0007Fh-3C
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 15:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbXBLOca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 09:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbXBLOca
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 09:32:30 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:8816 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964946AbXBLOc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 09:32:29 -0500
Received: by py-out-1112.google.com with SMTP id a29so846090pyi
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 06:32:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=rIIS63NK+E15m3LDVZHM7cqpVceZ7E0Gexuh3s0Q6mEglQABP5FrgI+hAb/e5UFYKb71rYip1TzTI0f7kQZGH8vg+Nad50bUQHtTOE1SUIc8IJQ0plZdBZ62yMOPmn1c0mjLmjutHzuAdCgxaZqtAIc4LVSR/e/m2Jkr5Fkvrxk=
Received: by 10.35.102.1 with SMTP id e1mr9570224pym.1171290748362;
        Mon, 12 Feb 2007 06:32:28 -0800 (PST)
Received: from ?192.168.2.69? ( [59.92.185.27])
        by mx.google.com with ESMTP id u6sm10317410pyb.2007.02.12.06.32.26;
        Mon, 12 Feb 2007 06:32:27 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39407>

Hi All,

I found the git-gui blame tool interface quiet confusing with the all 
those color code. What does the color code actually mean ? A simple 
interface would be

[ commit ] [ line number ] [ code ]

....
...
--------------------------------------
commit details of the selected commit


-aneesh
