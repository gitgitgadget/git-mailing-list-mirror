From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: white spaces in a patch
Date: Wed, 17 Dec 2008 13:13:01 +0100
Message-ID: <bd6139dc0812170413j5ed2d9eak89df8517bc91c5fd@mail.gmail.com>
References: <dac45060812162331k19272488r4e95e0555e7a6db9@mail.gmail.com>
	 <7vej07p84i.fsf@gitster.siamese.dyndns.org>
	 <dac45060812170344u368ffd7fx4e86253b4a13ffc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Mark Ryden" <markryde@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 13:21:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCvPN-0008Aj-7S
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 13:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbYLQMUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 07:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbYLQMUW
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 07:20:22 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:16212 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbYLQMUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 07:20:21 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1528847ywe.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 04:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=XvKy8H8ZyLcdFzwiuJpZGeGOCyT8u/p74hiWlmq6sR0=;
        b=tgv+OjkDf65e7l8W9141vJ/+5vDnx2+Voa3x8EHLgOFr8r+U6y5YBajdCSLJoSqKcv
         xuBZhwWhMQwDeT2gaEPxGlcDpVAjwdZSOv19ObmWg42sf+ynCjjHO7HZIswlwDyT3kHB
         vksrrTuXvOV9Zl2EJaCsHMGUOg0i9az+jm5jY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=RJuZo3UURUYRPvFnUcLt6A/bUZBm25mnzCyvaU0bTwskCDJOHZ3gctVSj/s00emQaA
         OlH4RuKnuvgmhfpXM2Vdtpdf54ASoVsv+4JOTjfJ4V8uhbalUNOZjSBwGDezovIpH+FX
         vdJlYa7O73fEGA/MNJloPwQ7ewS+vA8KnvNio=
Received: by 10.151.109.11 with SMTP id l11mr1256090ybm.162.1229515981560;
        Wed, 17 Dec 2008 04:13:01 -0800 (PST)
Received: by 10.151.13.13 with HTTP; Wed, 17 Dec 2008 04:13:01 -0800 (PST)
In-Reply-To: <dac45060812170344u368ffd7fx4e86253b4a13ffc7@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 63f7febd3d7075cd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103342>

On Wed, Dec 17, 2008 at 12:44, Mark Ryden <markryde@gmail.com> wrote:
> Any ideas ? does "git diff" does  highlight for anyone ?

Do you have color on?

-- 
Cheers,

Sverre Rabbelier
