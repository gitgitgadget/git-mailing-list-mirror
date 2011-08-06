From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: I suggest that git commit support -A option, just like hg
 does.thanks.
Date: Sat, 6 Aug 2011 17:02:47 +0200
Message-ID: <20110806150246.GA20650@jpl.local>
References: <35a2b515.12f42.1319f82c79d.Coremail.sinojelly@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: jelly <sinojelly@163.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 17:02:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpiOu-0007Wz-Fc
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 17:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab1HFPCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Aug 2011 11:02:51 -0400
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:42470 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab1HFPCu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 11:02:50 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 1C120E9990
	for <git@vger.kernel.org>; Sat,  6 Aug 2011 17:02:48 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Au0aAItWPU5T46eEPGdsb2JhbABCiQ6PEY9KCwEBAQE3MoFAAQEFMgEjIxALNBIUGAEMChoTh2++IIVnXwSjbA
X-IronPort-AV: E=Sophos;i="4.67,328,1309730400"; 
   d="scan'208";a="211738561"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb1.telenor.se with ESMTP; 06 Aug 2011 17:02:48 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 5CC3C422F5; Sat,  6 Aug 2011 17:02:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <35a2b515.12f42.1319f82c79d.Coremail.sinojelly@163.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178882>

On Saturday, August 06, 2011 at 16:32 CEST,
     jelly <sinojelly@163.com> wrote:

> $ hg help commit
> hg commit [OPTION]... [FILE]...
> =A0 =A0 =A0 =A0 =A0 -A --addremove =A0 =A0 =A0 =A0 =A0 =A0mark new/mi=
ssing files as added/removed before=A0committing

It seems like you're looking for the -A option to "git add".

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
