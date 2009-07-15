From: Douglas Campos <douglas@theros.info>
Subject: Re: Dividing up a large merge.
Date: Tue, 14 Jul 2009 22:29:03 -0300
Message-ID: <ed88cb980907141829p44bd616ete74ec02cfad76345@mail.gmail.com>
References: <20090714233246.GA25390@huya.quicinc.com> <3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com> 
	<20090715002926.GA26630@huya.quicinc.com> <32541b130907141734o59d224i7e0f39aa8a85e8ef@mail.gmail.com> 
	<20090715011914.GA17100@huya.quicinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Bryan Donlan <bdonlan@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 15 03:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQtPI-0000KL-89
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 03:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbZGOBf3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 21:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbZGOBf3
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 21:35:29 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:33534 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZGOBf2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 21:35:28 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jul 2009 21:35:28 EDT
Received: by gxk9 with SMTP id 9so1657554gxk.13
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 18:35:27 -0700 (PDT)
Received: by 10.150.53.2 with SMTP id b2mr11602327yba.71.1247621363079; Tue, 
	14 Jul 2009 18:29:23 -0700 (PDT)
In-Reply-To: <20090715011914.GA17100@huya.quicinc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123282>

Merging the peer branches before doesn't help it?

On Tue, Jul 14, 2009 at 10:19 PM, <davidb@quicinc.com> wrote:
> On Tue, Jul 14, 2009 at 05:34:26PM -0700, Avery Pennarun wrote:
>
>> How about having one person do the merge, then commit it (including
>> conflict markers), then have other people just make a series of
>> commits removing the conflict markers?
>
> I guess this helps in some sense, but the intermediate result
> isn't going to build, and things like mergetool aren't going to
> work. =C2=A0It's helpful for the individuals to have the full merge
> conflict available, or at least the stages of the files in
> question.
>
> David
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Douglas Campos
Theros Consulting
+55 11 7626 5959
+55 11 3020 8168
