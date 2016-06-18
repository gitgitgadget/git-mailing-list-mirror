Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FE9D20189
	for <e@80x24.org>; Sat, 18 Jun 2016 20:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbcFRUMm (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 16:12:42 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34725 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbcFRUMm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 16:12:42 -0400
Received: by mail-pa0-f65.google.com with SMTP id us13so8041505pab.1
        for <git@vger.kernel.org>; Sat, 18 Jun 2016 13:12:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Py7wIwhF6adUBHlgW5RkFCoAueiqbFDhs1c/bfd42Hs=;
        b=Ijnt42TjHEpLpa+UX2yWRxONTjKiAs+yIdDdQ2VY4XkyKdHK0btUPGAbsg0ao2PTsy
         7bkpg5x+5C24vBZKtUUy2da92TATEXM1QWYAsWA4iLFXaidGlC9eucbYUlHQfeus4SUr
         n2pesQHXrK3HNbgNk/yRPUvoqDkTAZKv6lVAiiKmk07Mip4HHNIVIibQMitJ+jqqu06x
         wafZhDuygBr59y7ILpSxuM4ieyfT4aAdZuxCAppBBmQvNt20rAW5FSrQ23td4W4NJ/OO
         KUfByU5Ma3KShkxfql1K3nChBbbJ4dDKuVaRmuvPbiGhAcnPrpXNu0xvVgkg0MnnzhGb
         7/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Py7wIwhF6adUBHlgW5RkFCoAueiqbFDhs1c/bfd42Hs=;
        b=KMVzoztdad+/EUNGpmc6U+F53vqQtq8Ml+YizERZXUT5C838wYZytK58HKsiDAJ3Zw
         Ik0Q4bFEA8plIkDuVSWr8Wsq0KLRRAK/wLHoBEFwbo9eZVCpOiZhZeDJgvz37hPe4fLQ
         VoMSTjqTaie5pws5pXfVDZf6dxBRJKT47rdNISWqyvH6+ljHhPACbuJTC32Xxg7ZFATH
         zEItL3QGGKAdLSdqP9ijevbGXGn53UVOiOqp8vkcoyVPAM9+mdQplQpoKoVw11eMHvR6
         DvxD/yEbLIFNufrpr6lDXjWkLyhiVDLUMFhyV4WT7f4VyYkcMjjOtYopeQYnOILhBMs/
         P/Pw==
X-Gm-Message-State: ALyK8tIqdnYx+gymkeMdlZodAM9IlOmMJXqt1eV3ldexGOfH1jWSnFNofoamCdzr6mR52g==
X-Received: by 10.66.155.167 with SMTP id vx7mr10774671pab.125.1466280761276;
        Sat, 18 Jun 2016 13:12:41 -0700 (PDT)
Received: from localhost.localdomain ([113.23.115.12])
        by smtp.gmail.com with ESMTPSA id c189sm47804721pfg.19.2016.06.18.13.12.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jun 2016 13:12:40 -0700 (PDT)
From:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
To:	git@vger.kernel.org
Subject: 
Date:	Sun, 19 Jun 2016 03:12:19 +0700
Message-Id: <20160618201220.1407-1-cuong.manhle.vn@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160618193710.32265-1-cuong.manhle.vn@gmail.com>
References: <20160618193710.32265-1-cuong.manhle.vn@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Sorry, the example in commit message is wrong, due to editor auto wrapping line.

