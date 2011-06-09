From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git-Mediawiki: Future of the project
Date: Thu, 9 Jun 2011 16:44:58 +0200
Message-ID: <BANLkTimeRhE=gBmjD++CYT9=ycRtO59dMA@mail.gmail.com>
References: <BANLkTimViRhN+mDWpHRbcFLs=DDgXU+EMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sylvain Boulme <sylvain.boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Claire Fousse <Claire.Fousse@ensimag.imag.fr>,
	=?UTF-8?B?SsOpcsOpbWllIE5pa2Flcw==?= 
	<Jeremie.Nikaes@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 16:45:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUgUd-0003pP-71
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 16:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab1FIOpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 10:45:44 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47811 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab1FIOpm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 10:45:42 -0400
Received: by qyk7 with SMTP id 7so2519374qyk.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=lvlZtVLayQ6axTwGoGWrFyRTR+K79sZZcs8L/xJkBEc=;
        b=UlJns5qkLES9jH5Dz3pQrQPIZTBuhbj6Lw1WtdXz+/sE/Jf0d3iwP687zXQPZbsZTa
         fiJkyiF5GizNK9EBuxdvblhbRO8EjIjnCJoQbrXTAnFvi0vRT7iCPxRPfzkxq1tGDaeV
         YcHznvTYltF3ohMDtjLG2ybyIBBnoB0Qb9NeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TrOcjj4HDilvlwVHW2icyvJnAQCgPT4VfcnWSU5rxum9FpdlKU2GqeY0LZSStRBNKr
         uhYVkTRecu+Kc0iVo0qMC6whdawPsVuzByO7+WD+guHW9YGiMPIFhisfp9A8ChCqerLC
         5JgdaeJTMUk8YYlbnn+8QXTmkTL04x2pbftUU=
Received: by 10.229.135.12 with SMTP id l12mr657855qct.53.1307630741518; Thu,
 09 Jun 2011 07:45:41 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Thu, 9 Jun 2011 07:44:58 -0700 (PDT)
In-Reply-To: <BANLkTimViRhN+mDWpHRbcFLs=DDgXU+EMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175529>

Heya,

2011/6/9 Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>:
> First of all, thank you very much for the help provided and the
> interest shown on it.

Likewise, thank you for reviving the remote-helper discussion. It's
been stuck for over half a year, and I don't think it would have
gotten unstuck on it's own :).

-- 
Cheers,

Sverre Rabbelier
