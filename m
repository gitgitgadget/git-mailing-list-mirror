From: Jean Privat <jean@pryen.org>
Subject: Re: [PATCH v2] new --dirty option for git describe
Date: Tue, 20 Oct 2009 10:31:45 -0400
Message-ID: <dffdbd190910200731w5b49f329g5005539f875901e1@mail.gmail.com>
References: <1255800990-7806-1-git-send-email-jean@pryen.org> 
	<dffdbd190910200727r30e161ffka0b3cf764be26cd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 16:32:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Fky-0006aY-O2
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 16:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbZJTOcC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 10:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbZJTOcB
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 10:32:01 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:45711 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbZJTOcA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 10:32:00 -0400
Received: by pzk26 with SMTP id 26so4128031pzk.4
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=myvpkZ4x7HhDPiDsnOxX08tR6F/dfdJUsXCLORxWLeE=;
        b=bXlxJP72FfZMZJOSqE1tEfbn9HpSBmk9Ralp6hZltmvCQrP9yQy4wt41Hw0AzFE1ZO
         HOL0KTOpEfX5IiuJx0cVSVHrvIvxejkTvuGmktAHhUSpJAPcCPZdQ79K1vDJwflRcEN3
         /ZAw16yRE3lkc1eD83yF7CcmU0Z/mfWv1EI5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=gGFCHx/w2RNF4TitIOC2jXAd58hVneRzSMc9WNeoQiAWzPPNTakRBVv//+yomBBxuH
         DyJ33i9r15IR7OWyCfWjwiPCyFsHNL1xoRfFMDd/ZbWrBoXEGDdiI+97Ifj2YEFNLBM2
         nRtZISBH6NiGXkI9jJFlQJEolvNmRJ2F0wXQ8=
Received: by 10.140.134.17 with SMTP id h17mr1609348rvd.282.1256049125467; 
	Tue, 20 Oct 2009 07:32:05 -0700 (PDT)
In-Reply-To: <dffdbd190910200727r30e161ffka0b3cf764be26cd8@mail.gmail.com>
X-Google-Sender-Auth: 67c50c2edd1a07c4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130796>

> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -9,6 +9,7 @@ git-describe - Show the most recent tag that is
> reachable from a commit

%#$@!&&@ !!!

I followed instructions from Documentation/SubmittingPatches about
sending patches trought gmail imap, it did not seem to work.
I will resend with git-send-email (and try on something else that
git@vger.kernel.org)

Sorry for that.

-J
