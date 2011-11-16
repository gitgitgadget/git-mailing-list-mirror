From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Git, Parrot, Perl6, Rakudo for G4 MAC
Date: Wed, 16 Nov 2011 10:21:19 +0530
Message-ID: <CAMK1S_jcThEB=_w=miGBncmTEy8jz6_T-QHv7g-C5s3Hi+X6Lg@mail.gmail.com>
References: <loom.20111115T112500-386@post.gmane.org>
	<CAE1pOi0fqzoz+Af8PaSORuW45UqDAEmqtKW3w4qYH-275BdUzw@mail.gmail.com>
	<m3fwhpmf1f.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Greg <greggallen@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 05:52:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQXUA-0005t2-QN
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 05:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab1KPEvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 23:51:21 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41470 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab1KPEvU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 23:51:20 -0500
Received: by yenq3 with SMTP id q3so1487977yen.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 20:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YJ1K2XhDd/czJTboHLTGwfxEloxj3Dgl5OJECvjQxnQ=;
        b=ICNTu7olnqUYG+c6G9dsr48Ab2Wx7LnRpd9YA8h+IdaSzpUeSmbPhpz7NOKiMPrLTZ
         1ck0HO78AlQsPaCRJQu0K0et5bPF7z20nIl9eJtKJmHplRbL+j8Ckk5BH2css5R9JsBm
         c3uplnqL4eHZ4DS05Z+OjRKxHfciw0sfdeEpE=
Received: by 10.182.227.7 with SMTP id rw7mr6708020obc.70.1321419079878; Tue,
 15 Nov 2011 20:51:19 -0800 (PST)
Received: by 10.182.165.9 with HTTP; Tue, 15 Nov 2011 20:51:19 -0800 (PST)
In-Reply-To: <m3fwhpmf1f.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185504>

2011/11/15 Jakub Narebski <jnareb@gmail.com>:

> Git requires Perl version 5.8 at least, so you should not have any
> problems here.

One day someone [1] reminded me that git does not require perl.  Some
features, like git add -p, require it but git can be built without
perl.

[1] on irc, while discussing my stated requirements for gitolite
