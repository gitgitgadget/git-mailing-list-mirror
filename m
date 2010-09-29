From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Splitting the mailing list up
Date: Wed, 29 Sep 2010 17:02:34 +0200
Message-ID: <AANLkTim2Zrj+VUirUL+cyfFnHRw6L9TST-p01yx1rtZS@mail.gmail.com>
References: <20100925230022.6e2fd389.coolzone@it.dk> <4CA1899F.2020509@cadifra.com>
 <141CAFB5-D423-48FE-BEED-B755C5F2685B@sb.org> <4CA2FA76.6080501@cadifra.com>
 <4CA30201.5020006@drmicha.warpmail.net> <AANLkTimPdqM_29Aru7tAGp_REem+BYAuE8o-U-qkhS6T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Adrian Buehlmann <adrian@cadifra.com>,
	Kevin Ballard <kevin@sb.org>, Rico Secada <coolzone@it.dk>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 29 17:03:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0yBo-0003aC-2o
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 17:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056Ab0I2PDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 11:03:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35900 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab0I2PDT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 11:03:19 -0400
Received: by iwn5 with SMTP id 5so1128964iwn.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=mwvUGAaL6SLYCZGqlNTN26CSXOVSbfdsE2onDy3YFNA=;
        b=tWsYZzAJXRfT0++S2jXZSVPVvickK90ImeclLIPEMDaiQPflC9Fd2D4tgq1lBz8QeF
         DYLqRi+g+aAHDn2rdbgjN3IqapgLLytzDEHad4UTI+ldRS3+aCpqS5JWRx9ZVy6b8k7C
         0mn0dyl6QzMvViO6z0ec9k9YC7klTEto64D00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sbfqkwXGQQRsnpeAtDGdYEg1r7sMsYjjQZd65sa6gTRW+CrHQx8XdxBDGpEEgL9Jrm
         ocZOuCHIctQePjUiCdfZWosuJBhVDvnHvrO5WuPd3vLB+1vPTXv+5cb1IbL2pQC6yWv+
         pQGRV6rOwPi/S+uev8nAlrYL6Mq/Skk42mBG0=
Received: by 10.231.169.149 with SMTP id z21mr1985038iby.11.1285772597819;
 Wed, 29 Sep 2010 08:03:17 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Wed, 29 Sep 2010 08:02:34 -0700 (PDT)
In-Reply-To: <AANLkTimPdqM_29Aru7tAGp_REem+BYAuE8o-U-qkhS6T@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157575>

Heya,

On Wed, Sep 29, 2010 at 15:00, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> http://groups.google.com/group/git-users says "This is the git mailing
> list for users, feel free to ask any question about git usage.", so
> yes. I think we already have that list. Perhaps all we need to do is
> to add a link to it on the front-page of git-scm.com, next to the link
> to this? Perhaps something like "You can also ask the Git development
> community directly at our git@vger.kernel.org mailing list, or the Git
> user community at git-users@googlegroups.com"?
>
> That would imply making it a bit more official, but perhaps it's a
> good compromise?

Perhaps we can just at 'git@vger.kernel.org' as one of the list users,
so that all mails sent to git-users@googlegroups.com are forwarded to
the git list? As long as the git-users group is open to all, that
should Just Work, no?

-- 
Cheers,

Sverre Rabbelier
