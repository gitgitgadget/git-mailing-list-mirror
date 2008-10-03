From: "Rob Sanheim" <rsanheim@gmail.com>
Subject: alias g to git in .gitconfig?
Date: Thu, 2 Oct 2008 22:51:31 -0400
Message-ID: <fc113d400810021951hf95ff35qb1ccb4af45a71abe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 04:52:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klamb-0000Wh-Lm
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 04:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbYJCCvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 22:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYJCCvd
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 22:51:33 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:50983 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbYJCCvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 22:51:32 -0400
Received: by wa-out-1112.google.com with SMTP id v27so697567wah.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 19:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=+rTTfeuHl3HIBviJe5Ksj3tQKyZlJ2/4WL+QzxIUC2I=;
        b=RP1Q1hyq+pMGbbjcyjoBeFWfuNwgJELjKh0+cOkXzG1WU0Nls7E8g1ZT/vokIM6viy
         7PPfpRBpzD1P+Hq7XHoduAabfxeceHBF3sswCr8dlpkwrCpBXUVsid4AkahdP6WyPgC2
         InwZCesdET/UNJZcdVXtg5s2cjRRtuY3LIpWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Ng3+9OBTcMQPCgYfV794+KBkcyTCuoiq4wqu4NDvz1GHjYAbReG1oek5ugRV+CptBS
         yjKZpj2qWwhBlKv5CYdhpBjgs6gvYmw27UjqOVNo4zowg0K44IMJmpObwFM7JFDsNjaP
         YMGMD8yn9TxlcyCbw39soxq1mGPLyni8kvqI0=
Received: by 10.115.58.1 with SMTP id l1mr544642wak.27.1223002291754;
        Thu, 02 Oct 2008 19:51:31 -0700 (PDT)
Received: by 10.115.79.2 with HTTP; Thu, 2 Oct 2008 19:51:31 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97391>

This is pretty trivial, but I'm a lazy typist.

Is it possible to alias 'g' to git via git config, instead of via
bash?  If I do a plain bash alias then none of the nice autocompletion
from git-contrib work with 'g'.

- Rob
