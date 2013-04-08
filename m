From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/7] remote-bzr: generic updates
Date: Mon, 8 Apr 2013 13:38:07 -0500
Message-ID: <CAMP44s1WXpNaPXd+fGm4_oFQEFf_Sjq1PsHUn2XjtfMebY2PHQ@mail.gmail.com>
References: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
	<7v1uakyj30.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 20:38:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGxL-0007w4-N5
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935433Ab3DHSiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:38:10 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:49467 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935156Ab3DHSiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:38:09 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so5943158lbd.24
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=nLVLIN2Sfkxmnk/c5lB+89TCUZQrb5qaiqQR5jnne9s=;
        b=AZZXUPKltYTKljE6zhW47XcqB678BplnpuRklx4UfspW/f5WOZtrJ4FL+zdg/liAst
         oOL32NjhAFxhxaDvKH8wJyY4jHnmxDoxm3/fu0ly9l18JSQUJwSjxE/+i2uN1ePgExhV
         oMesAC63DpHEGCiBXQPXx69fX6br2i0Nfh3Y1Oji4ulJvC1U8UF1GNKQnbuC4Kj+6Mud
         Ky7wB0Z+Tz0v1DXvn0l1TM8Uz+sOUKZTtJLxLWv0PWN5h0FP3lxWmMMi3rnRw59a6My5
         D6dozmpqL+21cLwEhX8EAFkXA1QNgkN8pOJP3PQD+/mgWJVLw35IQQtxGDKcZ2eLbqsy
         SW5g==
X-Received: by 10.112.143.10 with SMTP id sa10mr12073777lbb.36.1365446287550;
 Mon, 08 Apr 2013 11:38:07 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 8 Apr 2013 11:38:07 -0700 (PDT)
In-Reply-To: <7v1uakyj30.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220489>

On Mon, Apr 8, 2013 at 1:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Oops.  The previous round is already now part of 'master'.

All right, rebased and resent.

--
Felipe Contreras
