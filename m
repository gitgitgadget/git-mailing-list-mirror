From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: complete config list from other manpages
Date: Sun, 24 Oct 2010 00:30:54 +0200
Message-ID: <201010240030.55865.jnareb@gmail.com>
References: <8145782bddf60325909f328337cb76d25c4402cf.1287690696.git.trast@student.ethz.ch> <8145782bddf60325909f328337cb76d25c4402cf.1287872553.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 24 00:31:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9mcI-0006vw-QO
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 00:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758304Ab0JWWa7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 18:30:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62960 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758237Ab0JWWa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 18:30:58 -0400
Received: by fxm16 with SMTP id 16so1749571fxm.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=r6M+odBR2/DsLvjlaukJpMZCRbwlW1SpsvyyUFzoOjw=;
        b=bOh7vN9Pfa69l2QRc0WqIwjCJPrEQgpgHwFrhZRt//WGND8kWYtPMn94KDk5t7dxoS
         VznXxE9x24BRwcY8Xw6kqi3/dhsKx2MAp6/Dra1dB9PKT3uSh+1kgL2/gBVVE46Env5R
         PW2Xr1fhBO0e1K8JV7CVcQrsD5T726jAdhogM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ixWWljVuUIKTLnsZJmMYUO3T1Yoyk0ZQapdWnJuyoshfpFs9hWPe4dRPeExPHcOl/O
         EJcvAo1o4YVn0Xa3HH3UF9GlnGES90C5AQdds/wfyOUHfuICeQIQLlSPTyhddb5UyPRf
         YuLKxAKzlwu+5Ka/P46ZKWq/XsNZq3D5LmT6s=
Received: by 10.103.225.3 with SMTP id c3mr5597108mur.82.1287873057059;
        Sat, 23 Oct 2010 15:30:57 -0700 (PDT)
Received: from [192.168.1.13] (abvr155.neoplus.adsl.tpnet.pl [83.8.215.155])
        by mx.google.com with ESMTPS id 14sm2109609fas.20.2010.10.23.15.30.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 15:30:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <8145782bddf60325909f328337cb76d25c4402cf.1287872553.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159830>

Thomas Rast wrote:

> ---
>=20
> Jakub Narebski wrote:
> > Could you please resend this patch using rename detection=20
> > (git format-patch -M)? =A0It would make it clear what the differenc=
e
> > between config-vars and config-vars-src is, if any.
>=20
> Right, sorry about that. =A0There wasn't supposed to be any; I'm
> resending what I pushed out for everyone's convenience, but the stray
> change will be gone in the final version.

And because it is now below vger's anti-SPAM limit on size of message,
it is now visible at git@vger.kernel.org

--=20
Jakub Narebski
Poland
