From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: Re: Getting a file revision
Date: Mon, 20 Aug 2007 13:38:14 +0200
Message-ID: <46C97D26.9090102@brefemail.com>
References: <7ac1e90c0708181742w531dab4asc7c90835cc56e8a1@mail.gmail.com> <7vir7ccpmj.fsf@gitster.siamese.dyndns.org>
Reply-To: t2a2e9z8ncbs9qg@brefemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 13:37:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN5ZX-0006fT-S2
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 13:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbXHTLhZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 20 Aug 2007 07:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbXHTLhY
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 07:37:24 -0400
Received: from main.gmane.org ([80.91.229.2]:35275 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbXHTLhX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 07:37:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IN5ZG-0003bl-Rn
	for git@vger.kernel.org; Mon, 20 Aug 2007 13:37:10 +0200
Received: from ngw.virtuallogix.com ([212.11.48.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 13:37:10 +0200
Received: from t2a2e9z8ncbs9qg by ngw.virtuallogix.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 13:37:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ngw.virtuallogix.com
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
In-Reply-To: <7vir7ccpmj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56209>

Hi,

Junio C Hamano wrote:
> "Bahadir Balban" <bahadir.balban@gmail.com> writes:
>=20
>> This might sound like a novice question but anyway: I sometimes have=
 a
>> need to quickly recover an old revision of a file just to check
>> something or copy some code from it.
>=20
> $ git show -p $commit:$path >$path.old-version
Is "-p" a short version of "--pretty" ?

(I do not see it documented in the man-page and assume it is not the=20
"-p" applicable to git-diff-tree, is it ?)

Thanks,
J=E9r=F4me
