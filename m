From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Submitting patches from unsubscribed authors?
Date: Wed, 17 Sep 2008 00:24:48 +0100
Message-ID: <57518fd10809161624u3b2937dmd36e0fc962ea7a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 17 01:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfjvi-0007zL-NU
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbYIPXYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 19:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbYIPXYu
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:24:50 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:46615 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbYIPXYt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:24:49 -0400
Received: by py-out-1112.google.com with SMTP id p76so2172403pyb.10
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 16:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=N8AF2Jb0rJ2eDnGIiWPIJMoUtsjCXmcIKbeAMgNPNec=;
        b=JkK3F5Yv1ZpTaoq2ALQegr2D3ixQ6/+jATJHPbZ/7yNrZBu7Rq6M/AfiBpu3Tx7npE
         WAG3dtDSEAKe8va6ifoaWR+Aljm8OMTSRmkBBfugB75Lh0UqoKYQZf44+asmhXPPaztQ
         gXfRVlOmjwT2h0WCf/KI07odTcGFwHP8G3yHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=t7bd3xV/uexIyJ9bhOGcb5R5cqVPHMSCVUi4fcZ3bPGXfWVuZ273V+dJjiuaiqk9lN
         h3AMKoH+cljmcMBfgoskFZg1hCqiDXf5BoOzaH09GVI72K+iLBFg4D1+Nrr/QVD+fG21
         EZ8Y/FrP0BtTd7Mq1Q/7q0Vn8RPHNC/kEjRS0=
Received: by 10.142.148.10 with SMTP id v10mr580356wfd.303.1221607488107;
        Tue, 16 Sep 2008 16:24:48 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Tue, 16 Sep 2008 16:24:48 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 8c45430e4a4857e2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96044>

Is it possible to submit a patch to the mailing list, from an author
that isn't subscribed?  Last time I submitted a patch I went via my
throwaway email address, and so that was used as the commit author.
It looks like "git am" is always going to just use the email address
used to post to the mailing list as the email address, but I'm sure in
the past that my patches have appeared under my real email.  Was that
just manual intervention by the maintainer?
