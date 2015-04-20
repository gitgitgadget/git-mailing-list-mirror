From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCH v4] git-p4: Use -m when running p4 changes
Date: Mon, 20 Apr 2015 11:25:35 -0400
Message-ID: <CALM2Snaih=r_CAACVodbgZiLqSUvJr_yPXsipEdR2WZs+utaZg@mail.gmail.com>
References: <CALM2SnY4GZDSYOjLmDqdq9SgGGywRO2A3XU3639E_0JAh-2P5A@mail.gmail.com>
	<1429542020-11121-1-git-send-email-lex@lexspoon.org>
	<CAE5ih79BLm1LbZersZeOxShq=W4X5xaPHE1cDwctA5cJOSLRJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 17:25:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkDZs-0002uQ-US
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 17:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbbDTPZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 11:25:36 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33035 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbDTPZf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 11:25:35 -0400
Received: by paboj16 with SMTP id oj16so209917074pab.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UPlQAkEZHKHVayizP7mODHyY2EkRR2H3kOjeM2HR9eA=;
        b=Kd8dcK4hiHQ1mpnV8YIsAKoGaC7Aiu5KQ3jJi8yaVRwixNESkGswtffa+SjUogpBdY
         Krtsv7arts3wdSI9e9GyBmQhmq/G/b6BiqvFqsXFqmv8Cg063WwP4h6RrOlWQ+nbG78M
         DmWWT1Z0uaptlb7G5HBN9/LKBtTQsCaLr3DDxCCwY1o17IUXQfFolSfUIFYMEWelhX1e
         ymq+RKf1l/a3tpK/n/zoZHWcck+o5LFolBJLJahx0q/99IGIbuGrIIrLGHdtGJcWoyZI
         rO5y6QJ10e5xgYTfief6MF4/mv1g9gbfIGS9oxd+cJ719IZ0gTsU2+jUTIWi7OafNAXd
         s8uA==
X-Received: by 10.70.125.129 with SMTP id mq1mr20303144pdb.19.1429543535453;
 Mon, 20 Apr 2015 08:25:35 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Mon, 20 Apr 2015 08:25:35 -0700 (PDT)
In-Reply-To: <CAE5ih79BLm1LbZersZeOxShq=W4X5xaPHE1cDwctA5cJOSLRJA@mail.gmail.com>
X-Google-Sender-Auth: apk716CNnuDnJNu4br-37ORLChk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267471>

On Mon, Apr 20, 2015 at 11:15 AM, Luke Diamand <luke@diamand.org> wrote:
> Sorry - could you resubmit your patch (PATCHv4 it will be) with this
> change squashed in please? It will make life much easier, especially
> for Junio!

The message you just responded is already the squashed version. It's a
single patch that includes all changes so far discussed. The subject
line says "PATCH v4", although since it's in the same thread, not all
email clients will show the subject change.

Let me know if I can do more to make the process go smoothly.

Lex Spoon
