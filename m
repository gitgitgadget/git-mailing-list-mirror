From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: path/to/some/file: needs update
Date: Mon, 6 Dec 2010 14:23:19 -0500
Message-ID: <AANLkTinWsUumcYOKeohWVdrSPZexd=_-5wyiV6-nE4HP@mail.gmail.com>
References: <AANLkTinsUZCUJamUHWN=H7tyL5nKACmEcyvG6hpsTDtv@mail.gmail.com>
 <vpqk4jq3cpc.fsf@bauges.imag.fr> <AANLkTinFHFzjLNb5PpoH8WG_3gHpo4LaZaUOYX-=PFYN@mail.gmail.com>
 <idjc9t$6hv$1@dough.gmane.org> <idjd25$ajd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 20:23:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPgf9-00051y-EI
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 20:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab0LFTXm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 14:23:42 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52733 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196Ab0LFTXl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 14:23:41 -0500
Received: by yxt3 with SMTP id 3so5702536yxt.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 11:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ptyWgB+wmmZ3fDXudzXdM9Bil4wfEeKdbZaDF3PdGOM=;
        b=YSguXSwbsejJC42dQWIO/LsdlB4kXUtdMMIzdpsjc+iZlRjxSVUbg7Ln+Qah47PzZd
         C3mokoGPE+yo6ZcCRJJt029boZjpUe1J2a8Oxjt1whQunMdpi0YOEazub+aSgQcwYZhS
         Bw2VS9y8vC3h2qV60o+weFc9rM7O7TLRutA8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tIZBmTbEYKn8rp7T7t3Dg+xd5rrBdrnW+Mo+v/zxzt+usy/vDEbjAIArtNjYGhY8qF
         I8Sq3mX2BqkLdmAhH6tog9r6GQsb19ti51lQQJfgtYKR/sQJO/875cL16izRWsuszWnU
         K2FKFoiKGUfX5tergwpX+jJz0Xxjak0XZPSAQ=
Received: by 10.223.118.132 with SMTP id v4mr6043524faq.87.1291663419898; Mon,
 06 Dec 2010 11:23:39 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Mon, 6 Dec 2010 11:23:19 -0800 (PST)
In-Reply-To: <idjd25$ajd$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163017>

On Mon, Dec 6, 2010 at 2:19 PM, Neal Kreitzinger <neal@rsss.com> wrote:
> "Neal Kreitzinger" <neal@rsss.com> wrote in message
>> Hi, Patrick,
>>
>> There isn't an RHEL or EPEL rpm for a current version of git. =A0Wha=
t you'll
>> need to do is build git yourself using the tarball download from git=
=2E =A0The
>
> v/r,
> Neal
Hi Neal,
Thanks for the tip.  I won't spend too much time looking for a newer
RPM.  As you indicated, it should be pretty easy to install from
source.

Thanks.

--wpd
