From: David Kastrup <dak@gnu.org>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 18:32:34 +0100
Message-ID: <86ve875pzh.fsf@lola.quinscape.zz>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br> <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl> <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr>  =?ISO-8859-1?Q?=20=04?=
	=?ISO-8859-1?Q?<Pine.LNX.4.64.0?= =?ISO-8859-1?Q?711121715090.436?=
	=?ISO-8859-1?Q?2@racer.site>?=
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 18:33:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ird9q-0001uK-7h
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 18:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640AbXKLRcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 12:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbXKLRcy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 12:32:54 -0500
Received: from main.gmane.org ([80.91.229.2]:43608 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755314AbXKLRcy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 12:32:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ird9R-0006SQ-RB
	for git@vger.kernel.org; Mon, 12 Nov 2007 17:32:45 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 17:32:45 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 17:32:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:/vxOHEogLvdDq9v4C4i7WQ+GVA0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64672>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 12 Nov 2007, Matthieu Moy wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > On Mon, 12 Nov 2007, Jan Wielemaker wrote:
>> >
>> >> I found out that cloning a empty bare repository produces nothing at 
>> >> all, [...]
>> >
>> > If they are empty, what exactly do you mean to clone?
>> 
>> I'd expect an empty repository, with the git remote configured 
>> correctly.
>
> Yeah, right.
>
> Last time I checked, those geneticists did not clone thin air.  They 
> always waited until they had something to clone.

>> >> a empty bare repository produces nothing at 
>> >> all, [...]
>> >
>> > If they are empty, what exactly do you mean to clone?
>> 
>> I'd expect an empty repository, with the git remote configured 
>> correctly.
>
> Yeah, right.
>
> Last time I checked, those geneticists did not clone thin air.  They 
> always waited until they had something to clone.

git-init does not perform sexual intercourse, either.  I don't see why
geneticists should be relevant for determining what git-clone does.


-- 
David Kastrup
