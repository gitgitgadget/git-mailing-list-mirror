From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2009, #02; Mon, 07)
Date: Sat, 12 Sep 2009 13:46:30 +0200
Message-ID: <fabb9a1e0909120446k33df5261q63b1a8d5ed6219a7@mail.gmail.com>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org> <7veiqdngs0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jan Engelhardt <jengelh@medozas.de>,
	Johan Herland <johan@herland.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 13:46:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmR4D-0000xA-PG
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 13:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbZILLqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2009 07:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbZILLqs
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 07:46:48 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:34563 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbZILLqr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 07:46:47 -0400
Received: by ewy2 with SMTP id 2so1763643ewy.17
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 04:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Acip8OB3OTmSZc3joBCqym/ic31sVMDUmUrWVGlgrK0=;
        b=S7fJlZiGElYFjtIFcbMwQ09MF/1d8hJAMcHf6CNU+H5wkp8CIgbexYjGUzOnpPe3zE
         IwPPB36wRXTtyHQitiCds+MwNweJlvOn3O5zk/3q4lTZxswjT60YBZcglgh2qsoyok5K
         Fx+YWY7RQACFeFPmq0EIdfcaThgIJ105bRFcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DxzKPDwuLPT22D+lfqrxFCBxe6MiY3lT3fD3LC1ab1gX2tFVeiOvSGYihAtub13B7f
         9WOmn+epGkqqt0iXW4I5Khw97PdvyTZKQb40KQaAVKG+KM1dgO61cSLXA/1eQ46/MCbC
         AkBNfPt3XG7jGtNbJw/dlSOyaBa7Tvya0M0Hk=
Received: by 10.216.87.71 with SMTP id x49mr1077416wee.11.1252756010101; Sat, 
	12 Sep 2009 04:46:50 -0700 (PDT)
In-Reply-To: <7veiqdngs0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128248>

Heya,

On Sat, Sep 12, 2009 at 02:33, Junio C Hamano <gitster@pobox.com> wrote=
:
> * sr/gfi-options (2009-09-06) 6 commits
> =A0(merged to 'next' on 2009-09-07 at 5f6b0ff)
> =A0+ fast-import: test the new option command
> =A0+ fast-import: add option command
> =A0+ fast-import: test the new feature command
> =A0+ fast-import: add feature command
> =A0+ fast-import: put marks reading in it's own function
> =A0+ fast-import: put option parsing code in separate functions
>
> Perhaps 1.6.5 material but I wasn't sure. =A0I saw Sverre asking Shaw=
n for
> opinion but I may have missed the response.

No response from Shawn so far, I assume he's short on Git budget :).

--=20
Cheers,

Sverre Rabbelier
