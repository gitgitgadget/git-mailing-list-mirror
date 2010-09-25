From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Splitting the mailing list up
Date: Sat, 25 Sep 2010 21:05:12 +0000
Message-ID: <AANLkTikHNhRTTvcpj_30fUBbxv8-qG9HfTTO+XkLJgam@mail.gmail.com>
References: <20100925230022.6e2fd389.coolzone@it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Rico Secada <coolzone@it.dk>
X-From: git-owner@vger.kernel.org Sat Sep 25 23:05:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozbvs-0008Tl-6R
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 23:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929Ab0IYVFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 17:05:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58290 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab0IYVFN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 17:05:13 -0400
Received: by iwn5 with SMTP id 5so3460033iwn.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=96k2Ka/Cmb8Pk28FCra2QO6cOgdtRBFgDdrVjSV0JeI=;
        b=D0sSlbn9OnDqfw3iTlkc+h35C1JK7sBhBIWqXsF+wiQ7BQnMAr4JEPtGCsx/HTvktx
         hdRygUI6rJNWqiFty1Uhsl8GyI0tVjz1rFRZt0kiYRRn0r9UYDKVX6PURMqbahDO0CsI
         zvKb8SDG5p8piNM+Ufx7prb7bTWRHvTLKMPd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DGTcQnhqTE8iBaDRFmjve0jFcUh0moybQCynAGJDegqdGq8BVDhNoAvYOnRcQUoJJS
         C57BnNkGHirBfQdQMF7rD2Z7qWb4WcvjzwiByHNwScKezFRmrrgP++FPGlZwsH/7ZOW1
         x4nlMAY06GRYt5T30IUZnpvBG5OdUQxR9qZyQ=
Received: by 10.231.14.72 with SMTP id f8mr1985141iba.171.1285448713007; Sat,
 25 Sep 2010 14:05:13 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 25 Sep 2010 14:05:12 -0700 (PDT)
In-Reply-To: <20100925230022.6e2fd389.coolzone@it.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157202>

On Sat, Sep 25, 2010 at 21:00, Rico Secada <coolzone@it.dk> wrote:
> The list receives a lot of traffic and it might be beneficial to split
> things up.

Why is a lot of traffic a bad thing?

E.g. if you don't want all the patch submissions you can just filter out PATCH.
