From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 12:16:48 +0200
Message-ID: <48AA9D90.6050408@sneakemail.com>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>	<alpine.LNX.1.00.0808181512160.19665@iabervon.org>	<7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>	<905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>	<48AA7BE9.4040108@sneakemail.com>	<7vk5edfn6g.fsf@gitster.siamese.dyndns.org>	<ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com> <vpqk5edid2y.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 12:18:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVOHj-0002LY-1F
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 12:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbYHSKQv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 06:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbYHSKQv
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 06:16:51 -0400
Received: from morch.com ([193.58.255.207]:55748 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbYHSKQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 06:16:51 -0400
Received: from [192.168.1.214] (ANice-157-1-115-112.w90-41.abo.wanadoo.fr [90.41.26.112])
	by morch.com (Postfix) with ESMTP id DC071287E
	for <git@vger.kernel.org>; Tue, 19 Aug 2008 12:19:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <vpqk5edid2y.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92845>

Matthieu Moy Matthieu.Moy-at-imag.fr |Lists| wrote:
>> There is no indication in the documentation distinguishing porcelain
>> from plumbing.
>=20
> Well, there is somehow one: "git" and "git help" show just the
> porcelain. Still, I agree with you: marking plumbing as such more
> explicitely could help newbies not to bother with it.

Theodore Tso was helpful to point out to me in
http://thread.gmane.org/gmane.comp.version-control.git/88698/focus=3D88=
844
when I said the same thing:

> The top-level man page has a listing of what is porcelain and what is
> plumbing --- although there is some disagreement.

Take a look at "git help git" it has a _different_ (and longer) list of=
=20
what is porcelain. But that there isn't an exact concensus on the matte=
r.

Peter

--=20
Peter Valdemar M=F8rch
http://www.morch.com
