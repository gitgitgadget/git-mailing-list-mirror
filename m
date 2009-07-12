From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v2] init-db: migrate to parse-options
Date: Sun, 12 Jul 2009 16:37:36 -0700
Message-ID: <780e0a6b0907121637x3e4c1e5ax786266c59566cae5@mail.gmail.com>
References: <4A598E03.10204@gmail.com> <1247394272-6944-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 01:38:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ8ca-0000PR-4R
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 01:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbZGLXiB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jul 2009 19:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbZGLXiA
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 19:38:00 -0400
Received: from mail-gx0-f215.google.com ([209.85.217.215]:46211 "EHLO
	mail-gx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZGLXh7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jul 2009 19:37:59 -0400
Received: by gxk11 with SMTP id 11so1917555gxk.13
        for <git@vger.kernel.org>; Sun, 12 Jul 2009 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=W5qg4ILqfGNZMG9JF981yFLlzsrEi3gMhYGgyfk8cM4=;
        b=aXNy6YwGPYSe6dexDEUUXOnaJfvOK2Th5eU2OMl/oHyg1h/rJG2CJgNOxJPuR1RBjs
         LwlGiRkwwMjvSUvZGXVV5JSpkTpKJOtBBOxiOZMgOBR3YaPEteQ7h8NpxI2KsfJbmtHn
         agc3MGMhBX0OKXOs2ghvM5wlU5fRUrurUIZlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=D4Q/ZavfKKfwcOxbpz8JNIQvasBWHpZWTrpl/n9a13Q/XQmHnbdHBwV1oBAG/YaR2x
         gYIrp8sqVDu9AtWFIOEvqo5EYLRmzC8KCuHZVnEMR7vMI0lLhdVzuBk9L828QBCTgieU
         GPAn4jJS0vbYLDZErwG3azXmnM874K1rRzCOk=
Received: by 10.100.135.9 with SMTP id i9mr6131410and.169.1247441876228; Sun, 
	12 Jul 2009 16:37:56 -0700 (PDT)
In-Reply-To: <1247394272-6944-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123168>

2009/7/12 Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>:
> Also add missing --bare to init-db synopsis.
>
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---

Acked-by: Stephen Boyd <bebarino@gmail.com>
