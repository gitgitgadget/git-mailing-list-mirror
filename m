From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [Patch] Added http-protocol for git in the Documentation folder
Date: Sun, 03 May 2015 22:22:41 +0530
Message-ID: <5832C62F-D7AF-4597-9DBF-FA6DBDDBA99D@gmail.com>
References: <CAKB+oNsPzoBRUn6rD3Bb8soHEub3quT76MB25KyWfcEC1smdJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Alangi Derick <alangiderick@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 19:07:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoxMy-0003rI-Hx
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 19:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbbECQwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 12:52:49 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33403 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbbECQws (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 12:52:48 -0400
Received: by pdbnk13 with SMTP id nk13so142463971pdb.0
        for <git@vger.kernel.org>; Sun, 03 May 2015 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to
         :message-id;
        bh=V4f1gwaoin1sLIJ1GxN8Osp1ojem4eGBWO6pqtgBfnE=;
        b=CKOCceYREGeelslHmL/Pn/g7+RvLwLYsasiVyu1MlR8I+/R57PHOSWj8ULEWIeqER6
         mANzG2b5vr6sgyM/3l6YuX7VwlwPUG1mTjAxv6Imx98JQwuXuqpAW4+REIL229UArcqy
         z+neqITWNWNQDj1ycev9n0n1/y4xe2RepgrkQRWxvl3E3MQRgYbrQb9wJ0f+3psc/BJk
         ncqYuphv3S/Cx4c4/dfzy71keZ7P1wZOkFML0usm4eEKdzgxtgHeotQJK0d5pb3nWK7s
         5w4QC3FDC9AyFmacPcJRohgEpjc/NNZpUQji91oDiz8CQrbPxWaaZtCY4DUpTjd0GbRU
         wBkg==
X-Received: by 10.68.219.201 with SMTP id pq9mr30210376pbc.97.1430671967638;
        Sun, 03 May 2015 09:52:47 -0700 (PDT)
Received: from [192.168.0.100] ([103.227.98.178])
        by mx.google.com with ESMTPSA id gi1sm10358665pbb.5.2015.05.03.09.52.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2015 09:52:46 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKB+oNsPzoBRUn6rD3Bb8soHEub3quT76MB25KyWfcEC1smdJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268271>



On May 3, 2015 9:48:15 PM GMT+05:30, Alangi Derick <alangiderick@gmail.com> wrote:
>This patch is to include the http-protocol in the documentations
>folder as stated by the left over projects here:
>http://git-blame.blogspot.de/p/leftover-bits.html.
>I got the documentation uploaded by Scott in his drop box some years
>ago.
>https://www.dropbox.com/s/pwawp8kmwgyc3w2/http-protocol.txt
>
>Sorry my git send-email is not working that is why i sent the patch as
>an attachment, so it can be applied.
What do you mean by "git send-email is not working".
>
>Regards
>Alangi Derick Ndimnain
