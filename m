From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: notes, was Re: What's cooking in git.git (Mar 2009, #02; Thu, 05)
Date: Thu, 5 Mar 2009 21:17:25 +0100
Message-ID: <2c6b72b30903051217w3eb4511cn7a9f6e378af83174@mail.gmail.com>
References: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0903051204010.6524@intel-tinevez-2-302>
	 <2c6b72b30903050440k6f9533bbq605d5f06161dff92@mail.gmail.com>
	 <7vwsb3zsc5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 21:19:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfK1z-00036x-2H
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 21:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbZCEURa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 15:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbZCEUR3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 15:17:29 -0500
Received: from mail-bw0-f178.google.com ([209.85.218.178]:44730 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbZCEUR3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 15:17:29 -0500
Received: by bwz26 with SMTP id 26so96403bwz.37
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 12:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WmwffdmwM6Lr68yAJjrRDJr6QqCsszbJuA+V8WQhkNk=;
        b=WWstxHLthlI8eK8yj+u3oQb0Fnqo7+8fXtgarspeAHCgk5uLxblJmwE6xs+6n3kkhF
         ZLzY5gAgZyYs4nSB4fg8ijiVYnf38UQrWTpqw8RpuoB0fHrXOC5IefAckdv7aTpZgq4s
         LoVu1ml8hq+CLBAHO1LKdq7XoQFFZsxkolN7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pCGbCXyDwPJRCy9okDU36t8k4+TvII60+NNbZHT215kowdzaxSjXNSKx46Mm22hnEy
         Kf9maFI97SUVK4Nrn7Zs03RckNjkHZbUBJZkYQ9yAI4WJg+tY1Dg29wXOnUXA9BR2d1/
         RTUeJdI+5/L0675otDIKq0L2DwMZbTK+NgBD4=
Received: by 10.181.137.17 with SMTP id p17mr487086bkn.193.1236284245927; Thu, 
	05 Mar 2009 12:17:25 -0800 (PST)
In-Reply-To: <7vwsb3zsc5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112332>

On Thu, Mar 5, 2009 at 20:23, Junio C Hamano <gitster@pobox.com> wrote:
> Jonas Fonseca <jonas.fonseca@gmail.com> writes:
>> On Thu, Mar 5, 2009 at 12:04, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> On Thu, 5 Mar 2009, Junio C Hamano wrote:
>>>> * js/notes (Wed Feb 18 11:17:27 2009 -0800) 14 commits
>>
>> Although laziness should not be rewarded, this might be something th=
at
>> you could squash in as well.
>
> Whose laziness are you accusing? =A0Me giving Dscho a chance to make =
trivial
> clean-up of his own series instead of doing it myself???

I was referring to my own laziness of not sending a proper patch.
Sorry for the confusion.

--=20
Jonas Fonseca
