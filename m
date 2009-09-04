From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
	case
Date: Fri, 4 Sep 2009 19:52:38 +0200
Message-ID: <fabb9a1e0909041052qbbb5558w6da72b46969135f4@mail.gmail.com>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org> 
	<fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com> 
	<alpine.LNX.2.00.0909041114440.28290@iabervon.org> <7vy6ouk4io.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 19:53:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjcyE-000339-4G
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 19:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170AbZIDRw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 13:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757169AbZIDRw5
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 13:52:57 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:43534 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757151AbZIDRw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 13:52:56 -0400
Received: by ey-out-2122.google.com with SMTP id 25so625174eya.19
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 10:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=xStmMpubh3jJOV1iB9/115soBcxhW+Gbwk1eAWLvLbU=;
        b=dGFajICbne0kGPj+V55VJzM5zb4R4z/uOTXaQ9tIwV0a/Pmnb15UiNZf7X48TPgBIA
         YT3BNAQckEZMRsu8hkMQ2B9C/FLvU1QDOq5i22jiq7hPAh7hDvY4fiEAooflU/3b4plI
         ef37k6DRU93ZfjNo/AMXxxvQy35JvN4+W87Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=F2oouWQ7gIXMxyazE7JY8wEQjXcF2i62m1D1Ut6kfnNwWU/hzL1JJgRYS4d/r//jOa
         hdXxsgYlR1tI4Lfe8S7sP9mV9WmzReLWxFDGIz4SPz6Iuu+cHJCXVSzjX9g2iDVN0YB/
         IFjDLYDS4Qs4FLuj5vuZLDKSoH/45o0gCos3M=
Received: by 10.216.54.207 with SMTP id i57mr976484wec.114.1252086778106; Fri, 
	04 Sep 2009 10:52:58 -0700 (PDT)
In-Reply-To: <7vy6ouk4io.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127752>

Heya,

On Fri, Sep 4, 2009 at 19:23, Junio C Hamano<gitster@pobox.com> wrote:
> In short, from where I sit, I do not see much disagreement in the
> semantics and in the future direction between what Dscho is saying (unless
> I again misunderstood what he said) and what this round wants to bring.

I think Dscho's main worry matches what I asked about earlier, will we
be able to say "hg://example.org" or not.

-- 
Cheers,

Sverre Rabbelier
