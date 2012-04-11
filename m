From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Parallel refactoring and git merge nightmare
Date: Wed, 11 Apr 2012 16:49:20 +0000
Message-ID: <CAMOZ1Bs4TwL8XD-N8wkkfzEUBHX_s6eh+Y+Ve=O1QN+Ja+XP5w@mail.gmail.com>
References: <1334160803.74554.YahooMailNeo@web160603.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Pap_L=C3=B4rinc?= <paplorinc@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:50:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0k0-0003vI-NI
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760705Ab2DKQtw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 12:49:52 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38935 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760593Ab2DKQtv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 12:49:51 -0400
Received: by yhmm54 with SMTP id m54so565653yhm.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4CtlntXjr92k7wMT0cqoEf38UdSNejeF1kB3gzooKDM=;
        b=bpW4eSHqSkR2wnNVTZ4mZRdG8JkjvgCTdVZfBhpucsRAYydmCpfRPVMkobBTxb9idp
         g+WOfW6SOpesZ/RThILt6JNx8Dgv6EUXFXld2QusRvKwwMo9Hc+yBE5jiit4yc27HXSn
         dPt+mzUu2111IICghAdV+9cXTvjqH6xhk19KBuLmbIRDup80e6wWWoPHQHqqg5jCTzPV
         s4BJGkWQ/dFGoyP3CfVZFGuhXP/EI+keyF6k2Ax8qxOuhZH8HIuskt9JXO8GP1yJWFKt
         s0TJ820sSf1g1Mlp2vEq1VY9OnEXSqYOQEoyhWF2aWZ9Xn0zkE+EDXz97NWzxQBpig57
         vfUw==
Received: by 10.50.57.199 with SMTP id k7mr6443522igq.25.1334162990687; Wed,
 11 Apr 2012 09:49:50 -0700 (PDT)
Received: by 10.231.60.130 with HTTP; Wed, 11 Apr 2012 09:49:20 -0700 (PDT)
In-Reply-To: <1334160803.74554.YahooMailNeo@web160603.mail.bf1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195214>

2012/4/11 Pap L=C3=B4rinc <paplorinc@yahoo.com>:
> What am I doing wrong

Probably a lot.
