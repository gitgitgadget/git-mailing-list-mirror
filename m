From: "=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?=" 
	<pclouds@gmail.com>
Subject: Re: Git BOF notes
Date: Sun, 23 Jul 2006 03:12:07 +0700
Message-ID: <fcaeb9bf0607221312k2088658bqa45e622b7fe244e4@mail.gmail.com>
References: <20060719230155.GJ13776@pasky.or.cz>
	 <20060721132111.GD32585@fieldses.org>
	 <20060721143115.GN13776@pasky.or.cz>
	 <81b0412b0607210802q4d48b277yc4c45d4acbd890a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 22 22:12:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4Npl-0008RJ-EZ
	for gcvg-git@gmane.org; Sat, 22 Jul 2006 22:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWGVUMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Jul 2006 16:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWGVUMJ
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Jul 2006 16:12:09 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:63876 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751017AbWGVUMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jul 2006 16:12:08 -0400
Received: by wx-out-0102.google.com with SMTP id s13so604394wxc
        for <git@vger.kernel.org>; Sat, 22 Jul 2006 13:12:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y7+DzDWiV7gC6+kvC3K3s/eknYQgCTNxjHjFMDraZZpZSJS/Epp49drVCWAz0LkASPBHcpjgpM6euJBthJC+ZcG5Uhsd9GcnR8ErOhnYWlG5p9Q6wRYJGOdd7w8w0PZbinBU1xvbWH1o3X7UTXPM2LOonh4+mWL1D4G5Cr56tng=
Received: by 10.70.115.16 with SMTP id n16mr2934342wxc;
        Sat, 22 Jul 2006 13:12:08 -0700 (PDT)
Received: by 10.70.45.19 with HTTP; Sat, 22 Jul 2006 13:12:07 -0700 (PDT)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0607210802q4d48b277yc4c45d4acbd890a6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24079>

On 7/21/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 7/21/06, Petr Baudis <pasky@suse.cz> wrote:
> > I don't know if there's a point in being so paranoid - it already makes
> > things more painful than necessary. In the tracking branch, you just
> > want to have what the other side has anyway, and if the other side
> > decided to jump around, why would you care otherwise?
>
> But for the ones who do care, it is much harder to notice. Even if it is
> a warning (it gets lost in crontab logs).
Then create some lost+found branches for them?
