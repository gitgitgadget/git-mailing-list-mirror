From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: [PATCH 0/6] manual: Fix or remove em dashes.
Date: Tue, 9 Oct 2007 22:41:41 +0100
Message-ID: <18071eea0710091441n717c0a99p58a9b585d15cc778@mail.gmail.com>
References: <20071009205755.GB31317@ins.uni-bonn.de>
	 <20071009210530.GH31317@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Ralf Wildenhues" <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 23:41:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfMpv-00035m-Vr
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401AbXJIVlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 17:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755286AbXJIVlp
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:41:45 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:33631 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbXJIVlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 17:41:44 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2300fkz
        for <git@vger.kernel.org>; Tue, 09 Oct 2007 14:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TGhz7HpQfvCxAzBKDY3XZT2odAkc4sk3RZpN2xEkUfM=;
        b=DKm4CZJQiPug0O2w8jqOAC13bK6jhs6pbJNwVCnuT90NmDZl1IZjceLhkI6M1wANpFmenqfBS94C+NaZBp1TD4zhKnpFjMDO3uzrdhXLZVB4JvG2oHLyonumHkPDANjHfM1fx+8YrE4h1A/Bzk3RR5LdBdKCEnpLgGFUIHAZaG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b3mB/UvWj0F0hwUhkKex5GdC4WTlBL7hgrRdwgn0BLyhPaZcFgw79zWysdhIE59KBR+zr2xWrR5YfzNQulWYpzYu1sLcDbwZnm0f09SgLTsmTs2cgM6jq8o9pvkFhCfskQNXrDIyBHm+oCxsZCA/ozpWbwiMhKf9T8cEdhBCKmQ=
Received: by 10.82.165.13 with SMTP id n13mr28974501bue.1191966101993;
        Tue, 09 Oct 2007 14:41:41 -0700 (PDT)
Received: by 10.82.177.16 with HTTP; Tue, 9 Oct 2007 14:41:41 -0700 (PDT)
In-Reply-To: <20071009210530.GH31317@ins.uni-bonn.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60449>

Hello --

On 09/10/2007, Ralf Wildenhues <Ralf.Wildenhues@gmx.de> wrote:
> em dashes were used inconsistently in the manual.
> This changes them to the way they are used in US English.

I find this particular patch to be rather odd; there is nothing
invalid in the way the em-dashes are used.  Why is it US English is
somehow de facto over, say, proper English?  :)

-- Thomas Adam
