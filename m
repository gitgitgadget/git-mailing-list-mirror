From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2 0/7] i18n for git-am, git-rebase and git-merge
Date: Mon, 23 Jul 2012 16:01:49 +0800
Message-ID: <CANYiYbEqkP950QsQjtzZDQ-GXU9fmDRLAaJsYegsRz7i7HFRuA@mail.gmail.com>
References: <cover.1342920089.git.worldhello.net@gmail.com>
	<7vmx2rr320.fsf@alter.siamese.dyndns.org>
	<CANYiYbFvk60NxfOTxq-xS8vt5t9xW8HLQrE_GuHGkC+u6vWfsw@mail.gmail.com>
	<7v4nozozz0.fsf@alter.siamese.dyndns.org>
	<CANYiYbGyDcR-y-JG5sPLVx0vfc9P+rQerF5ME2nkQ=0FyQB4xw@mail.gmail.com>
	<CACsJy8Ay+iCdSfTA7znXQLWHYg11Qyjt66P21KQLPxu0pEG-+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 10:01:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StDaV-0003Vq-Q6
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 10:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003Ab2GWIBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 04:01:51 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57232 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987Ab2GWIBu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2012 04:01:50 -0400
Received: by yhmm54 with SMTP id m54so5164108yhm.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 01:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8755cvaT5au483kHfyL5bNzO5LPWlPbAKy4DjuSJPvc=;
        b=PjUeB2DV5/UCVfTOf1GaBrXN+zxS5dMKofW69arnTVfStDJuEi7yI3usygG60+BBqY
         2B5GUy+9uybwOfXEMsN5lVsLVyvmND4QsAbLdqbttGGnb93+YBeuck2cyLSWmj+WxqJ7
         38H4a/12w/qbBlCwIXD2P3gVNoigqUXeNt4UmhXqYfGazV9j1BLrz3t87lVzK6Dsb3KN
         b/PLEzDB5oeQNyzHPT4DVAfvdhcpuY25/VIy4lLeSiQDTbwnTFgPMAjRdqijmHftFSoO
         sfA8fqM7F2FR0uAutXePqQ6eI/UKJbXsrGcppuvoEAJQ1b9XFJhO2k70Fm1x68qGbTVV
         iOng==
Received: by 10.43.126.1 with SMTP id gu1mr7853121icc.6.1343030509426; Mon, 23
 Jul 2012 01:01:49 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Mon, 23 Jul 2012 01:01:49 -0700 (PDT)
In-Reply-To: <CACsJy8Ay+iCdSfTA7znXQLWHYg11Qyjt66P21KQLPxu0pEG-+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201925>

2012/7/23 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> On Mon, Jul 23, 2012 at 2:32 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
>> If build git with GETTEXT_POISON and test, lots of test cases failed.
>> It seems that we haven't run these test cases for i18n for a long time.
>
> Gaah.. I should have resent the poison-fix series but so far
> procrastination is winning. Will do it soon.

So, I will just try to fix what I am responsible for.

-- 
Jiang Xin
