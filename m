From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Correcting forgetting to make a new branch
Date: Fri, 11 Mar 2011 15:31:18 +0000
Message-ID: <AANLkTi=fp=-pwi7Mj9TptP22mtP51bzq5UwTLRx9LnNB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 16:31:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py4JJ-0005JL-RK
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 16:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab1CKPbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 10:31:21 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54961 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755597Ab1CKPbT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 10:31:19 -0500
Received: by gyf1 with SMTP id 1so44655gyf.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 07:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=iQ95qPVsXtPdFOrhPyTyVLbnRjExlF4tZVN8FHsDMkY=;
        b=xC7eImqACW9j0AutTycF3b5N8JsItohLC3Dhf1ZparPVNbOxw5ccX+i2d5AvkMFVWH
         l3YM7xebpN6n//7K+U1eAZoeINHUR1m+qUeRsWu5RW/fV9SQFbx3ssKlV/6+/ZRuM7mP
         4bDohhoBd6mjjgN0ey8JZVH05LKSjFeeskML8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=atkqhM9Z7yGHucPq11MaraDeQQXxO9dqUoc9divstsYGS6qeZmve5sTMtiE3Oq8BJc
         dc3j5LX/u9EWC8YqV+LhnU3IV14mf6Fbjfi/zLGT8ub7+cCkwG9+GHkkxO8z+r6B7k9a
         aykhb4dkUudpfG5p4hq0ZBoGXa6mMsWqtVoHM=
Received: by 10.91.69.20 with SMTP id w20mr11190agk.0.1299857479016; Fri, 11
 Mar 2011 07:31:19 -0800 (PST)
Received: by 10.90.94.9 with HTTP; Fri, 11 Mar 2011 07:31:18 -0800 (PST)
X-Google-Sender-Auth: HrAVYTtN__UPbcmckAHm1BScwHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168907>

The scenario is that I have done work on a branch and made a number of
commits. What I wanted to do was to start a new branch before I made
these commits. Unfortunatel, I got distracted and forgot that I hadn't
done it.

Is there are neat way to create the branch and 'move' the commits over?

TYIA
