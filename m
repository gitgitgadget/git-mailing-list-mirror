From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (take 2)] git-blame.el --- Minor mode for incremental blame for Git
Date: Tue, 6 Feb 2007 17:45:56 +0100
Message-ID: <200702061745.57372.jnareb@gmail.com>
References: <200702042114.34922.jnareb@gmail.com> <200702061650.05221.jnareb@gmail.com> <20070206163126.GA18711@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>,
	Junio Hamano <junkio@cox.net>
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Feb 06 17:44:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HETQl-0005e1-Mq
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 17:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbXBFQo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 6 Feb 2007 11:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbXBFQo2
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 11:44:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:35802 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965161AbXBFQo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 11:44:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1657877uga
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 08:44:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=neBo3QjhXXxqQxq+TbaVzELSWKPEnzem530LegvKFzPsytJXOdFpjwPJObwmgb3CtrML399kvj8Rerb2CtQzIBwagVWyxUKI4QhaWNZEkmpPJmlIWSvOfZvCAjDJIiffXjqoOJWIfwcEQNbzp11R0V8+OvtbNmHn/jn8MnpQnUM=
Received: by 10.78.201.2 with SMTP id y2mr1783795huf.1170780266380;
        Tue, 06 Feb 2007 08:44:26 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id j34sm9892972ugc.2007.02.06.08.44.25;
        Tue, 06 Feb 2007 08:44:25 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070206163126.GA18711@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38858>

Karl Hasselstr=F6m wrote:
> On 2007-02-06 16:50:04 +0100, Jakub Narebski wrote:
>=20
>> can you confirm if there is no copy of this (and previous) messages
>> via git@vger.kernel.org?
>=20
> I get the list mails via mail, and I haven't seen any discussion
> between you and David.

Hmmm... I wonder if it was because of using
  Junio C.Hamano <junkio@cox.net>
instead of
  Junio Hamano <junkio@cox.net>

In short: David said that git-blame.el is GPLv2 or later, and we agreed
on using `define-minor-mode' later when we have keymap.

--=20
Jakub Narebski
Poland
