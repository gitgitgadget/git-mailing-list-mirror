From: Saurabh Gupta <saurabhgupta1403@gmail.com>
Subject: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 10:22:03 +0530
Message-ID: <49B74373.3090609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 05:54:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhGSK-0003Uw-MY
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 05:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbZCKEwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 00:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbZCKEwN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 00:52:13 -0400
Received: from ti-out-0910.google.com ([209.85.142.185]:40120 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbZCKEwL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 00:52:11 -0400
Received: by ti-out-0910.google.com with SMTP id d10so1694998tib.23
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 21:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=ZGBoOXv1KsbOBJ954VA5g9WAOyhsI4C+9DFgPciahdk=;
        b=mgOM1q6y3PZ7dbLQKMud3U0r+eHMl3X7q30kTwYKHeyM1UfeJfq6y+sUZBFkUYoKtv
         5g2XoB1VNJeGHTpkJiKkJiSEtXvl/y1ZvOPKneFmaB26BjdpKMWv8FlfQRodLZ9OrLuL
         QYF8Ba3s16/Tf+b6Ir9/R7TFc5o0GlXDZ/X8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=pU83P72d8LuTp3cf3hRLqW79B5nneGcDsqm3tOicoqVRaqr/VX3bxjncqjsuyEsqTV
         dc+3HmnalnxMw5EBjFLsAIwxnJ/stmfVJwu/3DSPAmByvxrz4zA+LsE7o32HNm8xxI9x
         SJIpNhfTzTS63ZNV0RwrOalvbO2jZYobfJ4BQ=
Received: by 10.110.62.4 with SMTP id k4mr12128315tia.58.1236747128470;
        Tue, 10 Mar 2009 21:52:08 -0700 (PDT)
Received: from ?192.168.1.2? ([59.178.145.225])
        by mx.google.com with ESMTPS id b7sm3332605tic.35.2009.03.10.21.52.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Mar 2009 21:52:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112881>

hello everyone,

/*First, a brief introduction about me: */
I am Saurabh Gupta from India. I am a senior engineering student. I
have been working for open source projects for a long time and I was a
*GSoC student in 2008* where I successfully completed my project under
the organization Openmoko (www.openmoko.org
<http://www.openmoko.org/>). In 2008 winters, I had my internship at
*Adobe Inc.* where I worked on the package  management system using
C++ and sqlite library. I have a long experience in programming in C,
C++,  Python and other languages. Currently, my final year project at
university is about the automatic data logging system in which I am
working upon socket programming in C, C++,   MYSQL and setting up an
intra-college website using LAMP. I am a user of svn extensively and
use git sometimes.


/*About GSoC GIT ideas;
*/Here are the ideas which I found to be interested in. Although, I
would like to discuss any other idea than these in GIT organization.

*1) Domain specific merge helpers*
Intelligence in the merger can be put which modifies the source file
according the format. Different file formats can be put in the merger
to support.


I am looking forward to get feedback and suggestions for this and to
discuss the ideas. I would like to contribute GIT this summer if I get
a chance through GSoC. If not, then still, I would remain in contact
with the community to contribute in the best possible manner I can.
