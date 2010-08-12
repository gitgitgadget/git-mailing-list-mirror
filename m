From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update extra!] git-remote-svn: Week 15
Date: Thu, 12 Aug 2010 12:01:48 +0530
Message-ID: <20100812063145.GB3311@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 12 08:33:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjRMU-0004cC-2r
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 08:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758647Ab0HLGdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 02:33:52 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49522 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757469Ab0HLGdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 02:33:52 -0400
Received: by pvg2 with SMTP id 2so332008pvg.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 23:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=40iHDsYfdaupKNU0AVzcGzvZMb9d/JKr7gIrh4Outkk=;
        b=sTEFIly8zdpDcA5od6IZfElYcH/tp3jfaCdfACu9lvZyWfCNNz/0qpi4EPU7AqMObN
         S4AicT/aKCv1vrmKHB6MoAcjEd7cw23TvN9bxcADSMf78X0f5119YXTVOnfxzK4mR9Ra
         BD9rSEO6OhN8PliHMZ9+IBNeat+SiYEnh/O1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=q/SwsbOvLjvvyidoT6n/twiH3pBEf6eRFAWR/Ge5oOzDfVYPTo5NGkEQjR8z/485WQ
         bywX6oA8ZPGf9mCNArRHUTuzmykEoyAsGaVC11Y0Aady4MxEGh/G1XIxBp+ciZmUhZ0z
         qvGjAGbEhBBvwyUgpg1BDQ7TYwpwSU5TxalD4=
Received: by 10.114.131.13 with SMTP id e13mr23130079wad.201.1281594831807;
        Wed, 11 Aug 2010 23:33:51 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id d39sm1697773wam.16.2010.08.11.23.33.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 23:33:50 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153347>

Hi,

I've approached the end of my SoC period. While my academic workload
is steadily increasing, I'm finding that I have lesser time than ever
before. I'll write out a more elaborate email next week*, but I've
decided to visit home this week (since I haven't done so in almost a
year now). That's an endevour in itself in this country- I'll be
travelling for 24+ hours one-way and will be mostly unavailable until
next week. The downside is that I'll lose a valuable weekend that I
could have otherwise used for hacking, but I suppose it's alright now
that the SoC period is almost finished. Just to be clear, it doesn't
really change much- I'll keep hacking just the same and take the
project forward in my free time. I just won't prefix emails with
"[GSoC update]" anymore :)

Thanks for reading. Oh, and do tell me if there's anything in
particular you'd like to see in that large final GSoC update email.

* It'll look the the ending credits in a movie with tons of people to
  thank. Everyone wants to skip it, but is made to go through it all
  the same :)

-- Ram
