From: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
Subject: Re: [PATCH] Fix typos on pt_BR/gittutorial.txt translation
Date: Thu, 30 Jul 2009 19:51:17 -0300
Message-ID: <b8bf37780907301551w4cdc7e96m137aa188ce1a0a8c@mail.gmail.com>
References: <b8bf37780907292044i5ad7b879ueb5048447e4e5bb5@mail.gmail.com>
	 <20090730145044.GA1727@vespa.holoscopio.com>
	 <4A71C6A7.80008@drmicha.warpmail.net>
	 <7viqhaar7v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 00:51:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWeT9-0002Iq-Jn
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 00:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbZG3WvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 18:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbZG3WvS
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 18:51:18 -0400
Received: from mail-vw0-f199.google.com ([209.85.212.199]:36933 "EHLO
	mail-vw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbZG3WvR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 18:51:17 -0400
Received: by vws37 with SMTP id 37so79556vws.27
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 15:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3KAiEqISa+m3Nc09lr83ojpTx/Scbt53Ez2M3c8Blek=;
        b=Cr5Fm7HCGxwf/N3wR3F4DRNO+v8qTb6ENHXJPTXAgxaQy2DG46idPMu6Tua2qG7sci
         29vmTT4Orgyj11TjiMCAoQoV8/GMH7d9Ta/2xn4+jvskKcNDXyelqfzpB4wt56vVJtSt
         OQJx0y+uqoYKsZ2b5q2v5l+FjxZbjxW04+c90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bluggEtFXrgNZEptxhUXkCUZf7wJxeKmyB6plEoND0N2vnq9LVhCjy8R7VDiu9HzER
         St9TZEUJuD5NfACvXVr/hScwmUNWfr8w7sS78u8ML4/N0gljV04IiMK+sUKJ5e/DvJ1r
         crxDgEWzJspuDtM7P0a7UsWN63AgJeoDwpVso=
Received: by 10.220.46.10 with SMTP id h10mr2299448vcf.8.1248994277560; Thu, 
	30 Jul 2009 15:51:17 -0700 (PDT)
In-Reply-To: <7viqhaar7v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124484>

On 7/30/09, Junio C Hamano <gitster@pobox.com> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> Isn't it more like "kernel of linux", which is pretty OK (at least in
>> English)?
>
> Google shows (in a query limited to Portuguese) 912000 hits for "kernel do
> Linux" and 6550 hits for "o Linux kernel", so as Thadeu already said, it
> appears to be not just "common", but "so common that practically nobody
> uses the other form."
>
> I do not know if there is a war between the factions that use these two
> phrases in Portuguese speaking community, but this smells somewhat similar
> to the "Is it Linux or GNU/Linux?" religious war.  GNU/Linux example might
> be much more religious, as opposed to a lingusitc disagreement Thadeu's
> comment suggests the Portuguese situation is, though.
>
> Be it religious or linguistic, I'd rather not to see the war fought in our
> documentation.  The documentation is not about the Linux kernel to begin
> with, and being easier to read and understand by using phrases more
> familiar to the readers is much more important than being technically and
> linguistically correct but risking to make novices stutter while reading
> due to uncommon wording.
>

Hi, Junio!

    I surely won't argue with your pragmatic view, I do believe it's
good for the project, as you have mentioned.

    Would you like to get another patch or can you adjust it himself
as you like?

Thanks,
Andre
