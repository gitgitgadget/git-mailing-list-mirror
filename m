From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.13
Date: Thu, 15 Jan 2009 22:50:03 +0800
Message-ID: <20090115145003.GA6938@b2j>
References: <20090113233643.GA28898@diku.dk> <20090114232456.GA6937@b2j> <20090114235607.GA5546@diku.dk> <20090115014617.GC6937@b2j> <20090115130659.GA18081@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:52:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTZI-00050f-VI
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765040AbZAOOuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 09:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764762AbZAOOuO
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:50:14 -0500
Received: from ti-out-0910.google.com ([209.85.142.190]:20351 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761898AbZAOOuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 09:50:11 -0500
Received: by ti-out-0910.google.com with SMTP id b6so624546tic.23
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 06:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nqxh7ee+/ajyYOcnoSIPEq1KpZt4b1RmHHjfqYQtomY=;
        b=DfXzttOJarP/rT11wE+bJ4ttKRie3nEHxsJMai4Ayl/cQFMp57GrR9uK2aMCKUM0XF
         DvvCPO+4QJvvaKajHUQ/KeEZc6YJvSsoSsxTJtk5IzjHnyTCgFiJ2wNK81nlNTmSr7/t
         sIEbnwVxFdklBR/hdnw42GAj0KaMnhdHWEypM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=rTjhMq8+2Rt3d3ZUs9oV/27mUSkNMjl9zVNRxocQRJ8B9dlWHCN1i6E0pEDB6dan/+
         gJM8PEl4QNbkjXzduWtSz+LAB9On6Wj6zMtc5qeiwsoJY6AZ+RxRDkzbAOYyBeX7JxRe
         Km8jK5aq/Vv5ukVfEph5b7PCrgqkzILJ75nqs=
Received: by 10.110.3.15 with SMTP id 15mr1729229tic.44.1232031007475;
        Thu, 15 Jan 2009 06:50:07 -0800 (PST)
Received: from localhost (pcd406163.netvigator.com [203.218.196.163])
        by mx.google.com with ESMTPS id w5sm22016tib.14.2009.01.15.06.50.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jan 2009 06:50:06 -0800 (PST)
Mail-Followup-To: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090115130659.GA18081@diku.dk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105824>

On Thu, 15 Jan 2009, Jonas Fonseca wrote:
> presence of a {/usr/incude/}ncursesw/ncurses.h header. Where are the
> unicode ncurses.h files found on your system?

on ubuntu,
/usr/incude/ncursesw/curses.h=20
/usr/incude/ncursesw/ncurses.h  ( just a sym link to curses.h above )=20

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9286 =E5=BC=B5=E7=A5=9C  =E9=A1=8C=E9=87=91=E9=99=B5=E6=
=B8=A1
    =E9=87=91=E9=99=B5=E6=B4=A5=E6=B8=A1=E5=B0=8F=E5=B1=B1=E6=A8=93  =E4=
=B8=80=E5=AE=BF=E8=A1=8C=E4=BA=BA=E8=87=AA=E5=8F=AF=E6=84=81  =E6=BD=AE=
=E8=90=BD=E5=A4=9C=E6=B1=9F=E6=96=9C=E6=9C=88=E8=A3=A1  =E5=85=A9=E4=B8=
=89=E6=98=9F=E7=81=AB=E6=98=AF=E7=93=9C=E5=B7=9E
