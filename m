From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Resurrecting : git-gui: use textconv filter
Date: Mon, 7 Jun 2010 16:22:08 +0200
Message-ID: <AANLkTin0xNLVgFdQ1q-2WjqixZdDG7kZlgY4M0eEH0ZG@mail.gmail.com>
References: <32937075d59e3275bb0762764a101607@ensimag.fr> <20100605083821.GB1151@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jun 07 16:22:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLdDo-0001eG-Cs
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 16:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007Ab0FGOWa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 10:22:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58395 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab0FGOWa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 10:22:30 -0400
Received: by fxm8 with SMTP id 8so2118222fxm.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=g48R3Zcxphotw5TirJRM/oIA9rBXhixMNrFH3V1kAnY=;
        b=PXbETkxEcnlS9OIVfJvVhs38APlzQd4PZAeSmgxpBD1DTs6ROQfBrfrEmP34lp1v6M
         XHfZN/CX4JVOJfjSi13iM5nBIfbacJtovadwPYm12gcksiLVCakpu6MjjYZyRrE89EuG
         VjgYSA+kS+cxwmXvlbSO8LZqXVffitOuWNzs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WXaRGE8VpuvPq7sgEmBxDqzXjQ4YgQcbmkuM81jlDUV47QujOvCvonjlH3wgZDJrWS
         1eP77Y+etNEzfmVYMGoU4atXbtaGuf5OEXX+VN329vKMEA0HefL5ddFfDFVeZTuY2d1T
         8aY/h9VSacif0i7cLTmALJxl8RVwNHNHp7Jrg=
Received: by 10.204.83.198 with SMTP id g6mr6824178bkl.104.1275920548381; Mon, 
	07 Jun 2010 07:22:28 -0700 (PDT)
Received: by 10.204.76.11 with HTTP; Mon, 7 Jun 2010 07:22:08 -0700 (PDT)
In-Reply-To: <20100605083821.GB1151@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148599>

Hi,

Clemens Buchacher wrote:
> By the way, if you link to a message on the mailing list, it's
> useful to provide the Message-ID like this.
>
> =C2=A0http://mid.gmane.org/20100415193944.GA5848@localhost

Thanks for the tip- I've often struggled to find a message in my email
inbox on Gmane.

-- Ram
