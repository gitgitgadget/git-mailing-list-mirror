From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 1 Mar 2012 11:45:52 +1100
Message-ID: <CAH5451kWaRGutP1esuvjSK-arrEc=5m-SDwVHACx6QF9JFj-MQ@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com> <rmifwdti2ap.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 01:46:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2uA0-00023Q-2P
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 01:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217Ab2CAAqP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 19:46:15 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:53057 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135Ab2CAAqO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 19:46:14 -0500
Received: by wejx9 with SMTP id x9so20780wej.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 16:46:12 -0800 (PST)
Received-SPF: pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.106.9 as permitted sender) client-ip=10.180.106.9;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.106.9 as permitted sender) smtp.mail=andrew.ardill@gmail.com; dkim=pass header.i=andrew.ardill@gmail.com
Received: from mr.google.com ([10.180.106.9])
        by 10.180.106.9 with SMTP id gq9mr4579781wib.17.1330562772914 (num_hops = 1);
        Wed, 29 Feb 2012 16:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LY5vaj0OpMUCaOjt+aKFI6QUvdoHkGcFLglsYop2EN4=;
        b=wQSV5WqykozG8CnF8NmoP1AvI9L2lEg1efvupYwiEv3NMEaqr1gW2uPRWGYqa52M58
         fpMMS/fvkQCUZgKJq52SMc5v3QCHz9Wt8RwNWi90vmMwRGO4ZbpWmx/OwxHqLxcQV1XD
         QNO90b5PdXCCVJnAqXrGu2nxlsG/yK9bAc2Hg=
Received: by 10.180.106.9 with SMTP id gq9mr3673536wib.17.1330562772823; Wed,
 29 Feb 2012 16:46:12 -0800 (PST)
Received: by 10.223.96.133 with HTTP; Wed, 29 Feb 2012 16:45:52 -0800 (PST)
In-Reply-To: <rmifwdti2ap.fsf@fnord.ir.bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191868>

On 1 March 2012 11:37, Greg Troxel <gdt@ir.bbn.com> wrote:
>
> =C2=A0I have set up a JIRA instance using Atlassian's OnDemand servic=
e,
> =C2=A0available at https://git-scm.atlassian.net/
>
> Do people really think it's reasonable to use non-Free tools to devel=
op
> git? =C2=A0That seems surprising to me.
>

Maybe not, and if that is the case I am more than happy to let this die=
=2E

That said, this is the tool I know how to use best, and is in my
opinion the most flexible, reliable and supported. The source code is
available on request to customers to extend or modify (or at least it
used to be) and the company is very supportive of open source projects
in general.

Additionally, if we are not prepared to use non-Free tools, we should
probably stop using github. (This example is a little trite, seeing as
there are non-github alternatives available for grabbing the source
code. Then again, the mailing list is not disappearing any time soon,
so there is a free alternative to _any_ bug tracker that is used)

Regards,

Andrew Ardill
