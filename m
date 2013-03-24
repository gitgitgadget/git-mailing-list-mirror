From: Stefan Beller <stefanbeller@googlemail.com>
Subject: git problems at kde
Date: Mon, 25 Mar 2013 00:22:33 +0100
Message-ID: <514F8AB9.9000806@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 00:22:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJuFb-0005VX-7r
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 00:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434Ab3CXXW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 19:22:27 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:43452 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab3CXXW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 19:22:27 -0400
Received: by mail-ea0-f177.google.com with SMTP id r16so2049013ead.36
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=NdZfngT5DwArw5lLpPkds+xQo/S1XMXXg7Lt68QYc5Q=;
        b=a4kZR1FraPMyWA9iycL+sQWRdSuJmpyLNmUM5OQhFVmztP2dszMBC61hITTuZL75A3
         LwHhy78Vfp5IHUAmF/PZab9BaRV8pMf0LxRzHgDFyZcWQVV7hr7zrKgQYZGweSqUPysN
         qUR+bpb+k8AwROSnTItDuMUwOadnXaqLa0DDp8DyQyiGPaPkQ6tDfiMMRmiM6SieqYxK
         Pa3WAmkECf5ZhG1zhYxBiDZXXJSU2YOelxBtY971QUIHkOJKBinCyZuyuR7+WpoNh3so
         LvuEWhM7GAc29whgvdnXk6kHHq74t87c774ouu2gIwxpLZuzEtmphxadg34WvUAh9bz2
         KqOw==
X-Received: by 10.14.207.200 with SMTP id n48mr33568eeo.4.1364167345801;
        Sun, 24 Mar 2013 16:22:25 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-111-92.unitymediagroup.de. [109.91.111.92])
        by mx.google.com with ESMTPS id s47sm4527290eeg.8.2013.03.24.16.22.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 16:22:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219002>

Hi,

I personally found this an interesting read:
http://jefferai.org/2013/03/24/too-perfect-a-mirror/

It discusses git and apparently some failures of it.

Stefan
