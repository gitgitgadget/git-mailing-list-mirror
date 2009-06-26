From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - trial run
Date: Fri, 26 Jun 2009 22:05:48 +0300
Message-ID: <94a0d4530906261205o6e4195dub4e38e8dccbd9258@mail.gmail.com>
References: <200906252122.51737.jnareb@gmail.com>
	 <94a0d4530906260412h78b55458gc722964011edb54d@mail.gmail.com>
	 <200906261744.04610.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 21:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKGkI-0006Rf-5B
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 21:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424AbZFZTFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 15:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754698AbZFZTFr
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 15:05:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:61885 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbZFZTFq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 15:05:46 -0400
Received: by fg-out-1718.google.com with SMTP id e12so98278fga.17
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q71V5pcHEd7ewcHwdMSH2eRAs1e4ovNVznRkDgU6Ano=;
        b=jXVvta8RtGvFyiugzE1OEuGmDNlcsqyI5IcoQ0qqP+wijnsE5qPJsX+rVrxBjB4XtQ
         o1YwzVuSE4dC5jA649RZXkbdfcn2eTKHMUIdwJ7sc+Y9Z7BPSX2+7xAcOM5wEa4kbKfT
         2eUPfbSTux8OQCsGb+5m9b4EjsxgfKmPOCdFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Cd/CQ1z5qXAAGkCKpo2jfJG6ZOjsM4utaWAl0ciG773kg9n++/FSAwGbsEPC+z6Od5
         QYCjHANCVmNZbCMc4/151hA1lZ69DzE2yFnW++9G7xHE4YIfu5NmVWC2zs5f/8MiCS2j
         lJMj4ciX/jNFc519wxxS/MOO8INVZgUVcbEeU=
Received: by 10.86.93.17 with SMTP id q17mr3950590fgb.75.1246043148826; Fri, 
	26 Jun 2009 12:05:48 -0700 (PDT)
In-Reply-To: <200906261744.04610.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122315>

On Fri, Jun 26, 2009 at 6:44 PM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> On Fri, 26 June 2009, Felipe Contreras wrote:
>> 2009/6/25 Jakub Narebski <jnareb@gmail.com>:
>
>> > I have created _proposed_ version of questions for upcoming
>> > "Git User's Survey 2009", based on (a bit of) feedback on git
>> > mailing list:
>> > =C2=A0"[RFH] Questions for Git User's Survey 2009"
>> > =C2=A0Msg-Id: <200905291855.03328.jnareb@gmail.com>
>> > =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/12028=
7
>> > and comments on #git IRC channel on FreeNode.
>> >
>> > Current version of survey has 30 questions, as compared to
>> > 60 questions last year; the number of free-form essay questions
>> > were also greatly reduced.
>> >
>> >
>> > The *test* version of this year survey can be now found at
>> > the following URL (as in previous year, we use Survs.com)
>> >
>> > =C2=A0http://www.survs.com/survey?id=3D2PIMZGU0&channel=3DTFN2Y52K=
7Y

<snip/>

> =C2=A0+8. How did/do you obtain Git?
>
> It is IMHO more interesting how people upgrade Git, than just how
> they installed it.

Sure, but it can be assumed from how it was installed:
 * Some kind of package management (automatically updated)
 * In other binary form (manually)
 * From a source tarball (manually)
 * From git.git repository (manually)

<snip/>

>> Also, I would like to see a list of areas users would like improveme=
nts:
>> XX. In you opinion, which areas need improvement?
>> =C2=A0* user-interface
>> =C2=A0* documentation
>> =C2=A0* performance
>> =C2=A0* more features
>> =C2=A0* other
>>
>> Is there a way for users to assign points? eg. user-interface: 2,
>> documentation: 1, more features: 1
>
> We can always use 'matrix' form, with columns corresponding to import=
ance
> of a given area for improvement (1-3, or 1-5 numeric range). =C2=A0Be=
cause
> asking user to order from most important to least important (one can
> enforce this on Survs.com by requiring only one answer with given col=
umn
> selected) would be too difficult and confusing.

I see, in that case I think a matrix form would do.

Cheers.

--=20
=46elipe Contreras
