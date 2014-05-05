From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Mon, 05 May 2014 16:43:05 -0500
Message-ID: <536805e9c9f42_1a7bde73088d@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <5367e1ac39571_5977e7531081@nysa.notmuch>
 <20140505195525.GC23935@serenity.lan>
 <5367f5de8e411_1193d2f30cba@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:39:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiAp-0007Xo-GX
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724AbaEEVxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 17:53:51 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:52013 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756357AbaEEVxv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 17:53:51 -0400
Received: by mail-ob0-f172.google.com with SMTP id wp18so1568105obc.31
        for <git@vger.kernel.org>; Mon, 05 May 2014 14:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=F3ywy/jxwjMQ7VHkC8TYBDcOWZldvdjU2f+lgt1zaU0=;
        b=cxRY/UX35BMS7gSdygooNijw8drVJrhm/ZDG36mG/RDGYPWa2ssOJhYLYvnWs2oRvk
         JUTHX/y1y9Zchqc0ce4OON8sXSs3JY+z3B6dji34fPfkSsXFBKNqZfd/wyJ7eqD4YA1f
         Q9o8jhltYXtHICHBN1Yeg1lfxVAj3i1H9gNeoW598P36dDoYoSD4G2uWPL7+6RUADdbX
         LEo1tZ2+AV90j7Bvwhh5VwiDWuAA+T+GgDIo1MH12KkFcKhdXyzMD8dEseCjgNs1/hbY
         KhfeBLAYiuOWCzVBt6UfNr7KIaCQX4lYTUkNitYWJ8bOuiXsxUnGSJ/Fl4VeariLKaLC
         iz1Q==
X-Received: by 10.60.37.166 with SMTP id z6mr35918990oej.22.1399326830687;
        Mon, 05 May 2014 14:53:50 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id bj8sm22057084obb.7.2014.05.05.14.53.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2014 14:53:49 -0700 (PDT)
In-Reply-To: <5367f5de8e411_1193d2f30cba@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248146>

Felipe Contreras wrote:
> John Keeping wrote:
> > I don't see that building against Mercurial's default branch, so it
> > will not help with future releases.
> 
> I can easily add that.

There:
https://travis-ci.org/felipec/git

-- 
Felipe Contreras
