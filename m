From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Any puppet users? Drafting PPG
Date: Tue, 23 Apr 2013 20:10:54 -0400
Message-ID: <CACPiFC+t8L=_XMdg0HZTzRH74ELHr5Sd3Ah3We4i8JmYyWpDzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 24 02:11:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUnJ3-0004fQ-LG
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 02:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084Ab3DXALS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 20:11:18 -0400
Received: from mail-qe0-f49.google.com ([209.85.128.49]:42456 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756450Ab3DXALQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 20:11:16 -0400
Received: by mail-qe0-f49.google.com with SMTP id 6so850760qeb.22
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 17:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=3Hriig6D+tluaVcIGkmoB2BWZAmwqsNt94/6kCliv1o=;
        b=hePiVeQl65Xeh3HBSGMfdVxit3b0XalFrNsK0nKzSh4n/0OzDhLwsNUGDE1w17KHcE
         aSolimWoLgKTSFGr7vckgoKHRqUysZK2bG/YZFrSPj9B+8x1nKbpsi/gytjtnQRnibH7
         wmPILvmw9FsSisrCwUu3gDE2JiPkBBpbYZvftpgOUScR/q/tDzidv4BUUzZGgpf/OwZG
         Md7K2udwh2t8CYHA2awdoRNGXhiBz2fW1WTdB7RYdbVQuPyLfbLvE3Wehv964dEIzXxQ
         TjCOSpGq1902VWK5HFWTiRhz916m75q8CRHtQv1jlZcvDkJM3zsLj+fDCYPIwU1LPLuh
         BcUw==
X-Received: by 10.229.4.25 with SMTP id 25mr7023846qcp.91.1366762274282; Tue,
 23 Apr 2013 17:11:14 -0700 (PDT)
Received: by 10.49.86.164 with HTTP; Tue, 23 Apr 2013 17:10:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222220>

Puppet is often used with git as the mechanism to publish/distribute
the configuration. This sidesteps the not-very-scalable central Puppet
server.

But the use of git isn't sophisticated in the least. Git can help in a
few ways, IMO, and this is my initial approach at the topic:

https://groups.google.com/forum/?fromgroups#!topic/puppet-users/OilxMytnD_k

No fun in building this bike shed all alone :-)



m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
