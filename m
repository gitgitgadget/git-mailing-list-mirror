From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 01:35:06 +0100
Message-ID: <fabb9a1e1001291635n34eaf17eh5d0cf5a535e3d9c4@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com> 
	<alpine.LFD.2.00.1001291641200.1681@xanadu.home> <7viqakh8ty.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291716070.1681@xanadu.home> <7vaavwh6yh.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291833580.1681@xanadu.home> <7vy6jgcutb.fsf@alter.siamese.dyndns.org> 
	<fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com> 
	<7viqakcu56.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, Git List <git@vger.kernel.org>,
	Ron1 <ron1@flownet.com>, Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 01:35:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb1JJ-0007mI-FL
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 01:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554Ab0A3Af3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 19:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755521Ab0A3Af2
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 19:35:28 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:44498 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187Ab0A3Af1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 19:35:27 -0500
Received: by pzk28 with SMTP id 28so2027103pzk.4
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 16:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=d2mtc1Rk1g6cy7OQ1tYQ+oa1lxz+jwJG+0RHIg2wegY=;
        b=ioZvQjKVDgiUDvU0xB/C/rlqAJh2mAy5hd06bh2MHjH/0xWD1ZyJHQdYhre0cjIONm
         y9LLjSZ8wdmWYCi75ebxk0Ad7LHVjxuqsGlVYPlR9OVtUU5N168j0bxkAoiglMxMEKR1
         EnD6sC5pVqwdwBye9oelGMFRPNFTn1XlC0XMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ejkagiTFh2Pep1RXManJvJjMmtaXy2f/SmRv+yOUVa5Nh/gTkUj6Cs4NfaIkcf+Gxp
         CC0rmGlyEft3Nlfeo6hObq7WJpX5wHpl2H65QDReIIbMtLU+ljMQLStXjsF7IjaDudBY
         veQkZ7xddT9Fa263vGtSWWm3w89BGPiZHweA0=
Received: by 10.142.151.31 with SMTP id y31mr1055895wfd.107.1264811726108; 
	Fri, 29 Jan 2010 16:35:26 -0800 (PST)
In-Reply-To: <7viqakcu56.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138410>

Heya,

On Sat, Jan 30, 2010 at 01:29, Junio C Hamano <gitster@pobox.com> wrote=
:
> True. =A0And I am a moron.

Not at all, you worded it very nicely I think.

> How about this?

Definitely a major improvement, nice.

--=20
Cheers,

Sverre Rabbelier
