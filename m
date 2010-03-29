From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH] Write new giturl(7) manpage
Date: Tue, 30 Mar 2010 00:54:23 +0530
Message-ID: <f3271551003291224s7fb0d8d3sce75b7c893fabfa8@mail.gmail.com>
References: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com> 
	<20100329191832.GA26842@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 21:24:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwKZu-0001Kg-4h
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 21:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab0C2TYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 15:24:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65268 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab0C2TYo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 15:24:44 -0400
Received: by gyg13 with SMTP id 13so1654062gyg.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dP6X46kxFRHhWabyGeS8F5HUraqpsClUSh3CLaeUHNo=;
        b=UVyBHR52cvzgVVslgStS8r3B1RaxIXsoPVLNkWaDttUlliKnfbRRm2ZSPxnO2twKOP
         PJGG7L/FL52kQ7FBikpdjxF7CM3tcIxsXPtg1H1oCVthQ7OCgnNIyzsEmrdaQaaic+dj
         XsKJvXsnfTs0yjre108tUwQXSwUSEvzGNQVb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CtEXTrTqrnMJ+4CwYgTJ1vPkM0Kr2iPnPEgkxjyJeCgbxSq1cqdqTZp1mRKelwCWQS
         S9wosdHNPu3oJFJbeWZ02zzm90i93OKf3pUOmJ4s8GWkeFP1wQaBdXX+maH/gkUXwQ/N
         e7klYOIxQwUfQG1vtzCWx80VH+JABrodERYwk=
Received: by 10.90.69.14 with HTTP; Mon, 29 Mar 2010 12:24:23 -0700 (PDT)
In-Reply-To: <20100329191832.GA26842@progeny.tock>
Received: by 10.90.59.28 with SMTP id h28mr4812609aga.85.1269890683269; Mon, 
	29 Mar 2010 12:24:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143510>

On Tue, Mar 30, 2010 at 12:48 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> I suppose you are right. =A0I was imagining something like this:

Your patch looks awesome. It looks like I didn't have the right idea.
I'll drop this patch- you can write one.

-- Ram
