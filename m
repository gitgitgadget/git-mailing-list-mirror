From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] git-gui: update Italian translation
Date: Wed, 10 Oct 2007 16:22:02 +0200
Message-ID: <4d8e3fd30710100722m650d4bb0yf76869ae6f8944df@mail.gmail.com>
References: <200710101533.17290.barra_cuda@katamail.com>
	 <4d8e3fd30710100641p6fc6f610g435d2fe66462c05b@mail.gmail.com>
	 <200710101607.55452.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Michele Ballabio" <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 16:23:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfcSl-0004VT-Gz
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 16:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbXJJOWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 10:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbXJJOWH
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 10:22:07 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:39529 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbXJJOWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 10:22:04 -0400
Received: by an-out-0708.google.com with SMTP id d31so11601and
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RYP89vPWBnVx9t/sYRsyx8/0IZd9+b6GzHurk10+OaA=;
        b=sYWU4TF1viuw69PPwUYsYAtYhA8UI6GDRduqRKCCPvZEZYl8qANLuW6BGwIhpoUuSdPP0YuycAS7R2ZjREK6N6naMT3eqZGpxcy2Nrkq9F6DpqYvRGltMYXVQG1AZ+pI6JOZQgN+XC6Y3LNPaA6gR6wHihmrKR8FZscmMSTM0P8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y57T7eXc8fW6ztKSCHum8pOOskMEQ04/v7Jyhp7/oOhEfsNEPGtB5U2H2YSO4laMwgtEyC6NCNQfUVtT0+FtrdSFtcU2TPE3Ci7bI6BF8LiGwDgpCUCH9eInvCEL0XwQiOWBDrfnjJYAvjLwtuwW8kfZHq6XKIv6ZvL65aSkFgs=
Received: by 10.142.242.8 with SMTP id p8mr123025wfh.1192026122272;
        Wed, 10 Oct 2007 07:22:02 -0700 (PDT)
Received: by 10.143.43.21 with HTTP; Wed, 10 Oct 2007 07:22:02 -0700 (PDT)
In-Reply-To: <200710101607.55452.barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60500>

On 10/10/07, Michele Ballabio <barra_cuda@katamail.com> wrote:
> On Wednesday 10 October 2007, Paolo Ciarrocchi wrote:
> > > #: git-gui.sh:1527
> > > msgid "Modified, not staged"
> > > -msgstr "Modificato, non pronto per il commit"
> > > +msgstr "Modificato, non preparato per l'archiviazione"
> >
> > I vote for leaving the word commit.
> > I would be confused by the word "archiviazione".
>
> Well, yes, most people currently using git will be as well.
> But that's because they're used to it. The thread that talked
> about the German translation decided to look for a fitting
> German word, so I decided to follow them. If you're vetoing
> these changes, I'll redo them. Otherwise, if you don't have
> a strong adverse opinion, I think this translation is quite
> clear, and would leave less people asking
> "What's a commit?". Don't you think?

I understand that we should aim for a complete Italian translation but
"archiviazione" to me sounds like "backup" or "archive".  It doesn't
sound  like a proper translation.

I discussed this topic on the Linux Translation Project mailing list
and the majority of the people seems to agree on leaving the word
untraslated but I really cannot say that I reached a _real_ agreement.

In short, I'm still think we should leave the word untranslated.

How about posting the new file to ltp and move there the discussion?

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://ubuntista.blogspot.com
