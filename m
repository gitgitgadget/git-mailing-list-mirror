From: John Tapsell <johnflux@gmail.com>
Subject: Re: Implicit stashes
Date: Wed, 30 Jun 2010 12:05:50 +0900
Message-ID: <AANLkTimOTBzN7lnniImy2eqoBh775X9NbzIwcetS1GHh@mail.gmail.com>
References: <AANLkTilTaQP6qARY1A495vm9HAvLVX_lqIQd1l3WIv7a@mail.gmail.com>
	<4C2AB260.8020108@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 30 05:07:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTne1-00064U-Oc
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 05:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab0F3DFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 23:05:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53754 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629Ab0F3DFu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 23:05:50 -0400
Received: by iwn7 with SMTP id 7so384396iwn.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 20:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=5fcBNZV2w/nfWo0N4gSOv/50cOBKMPRN+7LZo7shlGw=;
        b=YcWS/ZEEmn9Uui+7+UYIh8f9JJldbwX5r5AFoImU2HSdhkZxuO5qRrGJfUJZS+pIW9
         nJ5GTDd2xdkQcQxtjbMTQ+WDNG2ajZJ7iRbnjllFen2ONGZ0GWrCPAC2pNRbEzI6v9Nh
         eLTCGnPpvub0F6guDSiAy7U4XGjRKCo5K7h/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Z1j6gs1WZLp8IiEfYVWz2iWo4x9u0tlHKrITuMkR8KaKjH3tiUs36H0orvPIAH1ujL
         6nfvxH03PPF5SBBNeZyx84YFmUYYIPXjSGbh3KIb2LB/Lj3+A+VAP1aLQUb1QQF3ZGwU
         CdoE9hAbruHr+fHhoobOCleqEIgud3vwu3NGc=
Received: by 10.231.47.71 with SMTP id m7mr7052825ibf.154.1277867150259; Tue, 
	29 Jun 2010 20:05:50 -0700 (PDT)
Received: by 10.231.182.146 with HTTP; Tue, 29 Jun 2010 20:05:50 -0700 (PDT)
In-Reply-To: <4C2AB260.8020108@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149943>

On 30 June 2010 11:56, Joshua Jensen <jjensen@workspacewhiz.com> wrote:
> =C2=A0----- Original Message -----
> From: John Tapsell
> Date: 6/29/2010 8:48 PM
>>
>> =C2=A0 I was thinking that it would be nice if everything was undoab=
le in
>> git. =C2=A0Currently there are some easily typed by irreversible com=
mands
>> that I keep seeing people doing.
>> <snip>
> See this thread: http://kerneltrap.org/mailarchive/git/2009/5/20/2915

Doh.

It seems that everyone agreed in principle, but that the details are
tricky and it needs someone to actually do it.

I can't do it myself, but I'll give $50 to someone to get this going
and do this :)  (I know that is an insultingly low amount, sorry)

John
