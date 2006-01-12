From: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: git-pull fails after git upgrade
Date: Thu, 12 Jan 2006 13:53:32 +0800
Message-ID: <2cd57c900601112153t2d85895bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jan 12 06:53:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwvOy-0005Xj-6k
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 06:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWALFxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 00:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWALFxd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 00:53:33 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:65125 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964821AbWALFxd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 00:53:33 -0500
Received: by nproxy.gmail.com with SMTP id o25so207672nfa
        for <git@vger.kernel.org>; Wed, 11 Jan 2006 21:53:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YgNyW/71TQ8bjjvaPh3RUqEE23yeC5fJI68Wh+tcM0SmsR505UBSRD5dbkrCekd8Mt297mkLLxpiEXBbxbSWsZowQfBx5Sn3NMRBGq7ckhvySzqenirYIVBNdUYyeYXta5/Gs0yZd3p+a2QFUrv2fENY3LX6nKFBm9a4KMtldWg=
Received: by 10.48.157.3 with SMTP id f3mr111215nfe;
        Wed, 11 Jan 2006 21:53:32 -0800 (PST)
Received: by 10.48.42.2 with HTTP; Wed, 11 Jan 2006 21:53:32 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14548>

Hello,

gemini:~/linux/linux-2.6> git --version
git version 1.0.8

gemini:~/linux/linux-2.6> git-pull
fatal: unexpected EOF
Fetch failure: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

What am I missing? thanks
--
Coywolf Qi Hunt
