From: Etienne Vallette d'Osia <Etienne.VallettedOsia@gmail.com>
Subject: Re: Improve tags
Date: Fri, 27 Mar 2009 11:05:00 +0100
Message-ID: <gqi8cc$7vq$1@ger.gmane.org>
References: <49CB798B.4090107@gmail.com> <20090327065356.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 11:11:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln92Q-0005qx-Na
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 11:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbZC0KKO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 06:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbZC0KKO
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 06:10:14 -0400
Received: from main.gmane.org ([80.91.229.2]:38601 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbZC0KKN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 06:10:13 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ln90k-0007vV-95
	for git@vger.kernel.org; Fri, 27 Mar 2009 10:10:02 +0000
Received: from schubby.inria.fr ([138.96.218.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 10:10:02 +0000
Received: from Etienne.VallettedOsia by schubby.inria.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 10:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: schubby.inria.fr
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <20090327065356.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114876>

Nanako Shiraishi a =C3=A9crit :
> Quoting "Etienne Vallette d'Osia" <dohzya@gmail.com>:
>=20
>> In addition, branches are a way to specify streams,
>> not a way to specify an aim for a commit.
>> (like in ruby a class is a method container, not a type)
>> So branch names are often like next, pu, dev, test, stupid-idea, etc=
=2E
>> They are totally useless for tracking aims.
>=20
> Why should that be?  'next' clearly states the aim (it is to serve as=
 an
> integration testing area for the possible new features for the next
> release).
>=20
It is not an aim (maybe "aim" is not the right term ?), it a status.
=46or me the aim is 'this commit is related to the documentation', 'thi=
s=20
commit is related to test and to the debugger'.
