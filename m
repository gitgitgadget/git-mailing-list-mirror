From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH 4/6] user-manual: fix .gitconfig editing examples
Date: Mon, 7 May 2007 09:29:23 +0200
Message-ID: <8aa486160705070029l65a7b78cl33c50c4bc194f54b@mail.gmail.com>
References: <20070507064257.GB31269@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon May 07 09:29:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkxey-0002NI-7a
	for gcvg-git@gmane.org; Mon, 07 May 2007 09:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbXEGH3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 03:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbXEGH3Z
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 03:29:25 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:38544 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbXEGH3Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 03:29:24 -0400
Received: by ik-out-1112.google.com with SMTP id b35so1277470ika
        for <git@vger.kernel.org>; Mon, 07 May 2007 00:29:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JAhMtCbENgF3CdYBPmMUUnEJfIJN8CnLfTlZbyMAvjAzbRaUXpWJmZ1Er+5tOpu2DKIiSLAtOeum9J6JSx4wlG/ljc6TKPnU4RBpEiE5nzuhTu7T0cYYWXDu4Jz7c9JDO+d1N3gdV7yUQ0LNIKmFe/uduc0HRphDRQPJAUp3vXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SeHM6RLaOi8v4FcOu0Jq/Dm7It2cWrQMWaOcBR5k4Id9ywokTri1QU5/ghMB4pLxjvXmuoWEv4HifBIYRQdh5OBjrQSERIOZLhjsV2wb9TC3CtQkkXh3cvz5vyKQPI+zsE5I73iU/QNf8Z3488nqbV2NjRrM4u12h7kLuWDdYnw=
Received: by 10.78.193.19 with SMTP id q19mr2153778huf.1178522963435;
        Mon, 07 May 2007 00:29:23 -0700 (PDT)
Received: by 10.78.137.19 with HTTP; Mon, 7 May 2007 00:29:23 -0700 (PDT)
In-Reply-To: <20070507064257.GB31269@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46422>

On 5/7/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-05-07 01:14:00 -0400, J. Bruce Fields wrote:
>
> > Santi B=C3(c)jar points out that
>
> You seem to have broken his name in this and at least one other patch=
=2E
> (By the looks of it, you seem to have interpreted a utf8 byte sequenc=
e
> as latin1.)

I see it OK. Both in the mail and in the repo.

Santi

>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
