From: "Miles Bader" <miles@gnu.org>
Subject: Re: [PATCH] config.c: Expand $HOME and tilde character in core.excludesfile
Date: Tue, 29 Jan 2008 16:51:32 +0900
Message-ID: <fc339e4a0801282351r2f592a58ya9fef377be684e3d@mail.gmail.com>
References: <y7a9aaem.fsf@blue.sea.net> <m3y7a98ttg.fsf@localhost.localdomain>
	 <buo7ihtcgtt.fsf@dhapc248.dev.necel.com>
	 <ee77f5c20801282325k3b2c888el7a2a97b78b799803@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Jari Aalto" <jari.aalto@cante.net>, git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 08:52:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJlGH-00029X-4u
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 08:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbYA2Hve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 02:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbYA2Hve
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 02:51:34 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:26744 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbYA2Hvd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 02:51:33 -0500
Received: by an-out-0708.google.com with SMTP id d31so447179and.103
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 23:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=EWTa3sr4gLREQoVdeaclF2eGuU/2kqpLQzOqt1uZPi0=;
        b=q4MAYlrn4Ofnk8MO3IJaoFj0LD9Jug4d9q5ryp5nyr46EooZxNpH/jrHOhL1WG/DET5PTd1fvlYB/tLfDRQPNk1bcn0BkdAILoa67WQab/7SAGQhtWj8yNYHc3g869LOv1Fz8qb1UaRL2VQgZ3qFc8HAA94ZG/ZubzlK5L9Hdq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kXNbkIJLxfx8+S0mCx9W4qjPx/U/nQFy9HB7fgx24XeknMdJpv7JO9t9erpKLdnmURfq8qp+Aybgt2veOVzkYaiDeHudvsFuRgK0alloDF+hTLvRp9PlfjNxuP/8t/OPRbrzo4qObYspEwRxnDA7nSFJtd0OT6X1GMGYbkAb4HE=
Received: by 10.100.249.9 with SMTP id w9mr14110956anh.44.1201593092592;
        Mon, 28 Jan 2008 23:51:32 -0800 (PST)
Received: by 10.101.70.4 with HTTP; Mon, 28 Jan 2008 23:51:32 -0800 (PST)
In-Reply-To: <ee77f5c20801282325k3b2c888el7a2a97b78b799803@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: d64c09b2bf2c38a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71962>

On Jan 29, 2008 4:25 PM, David Symonds <dsymonds@gmail.com> wrote:
> > Not that what Jari wrote had much resemblance to GNU ChangeLog format...
>
> What, like http://www.gnu.org/prep/standards/html_node/Style-of-Change-Logs.html#Style-of-Change-Logs
> ? It looked like GNU style to me.

No, all the details are wrong.  Just about the only thing in common
with ChangeLog format is that he used asterisks as bullets, and a
colon to indicate the descriptive text -- but that's simply what
people tend to do when making an itemized list in ascii...

-Miles

-- 
Do not taunt Happy Fun Ball.
