From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ab/i18n (What's cooking in git.git (Feb 2011, #05; Wed, 23))
Date: Fri, 25 Feb 2011 23:14:47 -0600
Message-ID: <20110226051447.GF27887@elie>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <20110223234828.GA7286@elie>
 <7vd3mi44gx.fsf@alter.siamese.dyndns.org>
 <AANLkTinY4pt5DLokKkuCNnC1yi7nQBHcZv722x9CKvCh@mail.gmail.com>
 <20110224031414.GC7970@elie>
 <AANLkTikfqmPKA0T4Q-ac0CXzqmCEp0cWNskODEjmACW_@mail.gmail.com>
 <20110224110029.GE14115@elie>
 <AANLkTi=qK4vL7Zq1zp590jxPb1j-dqt6D7Jesy1uAni3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 06:15:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtCUd-0000SW-W8
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 06:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291Ab1BZFO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 00:14:56 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38147 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab1BZFOz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Feb 2011 00:14:55 -0500
Received: by qwd7 with SMTP id 7so1722239qwd.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 21:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YW4uvsKnb2ik+G3vZUzrxt/84mBlQWzT1SIngELCn+s=;
        b=pLAjdIM6WLGtu/yxYBKXKi8ofMaTRQ8p/AbHBV6nmCoyCgVSPR+OsJVR9D4IVbSBYD
         D59Jiw9mT2Y/qW0Vj7Scs0WHNu8jCM36O56WFCLDuYM9ABFtmlFx+VRg9V8SJ9obKjP/
         HyFO8nSyeUF8H0oVYr6ztj3SbqGUon+YU2ZeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rNTMcwhvgLSi3W7w6TJ2gX/4HfFAXEA4l1zrr/YghhafMqCSNYGqxOOOq2jVz09dPu
         22QDxiPyKKApzffszSOzR/93osFbWrpgw413WfRdsoiDiAQeJ52APFDNAg8qOGnfmnPd
         MGFvxMnqS54oa+423e5v/3Lad/RfdEd5YM+4U=
Received: by 10.224.201.74 with SMTP id ez10mr2773505qab.56.1298697294766;
        Fri, 25 Feb 2011 21:14:54 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id y17sm1114156qci.9.2011.02.25.21.14.53
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 21:14:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=qK4vL7Zq1zp590jxPb1j-dqt6D7Jesy1uAni3@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167960>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> First off, I really appreciate having your input and help on all this=
,
> really. And I didn't mean to cause frustration.

The series seems to be un-stuck now, so frustration gone.  Sorry, I'm
no good at this sort of thing.

Thanks for translated git, gettext poison, "prove"-able tests and
other assorted neat toys. :)
