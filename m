From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Thu, 25 Apr 2013 00:50:21 +0530
Message-ID: <CALkWK0mK=myPEsFrhVd2Xi3U10L+jZ+_WV=1JvxyvpnO3yUJGg@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-6-git-send-email-artagnon@gmail.com> <7vmwsndbve.fsf@alter.siamese.dyndns.org>
 <CALkWK0kaFc8cj-=1NbEwC_61U7qUCye70d9MZR66TpKB3i9XyA@mail.gmail.com>
 <20130424190638.GE29963@google.com> <CALkWK0n2zFp1t7qtKp8-Ohoz0QEn4BQrfvxzqt+qwLS5+sNdHQ@mail.gmail.com>
 <20130424191453.GG29963@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:21:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV5Fc-00047f-PS
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306Ab3DXTVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:21:04 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:58113 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757003Ab3DXTVC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:21:02 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so2599852ieb.13
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JNbsCKGL9xklTaF9oWJUUXrlXmMp70Xr4yE2W3vNa9M=;
        b=Mwmd6J557bLVfnL2GCPQcwBHeVl7W2GuVrOk1wp7vWmUJ9iUCQYTQFK8yxtnLA1Env
         eElfA/LE+toXEkeexco57zvgTDNm3t0nw+gkCu0jzdTgwY3E+axfNBOojeub1nwDfkp6
         k5g5zfyp+0qsK3jjpzxnNiCYmaYFEnBa+H4ou/eKWdp7DXN9I6ypqu/kC5Ac0MgQ+lfq
         526KzMzJsYwMwc6oIa6k55ilGeaRUhy9QcIYX8sKw+aPoZk6kyjU7Nskh/Xbv6IovkJo
         s+1dm7mchZkeAlBrMhVxGqUbSA9uFEI2h4pAQj6hBITAcerVYZzY6sHCR9mgXuhyKIfb
         VgCg==
X-Received: by 10.50.57.200 with SMTP id k8mr29019167igq.44.1366831261686;
 Wed, 24 Apr 2013 12:21:01 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 12:20:21 -0700 (PDT)
In-Reply-To: <20130424191453.GG29963@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222302>

Jonathan Nieder wrote:
> Oh please no.

If I understand this correctly, you are horrified by this?
https://github.com/artagnon/dotfiles/blob/master/.gitconfig#L30

By the way, my zsh aliases git to g.
