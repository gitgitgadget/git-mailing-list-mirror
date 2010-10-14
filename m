From: Miles Bader <miles@gnu.org>
Subject: Re: Manual hunk edit mode + emacs + ^G == garbage
Date: Thu, 14 Oct 2010 18:51:39 +0900
Message-ID: <buomxqhayqc.fsf@dhlpc061.dev.necel.com>
References: <39CB17A9-2717-491B-8E01-F3E855F90649@sb.org>
	<AANLkTimM92SdY_+v5JcOx2kYbDKBJJzBofFm0FLF_S6K@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 11:51:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6KTf-0006uM-3p
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 11:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab0JNJvy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 05:51:54 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:54655 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab0JNJvx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 05:51:53 -0400
Received: from mailgate3.nec.co.jp ([10.7.69.197])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o9E9pkI8003764;
	Thu, 14 Oct 2010 18:51:46 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id o9E9pkQ08436; Thu, 14 Oct 2010 18:51:46 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.46])
	by vgate01.nec.co.jp (8.14.4/8.14.4) with ESMTP id o9E9pj8J018156;
	Thu, 14 Oct 2010 18:51:46 +0900 (JST)
Received: from relay61.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay11.aps.necel.com with ESMTP; Thu, 14 Oct 2010 18:51:40 +0900
Received: from dhlpc061 ([10.114.96.156] [10.114.96.156]) by relay61.aps.necel.com with ESMTP; Thu, 14 Oct 2010 18:51:40 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 6B76852E1B7; Thu, 14 Oct 2010 18:51:40 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <AANLkTimM92SdY_+v5JcOx2kYbDKBJJzBofFm0FLF_S6K@mail.gmail.com>
	(=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Thu, 14
 Oct 2010 09:37:51
	+0000")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159041>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>> I've been having a rather strange problem using manual hunk edit mod=
e (`git add -p`, e)
>
> Aside from this bug you might want to check out magit.el, it's a much
> nicer hunk edit more for Emacs than running git add -p in an Emacs
> terminal is.

Yup, for that particular problem, magit is, well, like magic :)

-miles

--=20
Pray, v. To ask that the laws of the universe be annulled in behalf of =
a
single petitioner confessedly unworthy.
