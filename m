From: nUxi Codes <code@nuxi.name>
Subject: Re: 'git submodule update' w/ .gitmodules 'update=merge' behaves
 differently on git 1.7.6 vs 1.7.2.5
Date: Sat, 20 Aug 2011 16:16:54 -0400
Message-ID: <CAD7xuU=qiVrs6f3eLSJaGiO80e=hL8acESKzJnMbC4NMtTvZag@mail.gmail.com>
References: <CAD7xuUmtndhbWz7H0uQJ3gkbqurBGOsK8ATx6og9VifS6kc9fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 22:36:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QusHR-0001Vu-6m
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 22:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab1HTUdk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Aug 2011 16:33:40 -0400
Received: from mail-yi0-f66.google.com ([209.85.218.66]:45865 "EHLO
	mail-yi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab1HTUdj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2011 16:33:39 -0400
X-Greylist: delayed 1004 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Aug 2011 16:33:39 EDT
Received: by yic24 with SMTP id 24so619137yic.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 13:33:38 -0700 (PDT)
Received: by 10.236.176.39 with SMTP id a27mr4621734yhm.37.1313871415030; Sat,
 20 Aug 2011 13:16:55 -0700 (PDT)
Received: by 10.236.43.202 with HTTP; Sat, 20 Aug 2011 13:16:54 -0700 (PDT)
X-Originating-IP: [128.61.83.190]
In-Reply-To: <CAD7xuUmtndhbWz7H0uQJ3gkbqurBGOsK8ATx6og9VifS6kc9fw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179782>

On 20 August 2011 00:19, nUxi Codes <code@nuxi.name> wrote:
>=A0Was this fixed intentionally?

Apparently, it was-
http://permalink.gmane.org/gmane.comp.version-control.git/169364 .

> If so, why hasn't Debian backported the fix [to stable]? =A0It breaks=
=2E..

This question remains.
