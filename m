From: Bo Yang <techrazy.yang@gmail.com>
Subject: Can git for MinGW clone from http
Date: Wed, 21 Nov 2007 21:22:01 +0800
Message-ID: <474430F9.4080902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 14:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IupXL-0002Nb-GP
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 14:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbXKUNWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 08:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbXKUNWV
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 08:22:21 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:48085 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbXKUNWU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 08:22:20 -0500
Received: by py-out-1112.google.com with SMTP id u77so7180741pyb
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 05:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=HTTc/uRznwZ/0aEX0AIssUsx/IlygS0SIM0nIPU3ocQ=;
        b=M+gTwF54Qr7jq1mrjAMiN4dZk+WfPLHsYIjhN4c8jqYKmMSLqm7TJ7tGlpTyFvr+5+pjJxnaxWnF98s87HwgnOb9UPQjjsPDdfujnAt7aH3mhfWSbPToKxVTh8ikPPuTxJb0kk5TBwL+xilSgKDS9PKDELsGdUHefsCD2QkYTfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Ik7atYBa0psRlcRhcX1BQq6niaolTuFN39Y1QXsmtHVy2MzDYr5dWU5pgb6nqw+P3C1JQvsqYneBtINsjCJL7xcf3H5IYkho/U4xqfdwcizXFqKz22MfsvFsP6sgy21riGCFsp/cg1Djc2IZ0SNtE21YEjJIJvX3xZmyai2mHNQ=
Received: by 10.35.26.14 with SMTP id d14mr9009566pyj.1195651333106;
        Wed, 21 Nov 2007 05:22:13 -0800 (PST)
Received: from ?192.168.1.123? ( [123.57.144.47])
        by mx.google.com with ESMTPS id f51sm691398pyh.2007.11.21.05.22.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Nov 2007 05:22:12 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65647>

Hi
   I just installed the Git for MinGW in windows platform and I try to
git clone http://......
But it give a error message saying that there is no curl available. 
Could you please tell me that does this version support clone through 
http protocol? Thanks in advance!

Regards!
Bo
