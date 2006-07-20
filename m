From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: remote diff
Date: Thu, 20 Jul 2006 11:54:58 +0000
Message-ID: <f36b08ee0607200454k7aa98454rd2a8a566b0ea4582@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 20 13:55:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3X7o-000749-C6
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 13:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWGTLy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 07:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWGTLy7
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 07:54:59 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:7802 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030293AbWGTLy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jul 2006 07:54:59 -0400
Received: by py-out-1112.google.com with SMTP id c39so687880pyd
        for <git@vger.kernel.org>; Thu, 20 Jul 2006 04:54:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gEBqaxv761gteRcl7cPIRdfjFtQ4Thui/0IZ2DQdouRxFpBNakeoi0g7Ql76ZI1r/3fFI61otua2eL2s4NfBScGz58GtWyqhpqdUTDln/Z7RbHhdBoEvaL6du3e29N7psYZj9PfMbMmtUEss1MI47/WCv+ii+faOg5YniWs6y98=
Received: by 10.35.89.10 with SMTP id r10mr927800pyl;
        Thu, 20 Jul 2006 04:54:58 -0700 (PDT)
Received: by 10.35.14.14 with HTTP; Thu, 20 Jul 2006 04:54:58 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24028>

I have local repo, and remote repo ssh://x/y/.git.

I tried to diff local repo against remote, with naive
'git-diff ssh://x/y/.git.' But this did not work. How do I
diff with remote repo ?

Yakov
