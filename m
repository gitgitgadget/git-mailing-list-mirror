From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Status of kha/experimental
Date: Sun, 7 Oct 2007 22:18:44 +0100
Message-ID: <b0943d9e0710071418o6a664981i9d31db980c04bc50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Yann Dirson" <ydirson@altern.org>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:18:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IedWb-0003Mw-7D
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 23:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbXJGVSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 17:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbXJGVSp
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 17:18:45 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:5887 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbXJGVSo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 17:18:44 -0400
Received: by rv-out-0910.google.com with SMTP id k20so584420rvb
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=eCAuGPhpFeVM5hMlbCzEry2MQYr+O18TluTIgsLF4H0=;
        b=F2q2p0OAYOcTP1HEjUIf4+bV1cuEdIuPNlbkcm1s94I69iBpe4H908eRpx/PV+fcFApGnuQRr67enYNbXjitJbFw/wOfW8MuaADWeBcIj4QFqto7RKKfZgSuKT/zjAPOmncNfcgwo3VVU6buW5ZhW5ye3Vx1I9ZFI2yzm2g+fRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jeAscAFLuqqVE5l0A8+SKyMXHSEcaMTbM1QDvjjDqCiASBRGWeof6i3nmINlmfz+811OLbjLHDpPFLtVdCveT24iiJzjYCBxLszk8iQ6IIiSG/C/yAv4hYjdWM4wADnJyFF8A+UKk5DOiN/b5gwVKv5IrhgOOThBSKpyNMTfrYo=
Received: by 10.141.202.12 with SMTP id e12mr1243066rvq.1191791924349;
        Sun, 07 Oct 2007 14:18:44 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Sun, 7 Oct 2007 14:18:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60218>

Hi Karl,

How stable is the kha/experimental branch? Since there are more and
more bugs added to the tracking system, I'll have to start looking at
them before a 0.14 release. Is it worth merging the kha/experimental
now or we better wait for after 0.14?

Thanks.

-- 
Catalin
