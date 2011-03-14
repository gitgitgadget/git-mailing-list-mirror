From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [Support] Branch pointer does not move
Date: Mon, 14 Mar 2011 16:19:39 +0100
Message-ID: <AANLkTimW+01wriSjvEVEyQ8SE5RPxhGv_o2Rus9kw6ZQ@mail.gmail.com>
References: <op.vsb4lif0bl4hj1@metalltrottel.fritz.box> <AANLkTik5MGyw_6vnT8055Yap3Ca1pDQYpJ_RXiZQbwA4@mail.gmail.com>
 <op.vsb95dilbl4hj1@metalltrottel.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Franz Liedke <franz@develophp.org>
X-From: git-owner@vger.kernel.org Mon Mar 14 16:20:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pz9ZO-00009y-H6
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 16:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab1CNPUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 11:20:25 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41831 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab1CNPUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 11:20:25 -0400
Received: by ywj3 with SMTP id 3so2086181ywj.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=yA6AYowcPsa8fhkelNDAuP9llFJrbWHXDEmnwrt7M2c=;
        b=ERJsAOzM9OD7r6LwVbOv+kEhezmed4NQPJUwEJtQQ5TVG1gLxVaQ36OLmaZU722rXY
         Lef/HNcfC2Nteoq8aTPQTE7CKuf0PgnhIkSkv5VOqnN0ErF885jkNoOopCi4+JW1KT5F
         Bxg2wIBrtdofOezPPdQRJ/AlIDOCIGAYvB5/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ejlgN4scdz5/qz4W/RcXVZHowmUAPGoPW0m8eeni1phiTbjl0FEBDzRcJLqai1BSNY
         vuZmYcxmYf9iVykXr2jQ4AV4H1k7gU94Kt5nsXHKy99KJ46I//JbkK84jIF0iLVbfDHe
         H6xWsMOxVkXjuZ6AkIauJs+2UtcvJXwLjqoWc=
Received: by 10.150.148.7 with SMTP id v7mr1148857ybd.49.1300116024225; Mon,
 14 Mar 2011 08:20:24 -0700 (PDT)
Received: by 10.151.11.12 with HTTP; Mon, 14 Mar 2011 08:19:39 -0700 (PDT)
In-Reply-To: <op.vsb95dilbl4hj1@metalltrottel.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168991>

Heya,

On Mon, Mar 14, 2011 at 16:18, Franz Liedke <franz@develophp.org> wrote:
> "git status" and "git branch" both tell me I'm on my feature branch.

And that one _is_ updating?

> .git/packed-refs and .git/info/refs are both not updated.

That's fine, don't worry about those.

-- 
Cheers,

Sverre Rabbelier
