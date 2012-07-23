From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/7] i18n for git-am, git-rebase and git-merge
Date: Mon, 23 Jul 2012 14:38:34 +0700
Message-ID: <CACsJy8Ay+iCdSfTA7znXQLWHYg11Qyjt66P21KQLPxu0pEG-+Q@mail.gmail.com>
References: <cover.1342920089.git.worldhello.net@gmail.com>
 <7vmx2rr320.fsf@alter.siamese.dyndns.org> <CANYiYbFvk60NxfOTxq-xS8vt5t9xW8HLQrE_GuHGkC+u6vWfsw@mail.gmail.com>
 <7v4nozozz0.fsf@alter.siamese.dyndns.org> <CANYiYbGyDcR-y-JG5sPLVx0vfc9P+rQerF5ME2nkQ=0FyQB4xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 09:39:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StDEV-00011w-Vx
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 09:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949Ab2GWHjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 03:39:06 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38985 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab2GWHjF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 03:39:05 -0400
Received: by obbuo13 with SMTP id uo13so9119925obb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 00:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LrPix0cpfiGmuMWlg9uQd+CXnyczPREtZqJZNkLSgUs=;
        b=IEEScc8oGvmvq0aNGy013prsCEoSWgSH/Fsm1MXGaA/T866B+Yqe83o7EMivxB7lH3
         BWbH4EdHL86mjh+AyEEJIXO6FH1SOfCJlPNUgklrfTiCEhFTaTyT0Gt6lKJ3QaOGblbJ
         QpUfif7Teqd5HoCUWLBWUbbWn8aE/PePMFAlIqP7B3o/5l9kSZHJIDCMJFKI2AF/1DPq
         JwfWdrycolxhlKsbtVcL2IDTmHKSgSaFssMOM0qsgL2I0Llu6SaXgHHmX+GGPzwXlYMO
         6Bn7NQBcUH9AycX5hPBRnHSvv8e9YsDMzuQTjowaqe/TZFgPAsjae9PXxMb8Ylsy6/3w
         56jA==
Received: by 10.182.88.9 with SMTP id bc9mr19563390obb.4.1343029144967; Mon,
 23 Jul 2012 00:39:04 -0700 (PDT)
Received: by 10.182.177.67 with HTTP; Mon, 23 Jul 2012 00:38:34 -0700 (PDT)
In-Reply-To: <CANYiYbGyDcR-y-JG5sPLVx0vfc9P+rQerF5ME2nkQ=0FyQB4xw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201921>

On Mon, Jul 23, 2012 at 2:32 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
> If build git with GETTEXT_POISON and test, lots of test cases failed.
> It seems that we haven't run these test cases for i18n for a long time.

Gaah.. I should have resent the poison-fix series but so far
procrastination is winning. Will do it soon.
-- 
Duy
