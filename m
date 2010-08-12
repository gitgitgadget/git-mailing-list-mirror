From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Where do I stick development documentation?
Date: Thu, 12 Aug 2010 15:00:24 -0500
Message-ID: <AANLkTikTX5_qchqDuxiz=dGeTG0gB7_iRt=mpR9vJH5J@mail.gmail.com>
References: <AANLkTi=dS1DYJ3MB-Du34sVPy8Qw8VNck=Lx54DtSfO0@mail.gmail.com>
 <20100812023922.GB19174@burratino> <AANLkTinPUqSywAscEG=VsYdFPwS=x0izM1cw-J1EBDGT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:01:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjdxW-0006o7-0d
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab0HLUA4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 16:00:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38744 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab0HLUAz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 16:00:55 -0400
Received: by fxm13 with SMTP id 13so972544fxm.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=AEOTRawcs/cHsNxP93W/aWl0gkA355AYve0l38z3iTY=;
        b=W4ONF9tMhtyn/MgpKGwwaTVzyhVImIzdnvNkAbdNAKd9J6W4jaMkakfppa2r+TMiDg
         Fd+5Skd50LNqrWd9YLgMfnaFcv6ithREJ3EJTJc3BZlzueVsfz2+5KlQrJzfrp87OuCX
         r4LfKUgimmLKumLMaEi/28DU99DmbMBH3GAJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=r1ywHAZBLeJMw83Q3eeCVJ+Mj88cGfMpLeyaKdS3whxSrr0egNVhCiEfpatPttavQb
         Rz3tm5bDkNrk2Zn7M89sxkVsjT4B/XUDqA6zHA9LqWtjBJPHS/QMUsKRCoIr5ntjssi0
         J1O1A/uQcSi86MN1uoO0SLsM3f5w1b1V1sDEQ=
Received: by 10.239.133.84 with SMTP id 20mr22498hbu.125.1281643254209; Thu,
 12 Aug 2010 13:00:54 -0700 (PDT)
Received: by 10.239.186.139 with HTTP; Thu, 12 Aug 2010 13:00:24 -0700 (PDT)
In-Reply-To: <AANLkTinPUqSywAscEG=VsYdFPwS=x0izM1cw-J1EBDGT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153403>

On Wed, Aug 11, 2010 at 22:11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
>
> That would totally screw with my secret mission to turn everything
> into manpages, though :)

=46rankly, it sounds like you want something more expressive and
interlinked, such as Texinfo documentation.
