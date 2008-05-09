From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: [offtopic] mail greylisting [was Re: mismatch between doc and program in git commit -u (--untracked-files)
Date: Fri, 9 May 2008 23:03:20 +0530
Message-ID: <2e24e5b90805091033g71ba5ed1g546417f4e65f5c72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 19:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuWU0-0003oe-9r
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 19:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760919AbYEIRdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 13:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760006AbYEIRdX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 13:33:23 -0400
Received: from ti-out-0910.google.com ([209.85.142.186]:9264 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbYEIRdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 13:33:22 -0400
Received: by ti-out-0910.google.com with SMTP id b6so494502tic.23
        for <git@vger.kernel.org>; Fri, 09 May 2008 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=OKX4lEepcVIahWv4SkE4MDAovLgD9u88McZQlLZuZs0=;
        b=x84kBiAw8YALPrzatVhbnUajGM8aig3f2wyOghabO7HDaaHvj3WVnvUKobg4cAdJ+Om1CgnuWRY1kZTk8ABbEb6l56W7ka7tjcq56KijB7BmWXgV9sJjPRzZHQ9MJ2LhBJx8bShc6xLiUxxIRVHXP6i+pZjb5rl/5PExVqPnuTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mfsG/uX8BzmZUwyVgANgML6JzfKrY8CmS8uh1m09XFP0RAb9PqHeqDTgNE/qXXUugFAhYtsC9cqjK5m2Tfx3Mp+VJJCU+NDvxoPlceTtTE+lYCEaV958N0u2M/H7oVhZrF/s+07FN+nbbCOY6CndklRWqchusTENPddU99vL59Y=
Received: by 10.110.84.2 with SMTP id h2mr460277tib.47.1210354400784;
        Fri, 09 May 2008 10:33:20 -0700 (PDT)
Received: by 10.110.105.1 with HTTP; Fri, 9 May 2008 10:33:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81628>

On Fri, May 9, 2008 at 10:56 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> sitaramc@gmail.com" from my home machine, and vger's SMTP listener
> decided to greylist the mail.
>
> It'll come through eventually, assuming I keep my laptop switched on

Amazing.  It went through and my maillog says:

May  9 22:55:30 sita-lt postfix/smtp[31182]: 6257E406A1:
to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
delay=752, delays=749/0.01/1.4/1.7, dsn=2.7.1, status=sent (250 2.7.1
Looks like Linux source DIFF email.. BF:<H 1.60047e-08>;
S1764761AbYEIRZ3)

I'd love to know how they did that "looks like Linux source diff
email" thing... pretty cool!

[sorry for the off-topic stuff]
