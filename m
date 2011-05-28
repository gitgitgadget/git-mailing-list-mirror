From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking and todo in gitweb (27 May 2011)
Date: Sat, 28 May 2011 23:04:21 +0200
Message-ID: <201105282304.22178.jnareb@gmail.com>
References: <7v8vtxrlq1.fsf@alter.siamese.dyndns.org> <7vhb8kail7.fsf@alter.siamese.dyndns.org> <201105272147.54723.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 28 23:04:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQQgY-0007ZL-Me
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 23:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab1E1VEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2011 17:04:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48077 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab1E1VEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 17:04:30 -0400
Received: by bwz15 with SMTP id 15so2055162bwz.19
        for <git@vger.kernel.org>; Sat, 28 May 2011 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=NvkquljWruvt46gxQuS9y27Rkdv0n93132nEmcL3fk4=;
        b=Iad2IMjpvJMsSZfK+Ngb0yzdaHD5WvE4bOfJHkcTkTZ6K2ZcvmWqAjX3MSM83JrXHG
         e+I1dwVbthG6/RHq2IPj6ksnuogE4ERcnGslTypl7/JUtByUraFpIkyEOD1dvbN5MZPE
         BbmOK5usaq3ea3kQB1q5/8LIAsJuX93fOCr2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Kdcb2vE9QV4UhphtjHHpm/HkEWRy5Ei3MCSQSGzpjrzmR+mEC7sbmGwNTxN22rE6qu
         sDQjJTb/Ym7pWBp5UEHTunlo8KyMOdwq9R6XPloUNNl9uN4VBwcDcGYIxavlJIFEHP/0
         E2glUTWpLL1fKB5mlqD4vVUN/GiIMioUDlM1E=
Received: by 10.204.41.16 with SMTP id m16mr3076039bke.151.1306616669032;
        Sat, 28 May 2011 14:04:29 -0700 (PDT)
Received: from [192.168.1.13] (abvz93.neoplus.adsl.tpnet.pl [83.8.223.93])
        by mx.google.com with ESMTPS id ek1sm2247666bkb.9.2011.05.28.14.04.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 May 2011 14:04:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201105272147.54723.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174677>

Jakub Narebski wrote:

> [Cooking]
>=20
> * gitweb/doc (2011-05-15) 2 commits
> =A0 Message-ID: <1305141664.30104.11.camel@drew-northup.unet.maine.ed=
u>
> =A0 http://$gmane/173422
> =A0- Starting work on a man page for /etc/gitweb.conf (WIP)
> =A0. gitweb: Starting work on a man page for gitweb (WIP)

Actually the first patch, i.e. 'gitweb: Starting work on a man page for=
=20
gitweb (WIP)' was sent to git mailing list as [RFC/PATCH] response to=20
Drew Nortup email.  I don't know how I have not seen it...

--=20
Jakub Narebski
Poland
