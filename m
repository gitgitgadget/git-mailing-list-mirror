From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Specifying multiple refspecs in remote.{remote}.fetch
Date: Sat, 20 Jun 2009 23:00:37 +1000
Message-ID: <37955246-7ECC-4A98-82C7-33DA894C864A@gmail.com>
References: <2cfc40320906192337g66db81f0w92e06adfc6a189c9@mail.gmail.com> <m3eitfgxln.fsf@localhost.localdomain>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 15:07:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI0Hs-0006TW-Tb
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 15:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbZFTNHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 09:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbZFTNHE
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 09:07:04 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:24566 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbZFTNHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 09:07:02 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1093202wfd.4
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=dhWmQJiFkSU7CrVyQK8g/Ha5QFDZKZOoLiH6fUVbAzg=;
        b=jRK71W5coDozqTUcZyhycU+onqynXUpPngIcfqkWUfLJhM6C2NrvleTLvD9BvcFxfF
         XvFIMrtOWVqtqFUvpXhmawulF0f/51cS3r1B5/Q20NWB1s+uBmwufM6Aaag5mfvXbCAx
         bEhFxgUaYw1kAqmnj6oh2r+2szJSHRtfHz+40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=N8d2CEY09eSkVblwKbtUXeTyLXVsGRba135hhlZQXKt94WEDqEyoV8ZfUs9eAGffKv
         eBbTPkTSyhfOtwuoCAz8jLZbSeOkMQDivUvzOz/FDP44uLvVcQhJ80Ml2RomsJcILwQf
         DhBhySSmwYbEL2DTPSpyEL8dZeKHfuHakWL00=
Received: by 10.142.200.3 with SMTP id x3mr350737wff.122.1245502850627;
        Sat, 20 Jun 2009 06:00:50 -0700 (PDT)
Received: from ?10.213.19.15? ([123.208.165.25])
        by mx.google.com with ESMTPS id 9sm562844wfc.36.2009.06.20.06.00.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Jun 2009 06:00:49 -0700 (PDT)
In-Reply-To: <m3eitfgxln.fsf@localhost.localdomain>
X-Mailer: iPhone Mail (7A341)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121943>

Jakub,

Ah, thanks for that.

I don't know why my attempt to use subdirs of remotes failed but if  
you say it works I'll try it again.

Anyway, thank you!

jon.
