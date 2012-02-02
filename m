From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 10:34:06 +0200
Message-ID: <CAMP44s3FxUmnpQevoV2ARJpWK9CJ16zXDmpJRDOLHNW6RdSc5Q@mail.gmail.com>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
	<1328145320-14071-2-git-send-email-felipe.contreras@gmail.com>
	<20120202081622.GB3823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:34:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rss7S-0005ye-NP
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab2BBIeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 03:34:09 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54667 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754821Ab2BBIeI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 03:34:08 -0500
Received: by lagu2 with SMTP id u2so1140214lag.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 00:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZddFVGdBbr/9hBnq2zwL1KJ27SMj+OQB9QBIFlYUA00=;
        b=E2P4exwzpXe4kBQYU1pVyQsAi7HOT9yK/Hi8TaqT5XGSf2qTxGtKuq8xeUnFAmYK8b
         0EB05MH80B0+SuNS8hcIxmwt3VkM8eSa3B6HjYWbCUm6RMVdjpNp1CAPVDg/d6tcURoP
         Y1Ekt1IDWT9MMDvBGF+0Ku5iuWNlE9FRKiuUs=
Received: by 10.112.99.202 with SMTP id es10mr463722lbb.89.1328171646587; Thu,
 02 Feb 2012 00:34:06 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Thu, 2 Feb 2012 00:34:06 -0800 (PST)
In-Reply-To: <20120202081622.GB3823@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189603>

On Thu, Feb 2, 2012 at 10:16 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> And yet another bug in zsh[1] causes a mismatch; zsh seems to have
>> problem emulating wordspliting, but only on the command substitution=
=2E
>
> Patches didn't hit the list again. =C2=A0Any idea why?

No. A bug in list software?

I didn't get any warning or error.

--=20
=46elipe Contreras
