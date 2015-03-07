From: karthik nayak <karthik.188@gmail.com>
Subject: [GSOC] Introduction
Date: Sat, 07 Mar 2015 16:55:26 +0530
Message-ID: <54FAE026.6070602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 12:25:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUCrP-0003vu-LA
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 12:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbbCGLZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 06:25:31 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:39672 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbbCGLZa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 06:25:30 -0500
Received: by pabrd3 with SMTP id rd3so25127383pab.6
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 03:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=KHU4WOBAHh3ByCNegYnWiEFKE27uXslq6aHZFs5z7ls=;
        b=wcWJSUd4yB877hWM6f2ZIzaqhtEYN2JvqBHALIvT1LMVWn77AclDAmdwZHEfTqyAxS
         1k8J3WW0KY9c12T/nhzkiHQsVb5jOX6w7d+xt34ye5c6a7OWSXHftDtPYn3S/xlmVIDB
         Xp6y7jEf4cfGL2b7OXuoGvYqY28KBo3dWw1dy+ILiHOWswiwoCk5faAi1bUjCRgarOGH
         z2pj1+UBp8e639l1fsQGvPWCzqGNEah5DCmwvboswD9qjK6Zpmy7OyDLsn2168oH2y06
         sGGXlGl4pndyg/QUOIqDXpox4RZ90LaB62QPGU9Q1VAKlN4m8DlqzLpqhm1hCNhCIS+d
         MUrQ==
X-Received: by 10.70.91.198 with SMTP id cg6mr34041709pdb.124.1425727529477;
        Sat, 07 Mar 2015 03:25:29 -0800 (PST)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id sg4sm12166240pac.11.2015.03.07.03.25.27
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2015 03:25:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264999>

Hello everyone!
I am Karthik Nayak from Bangalore, India. I am currently pursuing my B.E 
in Computer Science. I am very keen on contributing to Git via GSoC 
2015. I have worked on one of the micro projects[1], I like how code is 
reviewed via the mailing list, It always ensures different perspectives 
on the same code and shows how there is always room for improvement.
I have been using Git for personal work, since about two years now. The 
reason why I want to contribute to Git is because I can relate to what 
is happening in the code, since I use it regularly.
I want to work on the project of "Unifying git branch -l, git tag -l, 
and git for-each-ref" and have been reading up on what Junio suggested 
in a reply to Amate Yolande[2].
I also found a link to a previous discussion[3] on the same topic. Is 
there any other discussion on the same? Do you guys have any comments?

Regards
-Karthik


[1] : http://article.gmane.org/gmane.comp.version-control.git/264911
[2] : http://article.gmane.org/gmane.comp.version-control.git/264966
[3] : http://thread.gmane.org/gmane.comp.version-control.git/261479
