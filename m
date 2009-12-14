From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: strange error while pushing
Date: Mon, 14 Dec 2009 01:01:33 +0100
Message-ID: <fabb9a1e0912131601q71dcb4c4h2fafa03df14be3c1@mail.gmail.com>
References: <40aa078e0912131441i370d9c23r65c42fe1f46bd194@mail.gmail.com> 
	<20091213230214.GA27365@sigill.intra.peff.net> <40aa078e0912131508y79815bej6290c0848aa9f9cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Dec 14 01:02:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJyOW-0003pb-9G
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 01:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234AbZLNAB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2009 19:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbZLNAB4
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 19:01:56 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:46438 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365AbZLNABx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2009 19:01:53 -0500
Received: by vws30 with SMTP id 30so479179vws.33
        for <git@vger.kernel.org>; Sun, 13 Dec 2009 16:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=XfbWzsSzVo5afWOfzWgfnTyW2gJE2NHBD1y1gHWPNi8=;
        b=FAbb/665KQ/O/TmgipUuluVw4zEtceHS6U8CmvSiK3tj1lCgNJkciY8ChQkPZ10lYt
         XgfoNWcG+b3DSyJO+EtPUf1GAOvgf+QfJwEG9vHf5Z6Zh7rN2vUo3nVK6/g7ZOh1vSCo
         61lA0FVYV6jFRnBThwGKlrraA8/63r3V2ZHtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=V0NkMSSuW85JjxKqeWKxGbLIxTeiimZnt1Wr0tdJQxia38EE0zeBerdV0yoxAmaY2Q
         NU/ujgJhi6CbklCSx1MLqt9UPv+F0ZTW5HDIoGORG78JUqzussvnkjfxr+cywEf+Du94
         oGdylydsuqUV+37w0kaYrypfJeq8ObtbwWwpM=
Received: by 10.220.65.200 with SMTP id k8mr745753vci.56.1260748913067; Sun, 
	13 Dec 2009 16:01:53 -0800 (PST)
In-Reply-To: <40aa078e0912131508y79815bej6290c0848aa9f9cf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135162>

Heya,

On Mon, Dec 14, 2009 at 00:08, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> Simple, I was pushing git from a
> directory with a recent git-binary, when my *installed* git was v1.6.4

Isn't this the reason most people don't have "." in their PATH? :P


-- 
Cheers,

Sverre Rabbelier
