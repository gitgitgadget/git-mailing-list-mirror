From: Twiinz <twiinz@gmail.com>
Subject: Re: Two minor tweaks on git-gui where textboxes weren't vertically centered with their labels and buttons
Date: Thu, 22 May 2008 19:45:27 +0700
Message-ID: <412a1d9a0805220545veb9af51y833aed2234d258b@mail.gmail.com>
References: <412a1d9a0805172218v7c0a920es8a48129014051a35@mail.gmail.com>
	 <20080519040746.GA29038@spearce.org>
	 <412a1d9a0805182234i18e2da4ckf428b2c134e174d1@mail.gmail.com>
	 <alpine.DEB.1.00.0805191127200.30431@racer>
	 <7vej7w6syo.fsf@gitster.siamese.dyndns.org>
	 <20080522121107.GK29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 22 14:46:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzABg-0003p9-0U
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 14:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759773AbYEVMpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 08:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757650AbYEVMpg
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 08:45:36 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:30868 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155AbYEVMpf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 08:45:35 -0400
Received: by yw-out-2324.google.com with SMTP id 9so29646ywe.1
        for <git@vger.kernel.org>; Thu, 22 May 2008 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=mWgziU9/bShZZAX/coXZxbsYdzwBCGHAhLii3m1xMv4=;
        b=ZijPywhveIQ/PIqKpA4E0MAZB2KUpFxqXYVrx6LYT6dUgZSBScZSVfdMcyEEQrThlmBKQBuCTFW7mOGxG2Bn5NB6JMVelWkerTp1XeRqdLkjkv0dbhevoWpJUeZUit3LDkY7WyTFs6/USMo/iiGQXMtmhJZZoqTKQ8UUd4yEU3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=uN7lPKQwMsay84jk1kSkUQp3XzZ8MF8u1OBqPGxvh3e4H9z//pshjClckJ0pU8FVIY+G/u144PgNM2/xUbXdTaX2Td/IOA555/FyFXxZ0qWyl7Z0XnTQ7mrLAIAF8zt/HBJ77klvh35hpuPAnAxqwENwgbkoDqzZdosNoglpuJc=
Received: by 10.142.222.21 with SMTP id u21mr4406043wfg.231.1211460327783;
        Thu, 22 May 2008 05:45:27 -0700 (PDT)
Received: by 10.142.194.3 with HTTP; Thu, 22 May 2008 05:45:27 -0700 (PDT)
In-Reply-To: <20080522121107.GK29038@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 84112f09f0913a97
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82618>

On Thu, May 22, 2008 at 7:11 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> In this case it is a very trivial patch.  Anyone who tries to do
> the same thing is likely to come up with the same result, or one
> that is close enough that it looks identical anyway.
>
> Still, it isn't in my main tree, because it is lacking a proper
> Signed-off-by tag by the original author.

Sorry for the late response,

It's a very trivial patch, indeed.

I'm still a bit confused with those Signed-off-by things. Anyway I
sign hereby that:
- I coded those few lines myself
- I didn't steal them from anyone
- I'm not going to sue anybody over its utilization

If there's more that need to be done to get this patch approved please
point me to some online materials that detail the process.

I hope that helps,
/twiinz
