From: bill lam <cbill.lam@gmail.com>
Subject: how to edit commit message in history
Date: Fri, 16 Jan 2009 11:57:14 +0800
Message-ID: <20090116035714.GA6984@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 04:58:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNfr5-0007vW-Q0
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 04:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbZAPD5Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 22:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753535AbZAPD5Y
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 22:57:24 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:23205 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbZAPD5X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 22:57:23 -0500
Received: by ti-out-0910.google.com with SMTP id b6so780827tic.23
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 19:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=teECEl/lq8dLcCD0+ouAADxDMeYAHvGUW0/5ILOvkic=;
        b=EiiMtSBDhbWer3fLiMK3U+LO8uST3/jVdxxKLJ/F7zBMWV8RzaRq2RxmYJs/d2hOXc
         7zZgmJiNIEOLIkBaEtAca3yxSkpmNa/02aay7oDwFIJagcQ9eOA9yVF3jlkIO070SW31
         zBq+1rfzSopIDDYayH6AZ5BAfVr2hm7KF3tt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=U+n1zcitGs9CbKOgrK+JmX0mtS75zI1xf8D+jQ4M9EGabdAr7tskQTp08piMm3fCRW
         JuZPxeHPrcVODebj9bTbQq3h7ASRtquGstOu/v2zqcxJ4rt+n0ztlfSLoc/QEo/+FAui
         8UU/WOu45688QuSuBjTyKSfIqUXzYz/DzUSnI=
Received: by 10.110.103.5 with SMTP id a5mr2591849tic.37.1232078240948;
        Thu, 15 Jan 2009 19:57:20 -0800 (PST)
Received: from localhost (pcd436074.netvigator.com [203.218.226.74])
        by mx.google.com with ESMTPS id 22sm1865797tim.35.2009.01.15.19.57.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jan 2009 19:57:19 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105918>

I made some typos in commit messages, how to edit them without
affecting everything else?

Thanks in advance.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9311 =E7=84=A1=E5=90=8D=E6=B0=8F  =E9=9B=9C=E8=A9=A9
    =E7=9B=A1=E5=AF=92=E9=A3=9F=E9=9B=A8=E8=8D=89=E8=90=8B=E8=90=8B  =E8=
=91=97=E9=BA=A5=E8=8B=97=E9=A2=A8=E6=9F=B3=E6=98=A0=E5=A0=A4  =E7=AD=89=
=E6=98=AF=E6=9C=89=E5=AE=B6=E6=AD=B8=E6=9C=AA=E5=BE=97  =E6=9D=9C=E9=B5=
=91=E4=BC=91=E5=90=91=E8=80=B3=E9=82=8A=E5=95=BC
