From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: web-based client for Git, was Re: GSoC 2010
Date: Fri, 12 Feb 2010 18:37:37 +0530
Message-ID: <e72faaa81002120507t5977d31fra1ca83f6e8d3a585@mail.gmail.com>
References: <e72faaa81002120222p19db9c75u737e2615c14930b1@mail.gmail.com>
	 <alpine.DEB.1.00.1002121149470.20986@pacific.mpi-cbg.de>
	 <20100212113538.GV9553@machine.or.cz>
	 <e72faaa81002120355t4c8596d0q66da4aeb4cce3a94@mail.gmail.com>
	 <20100212121844.GK4159@machine.or.cz>
	 <20100212124436.GA25606@glandium.org>
	 <20100212125146.GW4159@machine.or.cz>
	 <e72faaa81002120454o2294d5b6p32587048e4f65898@mail.gmail.com>
	 <alpine.DEB.1.00.1002121406550.20986@pacific.mpi-cbg.de>
	 <20100212130543.GX9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, jnareb@gmail.com,
	Git List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 12 14:07:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfvFI-0000aq-Di
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 14:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168Ab0BLNHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 08:07:40 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:59895 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab0BLNHj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 08:07:39 -0500
Received: by gxk24 with SMTP id 24so2306395gxk.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 05:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BPnoKbMEbVefrUMiBeXqaTBKRMvDAa+jMlX125M47/A=;
        b=LDSmORCpKLkvCjoQ1mq1z4p7ikGKE6uA0o/w2/BWHRJEmc3xNPnaOX8hLrLrCl5AcE
         QAlc/rl0aUVuhe6qgV7OTy8JcUFGOZ6s/+wuyeYMARiUh+8nneOc0GPQHZqRCpI6Gux9
         /XGRX4/0/8I2CoNWQv+Vrq3D95nYOcYtsfumo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LQ3POxbLcMVJ46DvgKpzSkTILg7tNKPLAoLov2TRoQ8Ius2xTntxWQdgvEGc7WxkLs
         FuXeqL0rSOWxozsg+JdBZRY2b70ZK05hs07XhBAe0Z+Ni4oDUbenYLO31AzVG6zTT5T/
         PDKO38xAwCOvcrhIczwoBbgYA+yPP4UGTLRy4=
Received: by 10.91.49.17 with SMTP id b17mr1419099agk.69.1265980057889; Fri, 
	12 Feb 2010 05:07:37 -0800 (PST)
In-Reply-To: <20100212130543.GX9553@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139706>

No worries, I will start work o this from next week. :)

On Fri, Feb 12, 2010 at 6:35 PM, Petr Baudis <pasky@suse.cz> wrote:
> =A0Hi!
>
> On Fri, Feb 12, 2010 at 02:07:23PM +0100, Johannes Schindelin wrote:
>> On Fri, 12 Feb 2010, Pavan Kumar Sunkara wrote:
>>
>> > I saw the wishlist of gitweb in wiki.
>> > I would like to implement the syntax highlighting for viewing blob=
s.
>> >
>> > Is there anyone working on it now?
>>
>> http://repo.or.cz/w/git/dscho.git/commitdiff/bc1ed6aafd9ee4937559535=
c66c8bddf1864bec6
>
> =A0Have you tried to submit this "upstream"? Why did it get dropped? =
This
> sounds like such a useful _and_ trivial thing that if we can't even g=
et
> *this* integrated, surely gitweb is doomed for good...
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Petr "=
Pasky" Baudis
> A great many people think they are thinking when they are merely
> rearranging their prejudices. -- William James
>
