From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #01; Sun, 1)
Date: Tue, 3 May 2011 00:32:32 +0200
Message-ID: <BANLkTikFK9k=7hGB8AJ4mz88sff=roXd5g@mail.gmail.com>
References: <7vd3k2q8lt.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 00:33:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH1fm-0004yD-8L
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 00:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055Ab1EBWcx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 18:32:53 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53121 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab1EBWcw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 18:32:52 -0400
Received: by pwi15 with SMTP id 15so2863985pwi.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KGZTaO+xpLNVb50s/yjgOL/Cmho68RV8oJ4AVAqf+2o=;
        b=Eh1UM382+3CIRpIaIFj4UYmh1hS6MyE7u2iZGSiYrxs/1OUbYiI7mCz4WRTtd21/ce
         Z92mmN8vS/hRSScUuQD5ZKh/PM8UD48FdKpzC/g57Jz/0MQHb1fd4TvNWL2yOo2P04jo
         jUMwx/K8J9276opARMtKTtvvCA7g3Qhqb/UX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=euc4o//cGPaWz/nWF57nNdwMWuxfcRaoN7qcv8DPwCMxONYkv75EOoZAzXHRZJhdNL
         CLQHqsogcd5SixYA38DqZ9LAE12Z8lmT0zc0HFRH/ZppKVYU8Uik9NV5dCb6qdxbNo/6
         KnioCe46bSdO/p7RaZYvfJk5IiSdUeQufA5oc=
Received: by 10.68.60.104 with SMTP id g8mr1327937pbr.47.1304375572067; Mon,
 02 May 2011 15:32:52 -0700 (PDT)
Received: by 10.68.66.98 with HTTP; Mon, 2 May 2011 15:32:32 -0700 (PDT)
In-Reply-To: <7vd3k2q8lt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172636>

On Mon, May 2, 2011 at 1:55 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> * kk/maint-prefix-in-config-mak (2011-04-28) 1 commit
> =A0- Honor $(prefix) set in config.mak* when defining ETC_GIT* and sy=
sconfdir
>
> Wait for msysgit folks to Ack, and then merge to "next".

This patch works fine for me in msysGit.
