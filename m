From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Git User's Survey 2009 - trial run
Date: Thu, 25 Jun 2009 21:22:50 +0200
Message-ID: <200906252122.51737.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>,
	David Aguilar <davvid@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 21:23:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJuXK-0001XE-Ce
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 21:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbZFYTWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 15:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbZFYTWu
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 15:22:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:14926 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZFYTWu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 15:22:50 -0400
Received: by fg-out-1718.google.com with SMTP id e21so348775fga.17
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 12:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=xlzZ1V3+EMUDPSMRDGTHU7s7FB438ulGhzXO5KnI4eg=;
        b=Vx1YOnWdtUySCLTFXeq/UF5rQe+WJE0mjVCDfkU2dbyI1Oqhl5lM0b1KpM7RH0NbT/
         Z1udBlwfJ+o4LiL4+BMmyckwRqeHdSE7yF7vSaqNR41W7RqeZQ9T7nx7XNyEjbfh1iTb
         8sFPBHnrD2CRd5aHEslAtxsN6XoDkm8/BHAzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=IBPhwW7wIdnLxmez6HRzdljrUhngwkRyQb7kA4HJhxZgWsCvWeYou0e4ABYa/mgP8B
         JPj0vIioy+C63wqfc8RxdoI3n8HraDraB3/v1daoXGmpKuL1h0JVdpUX14v8qOwW8zq+
         ik5A/VYF+5XhQys3DUeg04v5JpBkqet8++Ag0=
Received: by 10.86.25.10 with SMTP id 10mr2912074fgy.79.1245957771932;
        Thu, 25 Jun 2009 12:22:51 -0700 (PDT)
Received: from ?192.168.1.13? (abwu167.neoplus.adsl.tpnet.pl [83.8.244.167])
        by mx.google.com with ESMTPS id l12sm3600374fgb.4.2009.06.25.12.22.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 12:22:51 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122240>

I have created _proposed_ version of questions for upcoming 
"Git User's Survey 2009", based on (a bit of) feedback on git
mailing list:
  "[RFH] Questions for Git User's Survey 2009"
  Msg-Id: <200905291855.03328.jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/120287
and comments on #git IRC channel on FreeNode.  

Current version of survey has 30 questions, as compared to 
60 questions last year; the number of free-form essay questions
were also greatly reduced.


The *test* version of this year survey can be now found at
the following URL (as in previous year, we use Survs.com)

  http://www.survs.com/survey?id=2PIMZGU0&channel=TFN2Y52K7Y

Please tell me what you think about questions and about selection
of possible answers in single choice/multiple choice questions.
If you have better idea for theme (mainly background and font 
colors, and perhaps font size), help would be appreciated.  Is it
better to use vertical form everywhere, or should we use horizontal
layout of answers for questions with short number of possible
answers?  How long does it take to fill survey?

ATTENTION: All data in test survey would be deleted when survey
would start for real!
-- 
Jakub Narebski
Poland
