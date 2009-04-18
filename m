From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: git & ssh on F10 server
Date: Sat, 18 Apr 2009 16:37:55 +0100
Message-ID: <2162B69D06894B1BA9D38496D5D9A9E2@HPLAPTOP>
References: <489CF11BD65F439998B6CF3FCC610576@HPLAPTOP> <alpine.LNX.2.00.0904171716150.8346@reaper.quantumfyre.co.uk> <FD77671D77E2465097BD60A1E144BB91@HPLAPTOP> <alpine.LNX.2.00.0904171812330.8773@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Julian Phillips" <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Apr 18 17:39:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvCdi-0004KM-MJ
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 17:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbZDRPiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 11:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755180AbZDRPh7
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 11:37:59 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:47250 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbZDRPh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 11:37:59 -0400
Received: by ewy24 with SMTP id 24so591419ewy.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc
         :references:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        bh=HVeHd9Qu3JdG1OUy5BpqwVLSCa90dWCvPgRSofqPRas=;
        b=XmiHjOwZvlRTOn13ZVVZUWLfwBYFKAstyBzqmFupuZ+lzwsh+6J8R4Zpv3wOalAPca
         Km8al6wxlOiOJoYwKFWGhtZbcWM+Ta2WmKQPuRwa3+VCtsrNVLBS7S6nD6LTTbWj4ngA
         HxnQuvCJ5AVNlKettJ6aL50ue998VV+7zlttE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:cc:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=ov6jNJgszk5Rb7CDyC2DLdfmiRXN+bT+TvIwwVxa9rOoB3F8XVaF49P7zq5nsJXyYx
         QOq8zD1HVvtwRBlzoBy7M9E9GoQoGgxhLha1dTsCkQdVRadB1ZAXD7ZNLugw1g1k0Csi
         EUksTCSwf1poGZi7TGA96QooxUPAYQOmqRK4Y=
Received: by 10.210.35.17 with SMTP id i17mr3947019ebi.32.1240069076962;
        Sat, 18 Apr 2009 08:37:56 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 23sm511066eya.55.2009.04.18.08.37.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 08:37:56 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116831>

F10 
        git is version 1.6.0.6
        git-daemon 1.6.0.6-3.fc10.i386

Cygwin git is version 1.6.1.2

Aaron
