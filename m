From: "=?UTF-8?Q?Fred_Maranh=C3=A3o?=" <fred.maranhao@gmail.com>
Subject: typo in tutorial
Date: Wed, 11 Jun 2008 18:34:15 -0300
Message-ID: <c647e93f0806111434q1cf99ff5pa99858c56951beeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 23:35:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XyJ-0006RT-DX
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 23:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbYFKVeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 17:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbYFKVeS
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 17:34:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:62740 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbYFKVeR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 17:34:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2252228fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=uRJA+yc/qAbdPEpJYgSdeAKIc/tUPfZ4sVYO9T26Gy8=;
        b=tTGXv7D6Ll01YUkFwCWlWKBOivPnkdWRNZTbF1hrA0EEG9WV/TH2NOuxRU4K3qoUBt
         iGoT/tHGh8meJ3pZjY5RSUYwmWOpraE3lCGJDlTVKQdj/SmAArrzUmz0qU5q/Ge6bH4n
         t6wmm27MbcjLhsRFw+SYFgsrBCCc7mD6p1y7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=QurvWDn9oOa8PCHCWH+SNtXtSfN2ewyhlFutUP3ENAWSbhWEl6hB1wdcVRS8fRbg8k
         TGA5uX8FNaHqlmq+JgzPeuZiR5wTW6qIpe9KwoojFIuFkNkFclt35FNCToNvbA1NKkU9
         1yHM4GhsvvHSyQgdBcjXgPtHO76KrjtkyfBuo=
Received: by 10.82.105.1 with SMTP id d1mr25598buc.26.1213220055651;
        Wed, 11 Jun 2008 14:34:15 -0700 (PDT)
Received: by 10.82.168.14 with HTTP; Wed, 11 Jun 2008 14:34:15 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84666>

Hi,

It seems that there is a little typo in git tutorial
(http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html).In
the following text:

"This will again prompt your for a message describing the change, and
then record a new version of the project."

"your" should be "you"

    Fred
