From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: basic question
Date: Wed, 25 Apr 2007 05:34:00 -0400
Message-ID: <f36b08ee0704250234u5ee4557au22fefa637d25aef0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 11:34:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgdt1-000106-VY
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 11:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992481AbXDYJeE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 05:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992483AbXDYJeE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 05:34:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:5191 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992481AbXDYJeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 05:34:01 -0400
Received: by wr-out-0506.google.com with SMTP id 76so166870wra
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 02:34:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=miF4PEhoy/v+QW9pmM8w/aLquu2z8ANkO8LjxnPxZcB5CYKLZezxwueinRFelX6NAFw5NxV0giyVheY1cXhazSr4vjIoz6d7ScP1BQ2ppdp0FS98EKAaQJgSgPW+AlmmkJEm4nzMvSFxzwkg6C4AwDXliopZypcXYdiYGQBk4tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Kt0ijTF/fKYRLPRalwYGaAXQ0cXgM/tAjXQtpZIdxBK82CML2O47pfQgLufzPYq9H+OnmJPf9FnagMNF8/4APdQz7YgjpN7pCHB9vfbOauxK3mXx9238ZQkd+MKoGd+MrdA1sCAGgafMGoQ1w61hVaAxonIaiLD8RpA/Q1/Icw4=
Received: by 10.90.73.7 with SMTP id v7mr293665aga.1177493640329;
        Wed, 25 Apr 2007 02:34:00 -0700 (PDT)
Received: by 10.90.73.8 with HTTP; Wed, 25 Apr 2007 02:34:00 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45515>

I have bare repo X, and two clones A and B (basically my work copy and
home copy of same personal files. I use 'git-pull origin' and 'git
push origin master' to sync files).

The same file 'xxx' was modified on A and on B, and committed on both.
In A, trying now 'git-pull origin', I get 'xxx: needs update'.
Which commands do I use now to merge xxx on A ?

Thanks
Yakov
