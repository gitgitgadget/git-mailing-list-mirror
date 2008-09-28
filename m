From: "Rustom Mody" <rustompmody@gmail.com>
Subject: git and perforce
Date: Sun, 28 Sep 2008 14:49:28 +0530
Message-ID: <f46c52560809280219y20bd6305v83c81cb8c0b186a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 11:20:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjsSF-0004vf-1W
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 11:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbYI1JTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 05:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbYI1JTa
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 05:19:30 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:15724 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbYI1JT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 05:19:29 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1710398wfd.4
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 02:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=DZoQw2YKJ47lwwCawdV33xVszxqxogkGkjdnEQhQ6eU=;
        b=wneu402b76a5M5AislZulygD9kQcMG3W4hKROg71Vmj0VJaeEXZcTvzbedDkS6Qg1W
         KKQaVyyUyxtuCr9nayM3f3FCXCHxipxNky5aYjUFrwz+Duo+yIHoEG0z2tNN7cHQ5Qbu
         xqflEfcRwT16eMA7gjNI0b5F9EIkxSrWtEm/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=IfZjm0igk0n0WLwjRZ8xW/i6txf+6FFrD9oSJEMES+fmo4Q2tZ65lj/4pDD9J94omx
         8IRZKn9jQWLUf4h6yAROBer4F51SCh2q0cprBuritGSAkPmtr1ecFpc1GCB8IabjTSxI
         IiW4dmtg/jaGAcGch3/7kD0VFIv7q7bgmVHxo=
Received: by 10.142.156.2 with SMTP id d2mr1563243wfe.321.1222593568554;
        Sun, 28 Sep 2008 02:19:28 -0700 (PDT)
Received: by 10.142.154.9 with HTTP; Sun, 28 Sep 2008 02:19:28 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96947>

Our team does development under windows using perforce.
I am exploring having a 'private/personal' vcs on my machine behind perforce.

So...
Is the git-perforce integration under windows usable?

Thanks
