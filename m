From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/2] builtin/apply.c: report error on failure to recognize input
Date: Sun, 04 Dec 2011 09:39:07 -0600
Message-ID: <197987ca-1fbd-473f-be7e-9e47439c47ee@email.android.com>
References: <1322944550-27344-1-git-send-email-drafnel@gmail.com> <1322944550-27344-2-git-send-email-drafnel@gmail.com> <1323005418.9400.49.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: artem.bityutskiy@linux.intel.com
X-From: git-owner@vger.kernel.org Sun Dec 04 16:39:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXEA6-0007oU-Il
	for gcvg-git-2@lo.gmane.org; Sun, 04 Dec 2011 16:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab1LDPjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Dec 2011 10:39:19 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35395 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab1LDPjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2011 10:39:19 -0500
Received: by ghrr1 with SMTP id r1so3874984ghr.19
        for <git@vger.kernel.org>; Sun, 04 Dec 2011 07:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:user-agent:in-reply-to:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=O73aSFNCuRjB4nFCYTXXA4MtLZXOQA+vUbtZlhvZelM=;
        b=sRUmZYQ6GNx4XdoIzzjhlplOkMi3mMeJdGTRDhCc/P26DvcLQsMAeo1n3DYgTdiRLD
         VaLznzbhCQIZ72x5fBNb5MLS4G3us1nJ5u26dvBE/I1mPdiHoKqbtGcVJzXYOOe255Q6
         m8HVnk6eFkiyJlWSd68YYV/ps+4BOcneY7T0E=
Received: by 10.236.153.226 with SMTP id f62mr7051289yhk.62.1323013158484;
        Sun, 04 Dec 2011 07:39:18 -0800 (PST)
Received: from [192.168.0.113] ([96.19.140.155])
        by mx.google.com with ESMTPS id 39sm23128414anu.6.2011.12.04.07.39.16
        (version=SSLv3 cipher=OTHER);
        Sun, 04 Dec 2011 07:39:17 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <1323005418.9400.49.camel@sauron.fi.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186269>

Artem Bityutskiy <artem.bityutskiy@linux.intel.com> wrote:

>Brandon, Thanks a lot for picking this. I did not reply because I did
>not have time to look at this after your review yet, it was in my TODO
>list. But I am happy you picked this and fixed the issue.

No problem.

>Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Thanks.

-Brandon
