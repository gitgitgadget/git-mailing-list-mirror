From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Explicitly adding ignored files in subdirectories not working
Date: Sat, 27 Feb 2010 18:03:42 +0100
Message-ID: <fabb9a1e1002270903l4852efb4j5b95ee0481743326@mail.gmail.com>
References: <fabb9a1e1002231307o2c3499e6k3f1026f71a544b16@mail.gmail.com> 
	<20100224045958.GA2385@coredump.intra.peff.net> <fabb9a1e1002270459h55fbd1c0o509106e035402810@mail.gmail.com> 
	<7v4ol239aq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 18:04:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlQ5R-0001nl-TF
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 18:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339Ab0B0REL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 12:04:11 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:59941 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030326Ab0B0REC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 12:04:02 -0500
Received: by pzk28 with SMTP id 28so891373pzk.1
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 09:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=nVx72QIiwiONgb1qbS364q6act6ug08ufUOV3RnDz2U=;
        b=Gu3xmERVBNVDSjxNBCSAuoZ9zBO2W4GhVLlcH0HYV2IbP8tWxzKqA3BFI6nTyITx1T
         1WbmucPQ0DLnwm6TadzLl6j4bNKAt84MedGY2Hw6XjDmEYCOci63sTksgGTZHCwtGztu
         KsOqv04TIlGVU6k9c+s5oDkudTCqpizmnAvic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kMCOX95Hjc8at8idW+6a2rSlRRYGTfmRuhXQzFwHf+HWxyyDGvVF5zME8cBh9sSZAM
         kp5IvaJfRqftCck/KpFiwkfcbctjIKco+8xuwowvKdQ5WI5Nv2JaCgJokD9dhn1A2Ako
         BmP/E4TlBUwzkySvKWIWq4yNucT6HN9ZL5bhU=
Received: by 10.142.6.32 with SMTP id 32mr1182908wff.6.1267290242132; Sat, 27 
	Feb 2010 09:04:02 -0800 (PST)
In-Reply-To: <7v4ol239aq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141218>

Heya,

On Sat, Feb 27, 2010 at 17:58, Junio C Hamano <gitster@pobox.com> wrote:
> The thread is still in my inbox but haven't had a chance to allocate
> enough time to look at the issue yet.

Understandable, I'll be patient until then :).

-- 
Cheers,

Sverre Rabbelier
