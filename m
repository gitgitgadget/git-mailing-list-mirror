From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: fix Gmail workaround
 advice
Date: Sun, 7 Feb 2010 16:16:45 -0600
Message-ID: <20100207221645.GA2862@progeny.tock>
References: <1265555642-40204-1-git-send-email-git@aaroncrane.co.uk>
 <7v8wb4gaef.fsf@alter.siamese.dyndns.org>
 <bc341e101002071203x52bceaach8d42c6188630f1d1@mail.gmail.com>
 <20100207215311.GA2177@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Preston-Werner <tom@github.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	John Tapsell <johnflux@gmail.com>
To: Aaron Crane <git@aaroncrane.co.uk>
X-From: git-owner@vger.kernel.org Sun Feb 07 23:16:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeFR2-000455-Mm
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 23:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397Ab0BGWQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 17:16:51 -0500
Received: from mail-iw0-f183.google.com ([209.85.223.183]:57907 "EHLO
	mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592Ab0BGWQu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 17:16:50 -0500
Received: by iwn13 with SMTP id 13so4219358iwn.25
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 14:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sE0k7bLMbs4muQwU0ioob1vKemrNQKkc58eGYMykS9E=;
        b=bAmjJoUs5vi+ud27lEvdp6dYcax/LEZsJL65sSSWWkKfteRh5Vqa2WdPcYNeD/82a1
         hT2gchh/h1LhumsXM8KaYgzsCPuSp/tLKnmkJWU+05WETyFTYGoOO+9fz9zLJATYyE39
         +lH+drF/Pj1lf8HBdW/JmFCVsA8JaZmg+ugCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ie4Za9fo+kskG00GvAn1lOZuAhv5VnKcC1mS+OHl4zwyiQYjwZHY4KB3IbGZrfw7JT
         kHH6CdouLjLGHTRdrLXuG1RZQgqQCnW/g1u6WpcDWTFvFqcjrHJsw1D74tKqTMqN7+bT
         jozR15aCzMeytGa6hj4Jo5y0ZsVgEi1EFWuSw=
Received: by 10.231.154.207 with SMTP id p15mr816905ibw.91.1265581010358;
        Sun, 07 Feb 2010 14:16:50 -0800 (PST)
Received: from progeny.tock (wireless-205-208-124-228.uchicago.edu [205.208.124.228])
        by mx.google.com with ESMTPS id 20sm3797614iwn.1.2010.02.07.14.16.49
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 14:16:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100207215311.GA2177@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139260>

Jonathan Nieder wrote:
> Aaron Crane wrote:

>> As far as I can determine, the current imap-send suggestion is
>> fundamentally unworkable with gmail at the moment.  I don't know
>> whether it ever used to work, though I've been assuming that it did.
>
> I think it still works, or depending on your perspective, it never did.

Scratch that: it looks like it once did.

http://thread.gmane.org/gmane.comp.version-control.git/99721/focus=99775

Tom, any clues?  Are you still able to avoid spurious line wrapping in
gmail?

Jonathan
