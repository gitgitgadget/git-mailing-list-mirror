From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 01:01:43 -0700
Message-ID: <7vk5edfn6g.fsf@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
 <48AA7BE9.4040108@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 10:02:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVMB5-00020D-7j
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 10:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbYHSIBw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 04:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbYHSIBv
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 04:01:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbYHSIBu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2008 04:01:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BE6035A1B5;
	Tue, 19 Aug 2008 04:01:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2815A5A1B4; Tue, 19 Aug 2008 04:01:46 -0400 (EDT)
In-Reply-To: <48AA7BE9.4040108@sneakemail.com> (Peter Valdemar =?utf-8?Q?M?=
 =?utf-8?Q?=C3=B8rch's?= message of "Tue, 19 Aug 2008 09:53:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 131DA108-6DC5-11DD-81F5-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92828>

"Peter Valdemar M=C3=B8rch (Lists)"  <4ux6as402@sneakemail.com> writes:

> Here, here! That is *exactly* what I was thinking when I started
> reading this thread: "Hey, the "git diff" stuff was easy enough, it
> was the reverting (and friends) that caused me trouble!"
>
> Also, in the same area, I've now understood that to undo a "git add" =
-
> to remove a change from the index and making it show up as a
> difference between the working tree and the index - one can use "git
> ... Would've been helpful to me to have a
> sentense or paragraph about that in git-add.txt,...

Wonderful.

Can somebody who is relatively (but not extremely) new to git can
volunteer to be a documentation secretary to collect these "Hear, hear,=
 it
would have been very helpful if X were documented next to Y" stories, a=
nd
coordinate documentation updates after enough such improvement suggesti=
ons
are collected?

People who lost git virginity like myself cannot do this sensibly and
fairly.  For example, as my mind is already contaminated enough that I
discarded the original "add this as Discussion item to revert" message
after reading it once, judging it to add extra noise without much merit=
=2E
