From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Planning for 1.7.5 and 1.8.0
Date: Tue, 1 Feb 2011 10:20:43 +0700
Message-ID: <AANLkTikeqsg+qJ0z4iQ6ZmKL=_HB8YX_z20L=dFFApmA@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 01 04:21:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk6nx-0005Ti-HL
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 04:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719Ab1BADVQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 22:21:16 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60677 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab1BADVP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 22:21:15 -0500
Received: by wyb28 with SMTP id 28so6244121wyb.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 19:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=S6knvcaz73X/1otM9g4mL71iiL86Px3iyjh7iyrZ0E8=;
        b=FTrVThXoPmkOV+DYthbaIYW5brD6680h7YkYSHz+ZNh87I5i1DIAxlP1kEV+DNGGO5
         zia6vJ7KHxwIqW2nJpaiOwj5cZSOGXj+h2pcmTjPaOs5SuKKTYRcGuda0vTNLsHFDoCw
         ioDXGlocYq6in6TifB0kTTIpSCo2FV3ZQUnFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=SmldA8mNx3FyTjbXyF3TLxipEPVG7zXxVUfuvjtcMMfY5SSrMQyji889u4xgSsyvXh
         0G6su72tpFvOpdUL2mb9sPTwlxu1dXqVyTSlFGhyvfSBALL8kPxaWo+R7rGAjFCmNeYo
         qunSxAC5vAOcjvNVJyHQ+CuB/PtAB2UX4TITE=
Received: by 10.216.177.9 with SMTP id c9mr6816330wem.34.1296530474022; Mon,
 31 Jan 2011 19:21:14 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Mon, 31 Jan 2011 19:20:43 -0800 (PST)
In-Reply-To: <7vwrll57ha.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165790>

On Tue, Feb 1, 2011 at 12:05 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Now the 1.7.4 release is out, I'd like people to help thinking about =
the
> next cycle(s).
>
> As a discussion-starter, here are my random wishes. =C2=A0Even though=
 this does
> not attempt to be exhaustive, keeping the number of goals manageably =
small
> may help us focus.

Another random wish, which does not come with a proposal. How about
tag namespace (ie. tags from a remote stay in remote namespace)?
--=20
Duy
