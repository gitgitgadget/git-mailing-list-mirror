From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Apology/Bug report: git-send-email sends everything on Ctrl+C
Date: Wed, 26 May 2010 11:07:02 +0200
Message-ID: <AANLkTin51a4RONmN6j3GXGJQ3UtE8bt3e_PF5t75mZTC@mail.gmail.com>
References: <4BFCB9D0.3010400@vilain.net> <4BFCC4B5.6070408@vilain.net> 
	<1274861112.2074.2.camel@wpalmer.simply-domain> <4BFCE12E.4070009@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed May 26 11:07:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHCaM-0000ld-OC
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 11:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783Ab0EZJH3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 05:07:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33799 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab0EZJH2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 05:07:28 -0400
Received: by gyg13 with SMTP id 13so2661639gyg.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OBf0IqRScjliLmfez2Pk+tziVUirUjygLJicvGgX45E=;
        b=MIiP7WxDICMkQ1VbpSr/4eT+f4cl2NmgDTwNNFyO6+EwXPw+cZd7ZqF9KZTRCFjK1z
         UtZ6OkYdcvLkpIlD4V9hzgo0xrTSPuYb3oKxLFQr588ULfsBG/CUaK2nrh9mZSuJZblA
         OaS2aCDnzROKEmAzxeLO4irCZxCtrG9u4ecPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JpE3ce24rT+ifw5tWU35MUBC4OD948uNVBVIf7cnH5LA9WrZEyYcmRQGV1l6zdhVOz
         Qsf5W6w0HkjDug+HWtSpFJi/YFgKVynP+OvWzaYabmMdiXeF47P69ubTBYJ/vufjAcmq
         F4TBCfF1o1pEdAYVgUv1y3J9Gsmx8ksFXFRIo=
Received: by 10.150.250.2 with SMTP id x2mr5456812ybh.267.1274864847605; Wed, 
	26 May 2010 02:07:27 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Wed, 26 May 2010 02:07:02 -0700 (PDT)
In-Reply-To: <4BFCE12E.4070009@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147786>

Heya,

[sorry for my earlier reply to your other accidental mail, feel free
to ignore it as I had not read this thread yet]

On Wed, May 26, 2010 at 10:51, Sam Vilain <sam@vilain.net> wrote:
> Hard to know what could have possibly stopped this from happening. =C2=
=A0PEBKAC.

Perhaps git can be smart and ask for confirmation for huge (>20 ?) patc=
hsets.

--=20
Cheers,

Sverre Rabbelier
