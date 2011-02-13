From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/4] clean-up store_updated_refs
Date: Sun, 13 Feb 2011 01:09:12 +0100
Message-ID: <AANLkTi=k9z67zmG6qBCh2uQWiofNceqs2erZ74XQARYq@mail.gmail.com>
References: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Vasyl' Vavrychuk" <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 01:10:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoPXL-0001zo-O4
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 01:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab1BMAJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 19:09:56 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54037 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab1BMAJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 19:09:54 -0500
Received: by gxk9 with SMTP id 9so1593314gxk.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 16:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=d6t2Cu0mXX2JZIiYFnJi67Sc/XAd8lKqWroqVyIunL4=;
        b=pgRg9/azaAg+lVA3b6/3SyHhgpvG2XqKABbHAJW4l+njl/0sL9hY+Ln7KCzBdZTxne
         S6yWQlnYGgA37NO6NKpkxsKqOxQ6+ISCEdjUqd4vV9ejk60DJsHMjiDAfZbd1Vbhc/DT
         tkm2JJtTKQdQeWd89R/LySQK+Is1i5dZKp+l4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=b0CuhAUa01XIGgbXPNdD60s8ogsCGOED1AoulC+DjPBJRXzIBieQDeoemCPJ4LYOAz
         iFqwdOMPckWeItTHeA6+7hQV5PG3Qn1EvLL0oInSoFivrH1cc0YMmZMJpM96/tR5galZ
         k+oa6ZG8UYFdE0jTEEuu7FocXouf49/wCm0Ww=
Received: by 10.151.79.13 with SMTP id g13mr2591436ybl.51.1297555793564; Sat,
 12 Feb 2011 16:09:53 -0800 (PST)
Received: by 10.151.158.10 with HTTP; Sat, 12 Feb 2011 16:09:12 -0800 (PST)
In-Reply-To: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166634>

Heya,

On Sat, Feb 12, 2011 at 23:38, Vasyl' Vavrychuk <vvavrychuk@gmail.com> wrote:
> Vasyl' Vavrychuk (4):

Neither the patches, nor this cover letter explain _why_ this is being
done. Motivation needed :).

-- 
Cheers,

Sverre Rabbelier
