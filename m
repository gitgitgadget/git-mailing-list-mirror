From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 05 Dec 2007 12:10:04 +0100
Organization: At home
Message-ID: <fj60uc$er$2@ger.gmane.org>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org> <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org> <7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 12:15:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzsE1-0005PC-AZ
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 12:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbXLELPM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 06:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbXLELPM
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 06:15:12 -0500
Received: from main.gmane.org ([80.91.229.2]:53198 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbXLELPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 06:15:11 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IzsDW-0008VB-G7
	for git@vger.kernel.org; Wed, 05 Dec 2007 11:15:02 +0000
Received: from abvr161.neoplus.adsl.tpnet.pl ([83.8.215.161])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 11:15:02 +0000
Received: from jnareb by abvr161.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 11:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvr161.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67144>

Junio C Hamano wrote:

> * jk/builtin-alias (Fri Nov 30 11:22:58 2007 -0500) 1 commit
> =A0+ Support builtin aliases
>=20
> Cute hack. =A0I'd like to have "git less" here.

I guess that "git whatchanged" can be implemented also as builtin alias=
=2E

BTW. now that "git show" can be used on blobs, is "git less" really
that needed?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
