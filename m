From: Lars Jarnbo Pedersen <lars.jarnbo.pedersen@gmail.com>
Subject: No common commits question
Date: Sat, 14 Jun 2008 11:17:45 +0200
Organization: Home
Message-ID: <1213435065.9800.13.camel@neo>
Reply-To: Lars.Jarnbo.Pedersen@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 11:18:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7RuQ-0006az-IU
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 11:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758600AbYFNJR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 05:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758506AbYFNJR7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 05:17:59 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:41343 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757786AbYFNJR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 05:17:58 -0400
Received: by ik-out-1112.google.com with SMTP id c28so3339394ika.5
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:reply-to:to
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding:from;
        bh=64U5RCKliwZ5F5+U+hvGIpfhBigtCWTWbS3uINblUqY=;
        b=cpGG96RqFmvCy2KpHw0RnMYX68iNQUmPe50OpkiNGeXDX16cSuH1TpeDhco2qqiqhG
         q85jqv2JHCPGUeXbysRR8NBAMoSz3XcGaVtJwakpdw67ic8k2ur/wxicuFNJngzh2uK+
         iszwTKTo4g11zYO3gt+tosyMPuwIrFJZ/jSsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:reply-to:to:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding:from;
        b=nm8hb+HBPjhI1ehkcR0bFDTkhQDvymR98Cf167IQgDwDM78Ui8g0e4rHWkOhJgMpIG
         tYJaaoJw3W9JENKHhMw13BAvkPpzH/XY18uBWX/of+pLQaH9PwlAXq07b4lfq9DEGyFo
         kGtJLRSgxM8nwvrAEngugxUY4HbxZuIUT+jPk=
Received: by 10.210.129.10 with SMTP id b10mr3649274ebd.25.1213435076463;
        Sat, 14 Jun 2008 02:17:56 -0700 (PDT)
Received: from ?192.168.1.137? ( [217.157.186.14])
        by mx.google.com with ESMTPS id 31sm3433669ugg.25.2008.06.14.02.17.54
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 02:17:54 -0700 (PDT)
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84995>

Hi,

I have been tracking the Linux kernel with for at least a year now doing
frequent pulls (once every other day or so). I'm not doing any
development so it should be a clean update everytime. However once in a
while I get a "no common commit" warning and git starts to download the
entire repo again. (It happened again today - therefore this mail)

As Im not changing anything I would not expect this to happen, but I may
be wrong. Can anyone explain?

Im using Ubuntu 8.04 using the following version of git and Linux:
- git version 1.5.4.3
- Linux neo 2.6.24-19-generic #1 SMP Wed Jun 4 16:35:01 UTC 2008 i686
GNU/Linux

Finally I would like to take the opportunity to thank all of you
developers for a GREAT tool. Im currently working as a Software Release
manager and have been working with many of the commercial competitors
and what surprises me about git is that it seems to solve all of the
*BIG* problems you have with SCM in a big corporate environment.
Unfortunately we are NOT using git for the major part of my work, so Im
currently only really enjoing git in my spare time :-)

Regards

Lars Jarnbo Pedersen
