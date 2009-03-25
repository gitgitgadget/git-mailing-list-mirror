From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v4 2/2] git-gui: minor spelling fix and string 
	factorisation.
Date: Wed, 25 Mar 2009 16:26:10 +0100
Message-ID: <fabb9a1e0903250826i3a13b634md43136d30ce9c83a@mail.gmail.com>
References: <20090324230238.GQ23521@spearce.org> <20090324231900.GB14967@zoy.org> 
	<fabb9a1e0903250604t2909e9bbg66c6dab82dcf3333@mail.gmail.com> 
	<20090325152338.GD30959@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 16:28:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmV1s-0007g3-MM
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 16:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760735AbZCYP03 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 11:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759700AbZCYP03
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 11:26:29 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:56532 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758342AbZCYP02 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 11:26:28 -0400
Received: by fk-out-0910.google.com with SMTP id 18so41020fkq.5
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XZVxacFvM/pfbmdx9WC0V/OfI1Yzd8v0QA8cmm+Nr3o=;
        b=hTTQ8BedH3cxEUPuKSwCpqEJEXnMRqsRBzj8ZpOZUnHHRfJ3/pxUJ00c8IV5w1i9Gw
         HAOcMbwAMhlRJgKjx2rs8/+pPuNwWLbtfO7JAyeKM1NKZjR/3FWbz71CHF69ck+4AUqr
         Gdl3OHOBR7UlfC/zYSVGRwh5TM3qVFMRBSqxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gngM1RAoicPtorcL3OYn3ptrEXsPpIxztmwI+w3+349kCeB4M5rOtxBC91V2JlR78W
         bF/IkRU5lzaY8LIm2DaxYe49qPq2qxOdMTWX+hw6+ah4W93wo3iGMHUwxc1At0BniTEV
         jD+asn1ibrlRG8xHOarMQXez29mUsHM1dXklE=
In-Reply-To: <20090325152338.GD30959@zoy.org>
Received: by 10.103.220.14 with SMTP id x14mr2054148muq.82.1237994785345; Wed, 
	25 Mar 2009 08:26:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114606>

Heya,

On Wed, Mar 25, 2009 at 16:23, Sam Hocevar <sam@zoy.org> wrote:
> On Wed, Mar 25, 2009, Sverre Rabbelier wrote:
>> Heya,
>>
>> On Wed, Mar 25, 2009 at 00:19, Sam Hocevar <sam@zoy.org> wrote:
>> > ---
>> >  =A8x=A8y=A8z=A8{=A8|=A8}=A8~=A8=80
>>
>> I'm curious, where'd this come from?
>
>   Just a few characters from the "Block Elements" Unicode block.
> For some reason, even though my locale is en_GB.UTF-8, Mutt insists
> on converting my messages to iso8859-1 when doing so does not lose
> information, resulting in corrupted patches, hence my addition of the
> above characters.

Aaah, similar to the <3 in the other git-gui translation patch.

>   By the way, your own mailer seems to be mangling those Unicode
> characters when answering.

Yeah, GMail is not that good about encoding and stuff, good thing I
never really need it do be :P. (The main downside is that I sometimes
get base-64 encoded emails as a bunch of unreadable text).

--=20
Cheers,

Sverre Rabbelier
