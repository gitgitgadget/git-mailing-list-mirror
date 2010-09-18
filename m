From: Miles Bader <miles@gnu.org>
Subject: Re: did anyone see my message re "git smart http server ..."?
Date: Sat, 18 Sep 2010 12:26:46 +0900
Message-ID: <AANLkTi=-k_qWW2LuUGrq8U_8_cMLYVrMy6j5_s9zkyf6@mail.gmail.com>
References: <AANLkTikz8eKkXt7hsnR5nunq3Z8Ub5nvetctUsa1vOto@mail.gmail.com> <20100918032351.GA30282@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Sep 18 05:27:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owo5Y-0001fX-MZ
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 05:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab0IRD11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 23:27:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48420 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab0IRD10 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 23:27:26 -0400
Received: by iwn5 with SMTP id 5so2477371iwn.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 20:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=D86+F+1HbBQjpv+74fCETvDVxgBrXgKRbrofzS1XQZc=;
        b=PJM3LKKY4nAyefgAaHPQ1+lKLa/8e2LKeTz2vXKIqA8Fp0lf8mbyNbP18tEr6YcIMY
         V0KQ/NYPiZp46SzXrM6aBPVUXRyisn2jO1L2hrixp1+XQdwDfmFbflrZRm+dqllsDL2V
         Spc2wU1AUc0gylIxshhLyvgE+BKx3DlPOvJYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=V+SxvDTrqpTv6rO3DK1HTEhL+D1oZkkhc4jsQTyMcJnMHSk4esyWQlywqP4XTUSUji
         EijnYSYCQqiVMEzZ9c8AmaQErvx4NOvQctZafZR5aeCG7ZcSR+wG6VLGNU7K2lps4Pzz
         2XxYgUxF4K2JDOtfX97l1XNNXE/x/5WfERsWQ=
Received: by 10.231.190.149 with SMTP id di21mr6057712ibb.166.1284780446138;
 Fri, 17 Sep 2010 20:27:26 -0700 (PDT)
Received: by 10.231.147.75 with HTTP; Fri, 17 Sep 2010 20:26:46 -0700 (PDT)
In-Reply-To: <20100918032351.GA30282@LK-Perkele-V2.elisa-laajakaista.fi>
X-Google-Sender-Auth: fWd1cqYQm2Sy6oodo7WtePI32iw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156425>

On Sat, Sep 18, 2010 at 12:23 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Sat, Sep 18, 2010 at 11:18:20AM +0900, Miles Bader wrote:
>> I sent a message to the git mailing list yesterday, with the subject=
 line:
>>
>> =A0 Subject: =A0git "smart http" server vs. http redirects
>>
>> Did anyone see my message? =A0Is there some kind of spam filtering o=
n
>> the list that might have eaten it...?
>
> I searched my own git mailbox, no match.
>
> The most important filter on mailinglist is that all messages even
> containing HTML part are junked. There are also some forbidden words
> (and word combinations) that cause message to be dropped.

yay.  Nothing like ad-hoc spam filters that silently drop messages!

My message contained some examples of an http output stream, i dunno
maybe it's unhappy with some of that...

So... what is one supposed to do in this situation?  Randomly delete
parts of the message and resend it until something gets through?

Thanks,

-Miles

--=20
Cat is power. =A0Cat is peace.
