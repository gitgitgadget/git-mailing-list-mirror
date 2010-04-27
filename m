From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 0/2] gitweb: Syntax highlighting support
Date: Tue, 27 Apr 2010 22:49:06 +0200
Message-ID: <201004272249.06632.jnareb@gmail.com>
References: <1272396885-30609-1-git-send-email-jnareb@gmail.com> <20100427203225.GF10939@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Apr 27 22:49:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6rib-0007Jz-Rr
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 22:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484Ab0D0UtN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 16:49:13 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46028 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab0D0UtN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 16:49:13 -0400
Received: by pwj9 with SMTP id 9so9821767pwj.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=toIdo2Jaej+c8vN+ZmeEZD0jfhxaR7Jx5aWEsDk19tM=;
        b=pZS4dtF8majac3oh3vMc+hKOc5okPTuJxznv7s5Ml6zm4abltffwzgnk+tULuoSk0d
         yyV38k4ZeARg086oMOJL2VIm3C0/X69nI328Sa2WcNeWQanQ6n6pzTh7qGtLWhND6RvU
         0ftfuFv+VURQVxbvnw4UyK4tCvziaIm5Jbhu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IAzlU5WuZ/4bo4qk/4UfQ/UJ0YJzKnlCXEaWFcGqsELBJ91I9wtya4XIjz8Lzh/bzW
         j39ojJuQfLtN1fpUVRaDDs5obdS/Xr67AAXQEtBE3tWXOsJPiwrP8KSls730qMaoNi8c
         VeKbEcgX+3JgkkH+a12EO9tf08drbOyOZumho=
Received: by 10.142.56.21 with SMTP id e21mr3442949wfa.327.1272401351900;
        Tue, 27 Apr 2010 13:49:11 -0700 (PDT)
Received: from [192.168.1.13] ([72.14.240.10])
        by mx.google.com with ESMTPS id 21sm5614496pzk.12.2010.04.27.13.49.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 13:49:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100427203225.GF10939@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145953>

On Tue, 27 Apr 2010, Petr Baudis napisa=B3:
> On Tue, Apr 27, 2010 at 09:34:43PM +0200, Jakub Narebski wrote:

> > This series of patches is based originally on on Daniel Svensson's =
and
> > Sham Chukoury's work in gitweb-xmms2.git
>=20
>   I have no major concerns, but I think it would be much simpler to j=
ust
> have a single squashed-together patch.

Note that first patch in series have different authorship.  But perhaps
that doesn't matter much...

>   Acked-by: Petr Baudis <pasky@suse.cz>

Thanks.

--=20
Jakub Narebski
Poland
