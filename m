From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] contrib/subtree: Remove --annotate
Date: Sun, 3 Jan 2016 10:06:36 +0100
Message-ID: <CAHGBnuMtmUx_NwETPv+xU23PG8vmWm6jWpoRXc9+2qXok5Ak4w@mail.gmail.com>
References: <1451766984-4648-1-git-send-email-greened@obbligato.org>
	<1451766984-4648-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, techlivezheng@gmail.com,
	alex.crezoff@gmail.com, davvid@gmail.com, cbailey32@bloomberg.net,
	danny0838@gmail.com, Steffen Prohaska <prohaska@zib.de>,
	th.acker@arcor.de, Jeff King <peff@peff.net>,
	gitter.spiros@gmail.com, nod.helm@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Sun Jan 03 10:06:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aFeci-0002Oq-61
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jan 2016 10:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbcACJGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2016 04:06:43 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33440 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbcACJGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2016 04:06:37 -0500
Received: by mail-ig0-f179.google.com with SMTP id mv3so181995642igc.0
        for <git@vger.kernel.org>; Sun, 03 Jan 2016 01:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SJ90rhU4xkcEalRgrAca1NKb1sXc7gw5vRzX06vfqFg=;
        b=XHypxk5y6wiQ5hCsRMTWB0q6ZJR9QnPGbqWm/AibpLcMU/8eW3Ko7X4lUUxHppkXRW
         Z1TlhEThr08JhnHgB01NXlLuyjbZHMLoo0k9iA01ZPTuLXOmCjfqIuOAv+ZXGML/nRIu
         uWyPrxIDnlOEzrTm9NREUsd9OrA2fURiWAhtOpNWjFJnHdbBnB4Yvyxfn3VqdM/LdRuy
         t/+kriCylZFhP2kzNGv+XgiVRqAk0GkLNaGj7sjSumtupbb6BpkARowtJT3q0PucRJXj
         wpaMXU6U39fvU5Nzclye29GR+pv9eD2FQHInzdk4iFzGulaa36Q1zVpjon9T+Ltwbn8d
         4pVA==
X-Received: by 10.50.25.226 with SMTP id f2mr43250990igg.30.1451811996054;
 Sun, 03 Jan 2016 01:06:36 -0800 (PST)
Received: by 10.107.180.66 with HTTP; Sun, 3 Jan 2016 01:06:36 -0800 (PST)
In-Reply-To: <1451766984-4648-2-git-send-email-greened@obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283272>

On Sat, Jan 2, 2016 at 9:36 PM, David Greene <greened@obbligato.org> wrote:

> commit messages.  git has other tools more suited to rewriting
> commit messages and it's easy enough to use them after a subtree
> split.

For completeness, it probably would be a good idea to name examples
for such more suitable tools as part of the commit message.

-- 
Sebastian Schuberth
