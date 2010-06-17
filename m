From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #02; Wed, 16)
Date: Thu, 17 Jun 2010 11:35:40 +0000
Message-ID: <AANLkTikBRw6gMpfuCxWwYCx3QQin-v86p8AuliMf8B8F@mail.gmail.com>
References: <7viq5ict4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 13:37:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPDPE-0003Eu-5p
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 13:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab0FQLfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 07:35:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39295 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab0FQLfm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 07:35:42 -0400
Received: by iwn9 with SMTP id 9so6681264iwn.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Fcgb+u6nNrFBVckCaeUPV6dMOJ+WXddz98FSYlP9Wig=;
        b=aFHa2M8wIlsTUTEjWXxfHysCE3tHgo7G+tL/aKT6595ZE+DEsS81RjVPRmqI3o8EU1
         nldSb6hVvMMPq/FeqLGJ08Ys22pD4+vZTurYnmIvYCtr0Qx/vx8bWmWYdvjoiDDGN4aC
         aIk5epNpeU+1hRBGoDXfLRITAMQZklURM9NPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VEjspWLB/YuB8r3vXhXgekOJLjYYEnouA6bkiSvfOe0P/iWtvSPfdX/4mtvgROKZ6G
         D8rxaMoUrhh6tPmMRricDHBIlCvyk2knv0CQ3s+pdDQEvNVOqmoES72XFwIuvS4KFqjh
         80DMpU5Rj90wgLSzlzsVPullcFI3ZHjLjQvDk=
Received: by 10.42.1.69 with SMTP id 5mr3645520icf.42.1276774540366; Thu, 17 
	Jun 2010 04:35:40 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Thu, 17 Jun 2010 04:35:40 -0700 (PDT)
In-Reply-To: <7viq5ict4p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149300>

On Thu, Jun 17, 2010 at 02:03, Junio C Hamano <gitster@pobox.com> wrote:

> [New Topics]
> * ab/blame-textconv (2010-06-07) 3 commits
> [...]
> * ab/i18n (2010-06-15) 3 commits
> [...]
> * ab/tap (2010-06-09) 4 commits

Confusing, can I maybe ae/ or aab/ so I don't have a namespace clash
with Axel Bonnet?

Mainly so that my automagic mailbox search of "What's cooking in
git.git" + ab/ works, ignore it if it's non-trivial.
