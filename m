From: <nolan.ring@emc.com>
Subject: RE: svn2git question: error: unknown switch `t'
Date: Mon, 20 Sep 2010 15:40:37 -0400
Message-ID: <4E10ACF241081344B9702AA8C6440440C5B14FB33A@MX01A.corp.emc.com>
References: <4E10ACF241081344B9702AA8C6440440C5B14FB331@MX01A.corp.emc.com>
	<AANLkTik_ouA-AD+tmGEvvcJeZqVj4Rge=hcoJ5Bqgt-R@mail.gmail.com>
	<4E10ACF241081344B9702AA8C6440440C5B14FB337@MX01A.corp.emc.com>,<AANLkTi=X3NqcURV8GSmZiq5CbVwikFF5skFt_t6gkSp9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 21:42:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxmGH-0001D0-Jv
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 21:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757135Ab0ITTmm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 15:42:42 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:17602 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090Ab0ITTml convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 15:42:41 -0400
Received: from hop04-l1d11-si03.isus.emc.com (HOP04-L1D11-SI03.isus.emc.com [10.254.111.23])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o8KJgeo0015927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 20 Sep 2010 15:42:40 -0400
Received: from mailhub.lss.emc.com (mailhub.lss.emc.com [10.254.221.251]) by hop04-l1d11-si03.isus.emc.com (RSA Interceptor); Mon, 20 Sep 2010 15:42:35 -0400
Received: from corpussmtp3.corp.emc.com (corpussmtp3.corp.emc.com [10.254.169.196])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o8KJfiTT011723;
	Mon, 20 Sep 2010 15:42:04 -0400
Received: from mxhub02.corp.emc.com ([10.254.141.104]) by corpussmtp3.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 20 Sep 2010 15:42:00 -0400
Received: from mxhub03.corp.emc.com (10.254.141.105) by mxhub02.corp.emc.com
 (10.254.141.104) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 20 Sep
 2010 15:41:59 -0400
Received: from MX01A.corp.emc.com ([169.254.1.232]) by mxhub03.corp.emc.com
 ([10.254.141.105]) with mapi; Mon, 20 Sep 2010 15:41:59 -0400
Thread-Topic: svn2git question: error: unknown switch `t'
Thread-Index: ActY+mhWJ7ndjL7aRICKpVnxrFffNQAAUtCj
In-Reply-To: <AANLkTi=X3NqcURV8GSmZiq5CbVwikFF5skFt_t6gkSp9@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 20 Sep 2010 19:42:00.0034 (UTC) FILETIME=[E44AE420:01CB58FB]
X-EMM-MHVC: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156656>

Thanks for your quick response.

svn2git has alot of pre-requisite software.  Can I just upgrade git and=
 leave the other software at its current version?

Nolan
________________________________________
=46rom: =C6var Arnfj=F6r=F0 Bjarmason [avarab@gmail.com]
Sent: Monday, September 20, 2010 3:30 PM
To: Ring, Nolan
Cc: git@vger.kernel.org
Subject: Re: svn2git question: error: unknown switch `t'

On Mon, Sep 20, 2010 at 19:19,  <nolan.ring@emc.com> wrote:
> Hmmm, guess it wasn't that obvious to me!! :-)
>
> I have 1.6.0.2 installed, which does support the --track option; did =
a later git support -t as well as --track?
>
>> git --version
> git version 1.6.0.2
>
> Is there some way to know what version of git the svn2git I have inst=
alled supports?  And any way to get a version of svn2git that supports =
the one I have.

You should just upgrade Git instead, using an old version of a
conversion tool is generally a Bad Idea.
