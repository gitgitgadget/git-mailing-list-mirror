From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Merging strategy for extending Git.pm
Date: Sat, 31 May 2008 14:42:47 +0200
Message-ID: <484147C7.1030001@gmail.com>
References: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com> <483FA6B3.4070607@gmail.com> <20080530095938.GE18781@machine.or.cz> <48401A09.6060301@gmail.com> <alpine.DEB.1.00.0805311237100.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 31 14:43:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2QQw-0001qx-N2
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 14:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYEaMmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 08:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbYEaMmv
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 08:42:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:51308 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbYEaMmu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 08:42:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so310259fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 05:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=wQBP6cppgzm23mDFIH9f1wVC2kfh0gLbNx6IJnil9wM=;
        b=IAEmStx2GystGQC8fg6dqSwyZ8/x7f6EV95e4zI3pRf3bUuTtV4XZjEdMC6BO4tH4e1gbUh0qD4z5kQWA3Jw7rvIjUJLoi83kWvCcIgXhmnCHpiMYNzKUSr/Cavl/X8m87hEGa0/M2nrAJhF7KKMmv/dF7pwgU0dYnHerxse8UU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=rmXub7IdXQZeg6qpZUZFXqLZomK7Lk2AJiuyQQfT3ao35mF1yqU1kjHsKTDtm4f0WKNfq6yTQ2xS+5J273BuHBWs82stplEW4VrzH+pkEzNw15d0QtX+6gUaJDLtRSpmK/cGIUCoWDWFTO4uSIT+DIzYNnI3U05JdIeoXpDBqx4=
Received: by 10.86.54.4 with SMTP id c4mr397428fga.33.1212237767951;
        Sat, 31 May 2008 05:42:47 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.213.54])
        by mx.google.com with ESMTPS id 3sm2063796fge.3.2008.05.31.05.42.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 05:42:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <alpine.DEB.1.00.0805311237100.13507@racer.site.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83381>

Johannes Schindelin wrote:
> I think it would be best for you to have that in a personal fork of git on 
> repo.or.cz.

Thanks Junio and Johannes for you comments!  My repository is here:
http://repo.or.cz/w/git/gitweb-caching.git

-- Lea
