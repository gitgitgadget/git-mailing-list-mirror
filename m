From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Are the patches used to build git on cygwin available in a git
 repo somewhere?
Date: Tue, 30 Mar 2010 21:58:56 -0500
Message-ID: <20100331025856.GB13501@progeny.tock>
References: <2cfc40321003300916o305e4c15x7850549beafc26c0@mail.gmail.com>
 <20100331025626.GA13501@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>,
	Dmitry Potapov <dpotapov@gmail.com>, Eric Blake <ebb9@byu.net>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 04:59:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwo9F-0000tv-4h
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 04:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054Ab0CaC7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 22:59:12 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:37597 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756935Ab0CaC7K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 22:59:10 -0400
Received: by ywh2 with SMTP id 2so6111585ywh.33
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Mn6q9K2Kjtsqk8l+r7MuT9NGeON4DYMOZ6pmmS3TmDE=;
        b=xumlpdVngrbNIC/L5jeNroFxgOYKf+kZpEgsQwxsOV8p4PKnRwXgfCu+baEK4Y1fz0
         donJbo0cfSPRKWs9vNxqfNLY0eLtVZr/MVjwLegbRjnRW04NbGN/Go7WYvIoEYdrqaqP
         Gx8zmmy+F3DF/KFFNJ3CTI4Nsl6d0DM95FScU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mkUPE6wUWeJ5rHQOQ9yVOyfO1DGh1LVROpLB70GF95I8C0GNOLaDTPO+tWVrKU1Xu8
         aI0A61dCQte5yLOasWBV8i5YHyaKP2DzyOeh8sjIlxv+g2ULObi5h45Kc4QKRmX6rb/j
         ULydywaoUqccgBIfifE/9lpJ85Ba3En3UyB1U=
Received: by 10.101.144.32 with SMTP id w32mr5045432ann.246.1270004317960;
        Tue, 30 Mar 2010 19:58:37 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm5596854iwn.7.2010.03.30.19.58.36
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 19:58:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100331025626.GA13501@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143639>

Jonathan Nieder wrote:
> [adding a few relevant cc's]
>=20
> Jon Seymour wrote:
>=20
> > Does anyone maintain a git repo with the patches used to successful=
ly
> > build the cygwin git packages?
>=20
> I think git.git is the canonical repo.  On cygwin.com I don=E2=80=99t=
 see any
> package more recent than 1.6.6.1 so I suspect no one has packaged a
> recent version yet.
s/recent/more recent/

Sorry for the noise.
