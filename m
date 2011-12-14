From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] revert: stop creating and removing sequencer-old directory
Date: Wed, 14 Dec 2011 21:40:45 +0530
Message-ID: <CALkWK0n_Weyr3Y97h9P+bRTizZjdxeQRgP8tG0ssiBpksBtaKg@mail.gmail.com>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net> <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net> <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net> <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net> <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net> <20111210130612.GH22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:11:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RarQI-0004j6-UH
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553Ab1LNQLJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 11:11:09 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43385 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757545Ab1LNQLH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 11:11:07 -0500
Received: by eekc4 with SMTP id c4so962072eek.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6WXpKtE5HjRPe4iM4b9GaonGdKMvMJFR/19242PufdQ=;
        b=Kw1YFFB1O6nP3iSXFFpZO9Cpeqfb0R7GWPvzptbC1x90LmvJPJLT2wms4JheEKxcqD
         PST5+4h7SQ1a3rfJ0w4PaRqUYWmzjMEkgC3rdTEDwKyynJeRsUqLGJaPWkAjoIpcvmm9
         4DFH/z0+gfxh+gwYPptuUTdAi45KILCK5q/b8=
Received: by 10.180.88.66 with SMTP id be2mr5860007wib.54.1323879066288; Wed,
 14 Dec 2011 08:11:06 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Wed, 14 Dec 2011 08:10:45 -0800 (PST)
In-Reply-To: <20111210130612.GH22035@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187139>

Hi,

Jonathan Nieder wrote:
> That's the end.

Apart from the few minor details, I'm happy with the series overall.

> =C2=A0I hope the patches provided some amusement, and
> advice towards making them more useful would be welcome.

Oh, yes.  There were quite a few :facepalm: moments in there for me ;)

Thanks for the enjoyable read.

-- Ram
