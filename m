From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2011, #09; Tue, 27)
Date: Thu, 29 Dec 2011 18:46:52 +0700
Message-ID: <CACsJy8A=xg_c9xbNvZH19LamEBsKSOO_X-KP2-wFMAARbeq3Fw@mail.gmail.com>
References: <7v62h14mdt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 29 12:47:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgESH-0007D8-LP
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 12:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab1L2LrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Dec 2011 06:47:25 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56622 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab1L2LrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Dec 2011 06:47:24 -0500
Received: by eaad14 with SMTP id d14so5907299eaa.19
        for <git@vger.kernel.org>; Thu, 29 Dec 2011 03:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=g/m4dD9pxnHBaoa3/UPxuyxQ9T/+KsygHrTtsTxClX0=;
        b=lkXsLaUkeIhm1PhsC8Y8VInY6t4zzqLPqlfuVYxtZ0oP+nTNx+PYIzif1IXTB5ogHx
         QakgbHTLYvCfbDa3rgaCxmznqn2iC5cZhqX+YAaF+FT+lEN9IJ3vMIklUB+ypvQMmxri
         cb6MRq93LP2qFN0fSDAq8ZWePchjyWbTT0TDo=
Received: by 10.204.9.218 with SMTP id m26mr8636529bkm.44.1325159243231; Thu,
 29 Dec 2011 03:47:23 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Thu, 29 Dec 2011 03:46:52 -0800 (PST)
In-Reply-To: <7v62h14mdt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187778>

On Wed, Dec 28, 2011 at 6:37 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> * nd/index-pack-no-recurse (2011-12-27) 4 commits
> =C2=A0- fixup! 3413d4d
> =C2=A0- index-pack: eliminate unlimited recursion in get_delta_base()
> =C2=A0- index-pack: eliminate recursion in find_unresolved_deltas
> =C2=A0- Eliminate recursion in setting/clearing marks in commit list
>
> Expecting a reroll.

Hmm.. I thought you could easily squash the fixup in. Any reasons for
a reroll besides the fixup?
--=20
Duy
