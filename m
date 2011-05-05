From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-svn and a new svn remote helper
Date: Thu, 5 May 2011 22:33:19 +0200
Message-ID: <BANLkTi=-awfPDNivaKT3EkC638_U2cQtRA@mail.gmail.com>
References: <1303138000-27807-1-git-send-email-stsp@stsp.name>
 <vpqhb9vplu4.fsf@bauges.imag.fr> <7v39lfa1h5.fsf@alter.siamese.dyndns.org>
 <20110419093108.GA7440@ted.stsp.name> <4DAD6FC4.6060004@drmicha.warpmail.net>
 <20110419120031.GE4134@ted.stsp.name> <4DAD7EFB.2050507@drmicha.warpmail.net>
 <BANLkTimJa5EDxXerwgZP7viLFPQRc=39uQ@mail.gmail.com> <loom.20110505T211005-593@post.gmane.org>
 <BANLkTikAtgunYTax5d4oEDAot83wOROmhw@mail.gmail.com> <BANLkTimZ6P=b6KHnj2+re5zke4Ds1012Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthew Daniel <mdaniel@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:34:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI5FN-00078h-R0
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab1EEUeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 16:34:00 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54350 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab1EEUd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 16:33:59 -0400
Received: by qyg14 with SMTP id 14so1978806qyg.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Px2fCyLcS1anXeOusMJ/jfcC3V3lmkYbGkk4VHPJPVI=;
        b=gxD+XymEqoorkYVL1GeqaQZsoSYArb1x6GJHhn8gZ/TZFCuKjyr95jhQoNKcDrieQe
         LE04icRBNFBHXZfoJRMtFMFnB8gWPE4k+ya3DLhMFSmKhN7q1NaGa3Cbdl37sjNNPuJD
         zBisWr7hUYILjm7d507Oz5Ez+WqnDi15FWKZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hK5m8hTX6e++ljH1gtJGXlRFvgsT7ZSiMA04HqgB9F+RFE5Dg/C0CnI2igpu1Tj8JD
         C95ATCMilm4AC1+ODbs8Av2WXHnPx0gSxEoQIVVN6Peo/rCVReJ4GHJxpDT749NDzpVm
         7zmSjE4fEl54zoFcCZLQqHOxEXmgYvjUIggYo=
Received: by 10.229.20.83 with SMTP id e19mr1961303qcb.288.1304627639124; Thu,
 05 May 2011 13:33:59 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Thu, 5 May 2011 13:33:19 -0700 (PDT)
In-Reply-To: <BANLkTimZ6P=b6KHnj2+re5zke4Ds1012Eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172909>

Heya,

On Thu, May 5, 2011 at 22:32, Matthew Daniel <mdaniel@gmail.com> wrote:
> The link wasn't very informative; is this work scheduled to happen in
> public, e.g. on a git branch perhaps?

Hopefully he will update his project information soon :).

> Has Dmitry submitted the GSoC design document yet?

No, I haven't seen him on the list yet.

-- 
Cheers,

Sverre Rabbelier
