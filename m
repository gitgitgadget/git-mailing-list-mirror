From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 14:41:31 +0100
Message-ID: <bd6139dc0901150541o491ee9b8n1b5f3540a924b89e@mail.gmail.com>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	 <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>
	 <496EE74F.6000205@viscovery.net>
	 <200901151101.53441.johan@herland.net>
	 <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
	 <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
	 <20090115124433.GA4484@chistera.yi.org>
	 <alpine.DEB.1.00.0901151440380.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Adeodato_Sim=F3?=" <dato@net.com.org.es>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Anders Melchiorsen" <mail@cup.kalibalik.dk>, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:43:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSV7-00048p-BC
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762360AbZAONle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 08:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762305AbZAONle
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:41:34 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:18952 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758033AbZAONlc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 08:41:32 -0500
Received: by yx-out-2324.google.com with SMTP id 8so451068yxm.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 05:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=9/1rhhCOJXXrSpt87/u6ZX5xTI9Lqv0ufNDhnOH3/v4=;
        b=mBcFuKfEtU9i10ss85NCbymcDqSJ58lVP1xzsGUyQdIKKfChkNq3dUD/OJqd/8tnmu
         p0FBHUYXsKGYmoFQEssnSgLNZCbZXB1HL10ZvG0JZJlBtTN9r0dCA8ibxa3LQpwMHHKb
         2pTVliXd1eZLhPGbFsmvmadipcuswcnKOWVZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=so9EJdJzmp4mdQ/K/5lqym/ncoL3uJSMNubVHV1NOgqXPeDB/xxPqKVEb7Eg9mzYyy
         RTXGkOSEHkmCSsEGQKioThoiko2pLe4r69aeQ4nmnJVPz4tVpCnhk5RxufyCKJeNoYUj
         7gxBLRyaYuwxOSLGv+2IFtREvK6+aT17yqPnY=
Received: by 10.150.123.18 with SMTP id v18mr4041217ybc.85.1232026891366;
        Thu, 15 Jan 2009 05:41:31 -0800 (PST)
Received: by 10.150.121.4 with HTTP; Thu, 15 Jan 2009 05:41:31 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901151440380.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
X-Google-Sender-Auth: 7fe85a74d0a261e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105803>

On Thu, Jan 15, 2009 at 14:41, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 15 Jan 2009, Adeodato Sim=F3 wrote:
>> editmsg?
>
> Has the same first letter as 'edit'.  Would be confusing with the sho=
rtcut
> 'e', no?

"msgedit" with shortcut 'm'?

--=20
Cheers,

Sverre Rabbelier
