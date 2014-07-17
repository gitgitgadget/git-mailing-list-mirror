From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] .mailmap: Map different names with the same email address
 together
Date: Thu, 17 Jul 2014 16:32:23 +0200
Message-ID: <53C7DE77.4070304@gmail.com>
References: <1404996506-7723-1-git-send-email-stefanbeller@googlemail.com> <xmqqa988qcsv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: jl@opera.com, ksaitoh560@gmail.com, vnwildman@gmail.com,
	git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 16:32:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7mjX-0006C6-F9
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 16:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbaGQOc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 10:32:28 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60348 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401AbaGQOc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 10:32:27 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so2928888wib.5
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3wHXphqBwPMpD1Fcy4IG147AlUMql64qr5Cp9bl2qqg=;
        b=a+ONU+iZIFOktnF9zuRmwrbs5FvluKFEWjLL2Ise8xVv5Rkemmipxt5QYdb0Rb6VRF
         4q2BnppvuWXnX6Yt8WF79KFp9jhlgCW6/w/ZxE6AMcVbZ+J601nGt/CYJujyIYP1LJSR
         pWmiv6wN7yRJgnpWw9aTJa90gUx0KMwhLDhInB1aJnlk3bMb7fyhrq81/qhNKQMNWcqJ
         aPn+1Gz0k2Eshg0cMx0ZoRHYvaiSxVmYyJaMgc4EmT1vyeg7DGkQz+NPcB8+OveOT/jA
         0sykN84xiC4+F2l+ESI4Mzbca06tdZURszI512y9SwfUmvayjQa3P/4ym5o172gy/N4t
         Nbyw==
X-Received: by 10.194.90.106 with SMTP id bv10mr46878532wjb.20.1405607545146;
        Thu, 17 Jul 2014 07:32:25 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id lo18sm21703565wic.1.2014.07.17.07.32.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 07:32:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqa988qcsv.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253737>

On 17.07.2014 16:29, Junio C Hamano wrote:
> If you received a private "no" to some entries, please advise;
> otherwise I would say the patch is ready to be picked up.

I have received neither a no nor a yes privately.
So please pick it up as you like.
