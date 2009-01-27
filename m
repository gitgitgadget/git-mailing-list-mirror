From: Ittay Dror <ittay.dror@gmail.com>
Subject: how to see full file with diff marks
Date: Tue, 27 Jan 2009 06:51:13 +0200
Message-ID: <497E92C1.80102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 05:52:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRfwK-0001gW-Jn
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 05:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbZA0EvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 23:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbZA0EvU
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 23:51:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:39427 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbZA0EvT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 23:51:19 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1120042nfc.21
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 20:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=IM1UAppfkiIeKUn72boBoY25xHcylEvhPDJ/xsmzcWo=;
        b=VxFnI6HMITDoBHL177DO4EoCttPp8PyZEDTfFOMob4WBkjUysTpFa+eARifmiFUoqF
         q94hbAhMcPv+tyHbFv11RRG/Ii4gBvkvDuk9sCw6swqxVdjMv95A7on90GDCfZi4zmr3
         QJqHFcWqJ0wPUP57NxcFe9Odmm4VTN3bE8SuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=BBblhUbPyJ80/zKllORJOpMXVpHJc6E8bSwnGgshHwGpW2jLw7HAv+D8raYRzfD5sW
         jwF37rw4uMOkucKRzT6qp/7hi7ICknztgIBllpUOhp4IODL8+0CpoqHuI4po10GlFtJA
         KzTiM90jYiijzI8w8syuKL8bzBQsBMAw/HoqQ=
Received: by 10.66.220.17 with SMTP id s17mr1606827ugg.69.1233031878332;
        Mon, 26 Jan 2009 20:51:18 -0800 (PST)
Received: from ?10.10.2.8? ([212.143.191.180])
        by mx.google.com with ESMTPS id u7sm5482554uge.11.2009.01.26.20.51.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 20:51:17 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107308>

Hi,

I have a large file and I want to view the changes between two commits, 
but in the context of the whole file, not just hunks. How can I do that?

Thanks
Ittay
