From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] gitweb: Whitespace cleanup: realign, reindent
Date: Wed, 23 Aug 2006 10:55:22 +0200
Organization: At home
Message-ID: <ech55l$reh$1@sea.gmane.org>
References: <200608221651.19629.jnareb@gmail.com> <200608221652.50443.jnareb@gmail.com> <7virkkjkvd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Aug 23 10:56:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFoXJ-000803-LN
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 10:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWHWI43 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 23 Aug 2006 04:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWHWI43
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 04:56:29 -0400
Received: from main.gmane.org ([80.91.229.2]:36585 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750955AbWHWI42 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 04:56:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFoWn-0007rw-3b
	for git@vger.kernel.org; Wed, 23 Aug 2006 10:56:01 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Aug 2006 10:56:01 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Aug 2006 10:56:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25900>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> This patch tries (but no too hard) to fit gitweb source in 80 column=
s,
>> for 2 columns wide tabs, and indent and align source for better
>> readibility.
>=20
> If you are doing the wrapping, which I think is a good idea, I
> do not think you should target for an oddball setting. =A0Where
> did you get the idea of 2-column tabs?

So what is the default? 5-column tabs? 8-column tabs? And to what width=
?
80-column wide? 120-column wide?

I use 2-column tabs to have code not too wide; minimal sensible width.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
