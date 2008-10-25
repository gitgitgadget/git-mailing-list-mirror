From: Warren Harris <warrensomebody@gmail.com>
Subject: git export to svn
Date: Sat, 25 Oct 2008 11:40:25 -0700
Message-ID: <FC51BBF1-B2CA-4A00-9312-2333FDA537C2@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 25 20:42:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kto5X-0000Zq-9l
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 20:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbYJYSlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 14:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbYJYSlA
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 14:41:00 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:59417 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbYJYSk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 14:40:59 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1370106wfd.4
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=CJXh1hz7GDgM5L7QUcrYgu3UJ0tDMcTDeBUB+oVRVNY=;
        b=oheRtIvBZior3gG0KgZzfjvODDHsIKG2fWDSKuVbtm4B6mPH2WmDIzdX74GOMvLGka
         SwDQRaXQlVR6oXTJK434tDxIB30/LBPQD+33+M5stxnNMoqYINgn0H3Jdfna34YRA0Gk
         T3y1f9eq6yHL/wJwfWGGbwAUAu1jrLxk9jYyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=F8NoaRMzEihy4BU/CgB6UoEMuxzTNI2FUmVR76PJho1WrZmt1u1zX5m/Bl0Ho+sXxS
         cKPU02ZcP/72Eg0oXP1nxa7iVUtoXM4on8AIuX7dQ53cI2SRd7cIFyBztV/I6nxpfPDs
         VGM5i+T2PkiTgACb0xGOYvCprzdT8g1g2ir+A=
Received: by 10.142.170.16 with SMTP id s16mr1672852wfe.215.1224960059132;
        Sat, 25 Oct 2008 11:40:59 -0700 (PDT)
Received: from ?192.168.0.31? (c-76-102-237-126.hsd1.ca.comcast.net [76.102.237.126])
        by mx.google.com with ESMTPS id 30sm3569490wff.18.2008.10.25.11.40.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Oct 2008 11:40:58 -0700 (PDT)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99118>

Is there a way to export a git repository along with its history to  
svn? (git svn init seems to want to go in the other direction.) I know  
this is in some sense "going backwards" but I need to commit my work  
to a client. Thanks,

Warren
