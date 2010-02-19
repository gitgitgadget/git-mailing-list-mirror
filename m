From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Gittor: Project initiated
Date: Fri, 19 Feb 2010 22:06:08 +0530
Message-ID: <e72faaa81002190836i5e9610dfx1728b50646d8c2cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 19 17:36:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiVpy-0006cY-4l
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 17:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab0BSQgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 11:36:12 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:33462 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab0BSQgK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 11:36:10 -0500
Received: by yxe38 with SMTP id 38so215674yxe.4
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 08:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=/QC6Eqk0LF1mnnydc2F+lAm2NGg7nV/juiIjr9ZY87g=;
        b=Y5NpYVm+cJtdyXSpZnA8fWDpDmAwAMqWKSYkKO0IICul9VSEVvlutnSaEHHcP9fVvU
         0KCxHxlJaor26ToBbzPjPXYrHRiwyAMacCOAlOZs/wcqnmtUk5ncB7SDVugtEiYG4plM
         xSgBpJ66uClALDH9nkakdA9RDf0fnNEkooekU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=cK1xs20fo3C5xXWKiFUi4VfZiXIerdFFsMLtuHr5iK3NrgmbCzM/KBOfp4uqhSXLa4
         4dRzQvhT1RDjGMSIaIAmoOxHr5M0Z9txDOAPPF4Il3d1Hreno6Jp7qT0DVaGqDH4JkNp
         CBgBXEajLAhH4oWG8HG8FAOHuNxXFNotorpsA=
Received: by 10.90.7.29 with SMTP id 29mr7227485agg.16.1266597368450; Fri, 19 
	Feb 2010 08:36:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140460>

Hi,

  I am Pavan Kumar Sunkara who proposed a project for writing a web
based GUI client for git. Mailing list archive is here:
http://article.gmane.org/gmane.comp.version-control.git/139690 .

 By the suggestion from Petr Baudis. I have started this project this
week and wrote the basic code to get it started.
 I hosted it in http://github.com/pkumar/Gittor.

The functionalities possible for now:
* Clone/Create repository
* Add existing repository to the client
* View Status
* Commit with -a flag (-s is optional)

In order to give you an immediate view of this, I created a wiki in
github with screenshots, so that you can see for youself how this
works, even before you try this.
http://wiki.github.com/pkumar/Gittor/

The current code is just 1% of what I am planning. Read the README to
learn how to install, start and uninstall this.
Feedback is appreciated.

-pavan
