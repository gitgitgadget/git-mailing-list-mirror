From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 15:26:37 -0500
Message-ID: <76718490901151226l704d119bh297db4e91a4da05b@mail.gmail.com>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	 <7vmydsv72u.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0901151921040.3586@pacific.mpi-cbg.de>
	 <200901151946.04991.johan@herland.net>
	 <8035E52E-D202-4C42-BDFD-DC7A925580A3@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Anders Melchiorsen" <mail@cup.kalibalik.dk>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 21:28:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNYot-0004DC-Gg
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 21:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933389AbZAOU0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 15:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933383AbZAOU0j
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 15:26:39 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:8853 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933376AbZAOU0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 15:26:38 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1223357rvb.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 12:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FoVB0BZ0gWZaF38Lp+YPawhGH6+HKnidjFLij81+Q58=;
        b=GT5D0Dwshyy3PQ8ahtNlOMh+g86zX0ktBrr01S40/z9esuRfm/cPKi186ZbntJiagx
         sTb74lKzTPKmHJRfMg0FHB3ZoDqNFsUIrVEgTY/jb++gpiNxVXlqzAS/j5flZyRrV7x9
         +2xO6OeivsYoVF0Ta8Q5KGAeWZEd86bixqIOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pqscnBiEmKT3Syv7J7MGfMz6R/59MUPwvTRGW0HuzTLE8fjpF7S2f4VtStNGedabKb
         6iMUT4bCyLf0KfSXoiGyWC4gylFhTKQqtjSCxBIG+XPpj6C+RKJtz2u2Nep+ilcOppGC
         gZNfq8dLp4e1iHwQZnTCPKRbShybc2qluUwvc=
Received: by 10.140.187.10 with SMTP id k10mr791425rvf.264.1232051197479;
        Thu, 15 Jan 2009 12:26:37 -0800 (PST)
Received: by 10.140.204.11 with HTTP; Thu, 15 Jan 2009 12:26:37 -0800 (PST)
In-Reply-To: <8035E52E-D202-4C42-BDFD-DC7A925580A3@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105874>

On Thu, Jan 15, 2009 at 2:27 PM, Wincent Colaiuta <win@wincent.com> wrote:
> wait - best suggestion so far, seeing as we can't use "stop"

This is a fun game. I like the color "halt".

j.
