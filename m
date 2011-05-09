From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: Qgit should use "git config" instead of "git repo-config"
Date: Mon, 9 May 2011 18:36:53 -0300
Message-ID: <BANLkTikoViHF-AzfNwKkaYxsWhzvtRpvyw@mail.gmail.com>
References: <4DC85AA7.2090502@socialserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Rogers <jrogers@socialserve.com>
X-From: git-owner@vger.kernel.org Mon May 09 23:36:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJY8R-0000tQ-2B
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 23:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368Ab1EIVgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 17:36:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40006 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab1EIVgx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 17:36:53 -0400
Received: by iwn34 with SMTP id 34so4690152iwn.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uZBZqC/ypWaX5s7iGmWxRJisVyvrAChPxKm6FSMynv8=;
        b=Dgu+94MLc0tE8s3SlDRIxf4+k0sPipSo8paI0kSd30TT2b6zgQWUnWDdfCzNcXn6kF
         0MAQmsbrOeiHKvM62NyCmwFKstXO0IqW0620ctJilPDyON629AaAauRjt9707rJaabdU
         rI8FJnR2Aev63V4oKBzhWT3+Qay1eblV8hdS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=q62htHDBSNg9SxKxKdRCnqWfA1gNAJ8HSUrN14UHYYNWFPDY3M0CfCY/rKj+8pR5eq
         musaft87GRRkxlKuO96we4MavC4z6mtTNkT37JVxnlNn/IJ3PWbevnyEW/f/IhAFGClX
         F1ef/6aqnICtIf6YHU61HTtT6HEH6gl9TKlD4=
Received: by 10.42.152.195 with SMTP id j3mr3264576icw.514.1304977013308; Mon,
 09 May 2011 14:36:53 -0700 (PDT)
Received: by 10.42.170.132 with HTTP; Mon, 9 May 2011 14:36:53 -0700 (PDT)
In-Reply-To: <4DC85AA7.2090502@socialserve.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173254>

On Mon, May 9, 2011 at 6:20 PM, Jonathan Rogers <jrogers@socialserve.com> wrote:
> Here's a small patch to cause qgit to use "git config" instead of "git
> repo-config" in a couple of places.
>
Please, read Documentation/SubmittingPatches for a guide about how to
submit a patch to this list.

Thanks,

Best regards!

> --
> Jonathan Ross Rogers
>
>
>
