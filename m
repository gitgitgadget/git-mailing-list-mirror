From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git config --list --local?
Date: Tue, 3 Aug 2010 20:37:05 -0500
Message-ID: <AANLkTi=c7cfL+wH9uS0z1hR9csKbvf4vtV-k3J-2qRoP@mail.gmail.com>
References: <4C583EA5.5000406@workspacewhiz.com> <m38w4npssl.fsf@localhost.localdomain> 
	<4C58BDDD.6020600@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 03:37:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgSvG-00056m-P6
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 03:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758067Ab0HDBh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 21:37:27 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40601 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757858Ab0HDBh0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 21:37:26 -0400
Received: by gyg10 with SMTP id 10so1789520gyg.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 18:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vMjSFNBXvVsAsmfUwpEKZOyoCbMZ/42FoyJe0vsMo90=;
        b=ayvZFjY8To7bG3/FJ8LvOOUZ2f0A7kQa23oh5eTgBkhdl5HFn777QaHBbmarjIbiOR
         /8mwqW0zPJVcagxEIgWJNV/CZazqU+DpI18vgJqR/XeZPSb2I3nV7moS9vgon1SaIjYL
         WJZ3AAxB8oPQFIGL00H3Ft05rTelOX7gdG0LM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RXcbhlAlq1er8baipI6zE6XoHehMpB594InOg9G5Pf6QcLFWl/bWeMKH7PeKbN3Wv/
         tYID73SFNj8izUT3VclKy6mgtbCF2ixKRKYWx8Tt84hn6OwaVdgSWcGZxw+iOA1c9jnb
         bRYiHCsiiqPNnlblg98WiKCBdq/Ip+Ka+UwMM=
Received: by 10.151.47.6 with SMTP id z6mr4555458ybj.103.1280885845207; Tue, 
	03 Aug 2010 18:37:25 -0700 (PDT)
Received: by 10.150.93.6 with HTTP; Tue, 3 Aug 2010 18:37:05 -0700 (PDT)
In-Reply-To: <4C58BDDD.6020600@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152551>

Heya,

On Tue, Aug 3, 2010 at 20:09, Joshua Jensen <jjensen@workspacewhiz.com>=
 wrote:
> I've never looked at the config section of the Git code. =C2=A0I'll h=
ave to see
> what it would take to add a --local command line option to do the sam=
e thing
> as above but in a more convenient fashion.

http://article.gmane.org/gmane.comp.version-control.git/118673

I can resend if there's interest.

--=20
Cheers,

Sverre Rabbelier
