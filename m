From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: git ftp push ?
Date: Fri, 4 Jan 2008 10:54:16 -0500
Message-ID: <31e679430801040754m552b7650g50405b6e2e607da9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 16:54:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAosf-0005MD-4k
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 16:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbYADPyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 10:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbYADPyT
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 10:54:19 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:19470 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbYADPyS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 10:54:18 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2077413wxd.4
        for <git@vger.kernel.org>; Fri, 04 Jan 2008 07:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=ceJmxXWqf9c7NBrddS7tHAoIg2TFIuR1zrAqZ0Dmhsc=;
        b=jeoHHaDZ6eKMOI+VmxEKqrzconfQBHGXbGy2AigBvCUHyw4EcR2Z29/w/TuDAoOoyCRpCPZFFbelDpooH2SxqBZNcOoHFhGfxPMdpB8OF6+S8PKxgGSSmOKHr4U//1n4lk3MxgZ0gc2xBP/J7U2WIZ6IJjUKikFf8EfjeFdq7hE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=lrpvPN7MOY0zvwV17pkUJqx5+chBDgrqgQWpQ09a4KyV1vUbwpcQ3O19CZOh+aiImbJZahikS917SYKtC2JZL4Wq/W47GGGFkmhhd2xUGYG5LHBSNTDIcpJtTcj+egY7xpxUfP114R9buljNn7sndqDmCfB5VGfGmPlsQvjJ2B4=
Received: by 10.143.37.20 with SMTP id p20mr3825872wfj.236.1199462056415;
        Fri, 04 Jan 2008 07:54:16 -0800 (PST)
Received: by 10.143.158.13 with HTTP; Fri, 4 Jan 2008 07:54:16 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 8f6e5e8ba03194f0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69579>

Hello all,

how could I issue a git push via ftp ??
Is that possible ?

Thanks in advance

-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
