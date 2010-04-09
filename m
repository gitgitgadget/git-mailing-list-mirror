From: Daniel Grace <negativeview@gmail.com>
Subject: Re: Status of all files (was: Re: How can I tell if a file is ignored 
	by git?
Date: Fri, 9 Apr 2010 18:18:53 -0500
Message-ID: <t2w62a3a9cb1004091618i13fff1a7iad65e073e2292848@mail.gmail.com>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
	 <j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
	 <20100409113248.GB27353@thyrsus.com>
	 <m3sk74hjkg.fsf@localhost.localdomain>
	 <20100409140215.GB27899@thyrsus.com> <vpqy6gw7lio.fsf@bauges.imag.fr>
	 <20100409162425.GA32575@thyrsus.com>
	 <z2h62a3a9cb1004091615q52bd5f5aqc24079de7f0038ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sat Apr 10 01:19:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0NTa-0002Ji-5J
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 01:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab0DIXS5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 19:18:57 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:64002 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab0DIXS5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 19:18:57 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1391804qwh.37
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 16:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Lz8MczvAidrwgMto2vw32JrqECCWUzsSWUvZ8vkmzVw=;
        b=qwYdNlqTkuQ122jqMVowFGQGX2oIgNuGSE44ksL4+RMLJcaMQMEudYZDnfmR0SHD7r
         WXrxhR6asf40FrhHP2dp5VHPDkNxwNU4xx8eZI3eWkdETXWcZRtGsgt9UzwR8nWMpfId
         +Zn2SgrzL6JSveSy00WDtNbMKBoc5J69rqhdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vMueYpumaXZDQ4MSIJD8RHAVexLUjLJBXD1K5tlGqCm4Myjan4c/PF9/BS25FZLkVc
         EYzFTGD9xT4IqEYoCRVf+NdpuFiJiYLw8+b1BGPXd/B8OpmuBtfVs/qbKU6jE/MvNott
         iJeagQX+PHUP0gerPa+jGVmvb0XJjdNDu+/98=
Received: by 10.229.88.66 with HTTP; Fri, 9 Apr 2010 16:18:53 -0700 (PDT)
In-Reply-To: <z2h62a3a9cb1004091615q52bd5f5aqc24079de7f0038ba@mail.gmail.com>
Received: by 10.229.216.76 with SMTP id hh12mr1012928qcb.47.1270855133935; 
	Fri, 09 Apr 2010 16:18:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144483>

Eric,

I am working on a similar program (not ready for announcing yet). I
have not gotten to the part that would need this, but I would be happy
to start planning that stage and work with you to make sure that this
feature met both of our needs, and help write the documentation if
need be.

(Sorry for the double everyone in To/Cc, gmail defaulted to HTML email
and it was rejected from the list. I had to To/Cc you all again so
that Reply All from list members would work as expected.)

Daniel
http://www.doomstick.com


On Fri, Apr 9, 2010 at 6:15 PM, Daniel Grace <negativeview@gmail.com> w=
rote:
>
> Eric,
> I am working on a similar program (not ready for announcing yet). I h=
ave not gotten to the part that would need this, but I would be happy t=
o start planning that stage and work with you to make sure that this fe=
ature met both of our needs, and help write the documentation if need b=
e.
> Daniel
> http://www.doomstick.com
>
>
> On Fri, Apr 9, 2010 at 11:24 AM, Eric Raymond <esr@thyrsus.com> wrote=
:
>>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
>> > Eric Raymond <esr@thyrsus.com> writes:
>> >
>> > > (The ls-files -t codes need better documentation. =A0If I get de=
tailed enough
>> > > answers, I will write some.)
>> >
>> > http://thread.gmane.org/gmane.comp.version-control.git/126516
>> >
>> > In short, "git ls-files -t" was written long ago, never tested, an=
d
>> > probably mostly used by no one. It has a very strange behavior, it=
's
>> > not just the doc. I'd advise against using it.
>>
>> It sounds very much to me as though this feature should be scheduled
>> for deletion.
>>
>> > "git status --porcelain" is probably what you want:
>> >
>> > =A0 =A0 =A0 =A0--porcelain
>> > =A0 =A0 =A0 =A0 =A0 =A0Give the output in a stable, easy-to-parse =
format for
>> > =A0 =A0 =A0 =A0 =A0 =A0scripts. Currently this is identical to --s=
hort output, but
>> > =A0 =A0 =A0 =A0 =A0 =A0is guaranteed not to change in the future, =
making it safe
>> > =A0 =A0 =A0 =A0 =A0 =A0for scripts.
>>
>> Yes, this looks like what I would want, all right - if the status
>> codes were actually *comprehensible*!
>>
>> We should tackle this right now, because VC is not the last front en=
d
>> that will need to parse the format and at least I am willing to patc=
h
>> your docs based on what I learn. =A0Most of your other customers won=
't
>> do that.
>>
>> I'm going to start a separate thread about this.
>> --
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<a href=3D"http://www.catb.org/~esr/"=
>Eric S. Raymond</a>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
