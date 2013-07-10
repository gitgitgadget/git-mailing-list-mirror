From: Chanakya Vattikuti <gk2cveragon1@gmail.com>
Subject: Error
Date: Tue, 9 Jul 2013 20:30:37 -0500
Message-ID: <632ECB1A-63EA-4334-8716-53A1F45B6E0B@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 03:30:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwjEy-0003uD-U9
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 03:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab3GJBak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 21:30:40 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34611 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3GJBak convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 21:30:40 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so5805747pdi.16
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 18:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        bh=i1HMripOPwOmyP28JNsqryGXEW5aFlILjmuFRucEe3w=;
        b=Mwday4ajwtQzU40JZw/O9MY0Hhdjh+kbBCFrl7Bu9CY+X2xdy48k2qo7VpTnpiTA+I
         i7nYcnsIYQcp3kskWAMDENYHIE3FWUQRSodQdBT5KUxCn7gzzF7Irrk+j7dhj0vUxMT1
         CSOqA6OfRPHYWmH2H1NI3e2dZxTpb4lGQ8yipuNhMQzwnIYP0jxKtwsL7GLXs7ReSlQc
         4RoAs0taMxbY5Een+s25xb63m9N1HzFaHOgVFEEZSXk+5V4hOjzxArrU6eiyJeCmT84n
         KwpdIT9wwoz6i9S8/nEDnapoef8TViE9H4oAHSFjJ5aavqSL9wMZqNtrSs14IKbZBQyT
         9/pQ==
X-Received: by 10.66.252.234 with SMTP id zv10mr30725407pac.186.1373419839633;
        Tue, 09 Jul 2013 18:30:39 -0700 (PDT)
Received: from [192.168.1.5] (ip68-225-74-166.no.no.cox.net. [68.225.74.166])
        by mx.google.com with ESMTPSA id te9sm16840636pab.6.2013.07.09.18.30.38
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 18:30:39 -0700 (PDT)
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230021>

I get this error message when trying to create a shared ssh key in Mac osx Lion

scp .ssh/id_rsa.pub cvattiku@cook.cs.uno.edu:~/
ssh_exchange_identification: Connection closed by remote host
lost connection
