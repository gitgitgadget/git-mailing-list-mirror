From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is there a pdf git manual?
Date: Mon, 07 Nov 2011 10:53:34 -0800 (PST)
Message-ID: <m3obwn3gtz.fsf@localhost.localdomain>
References: <CABrM6wkzV58WLnHkZ88y=MQVWjD8dwYMtG9HTto8t8QXBEW-hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peng Yu <pengyu.ut@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 19:53:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNUKD-0004Vi-I6
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 19:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab1KGSxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 13:53:37 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56388 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1KGSxg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 13:53:36 -0500
Received: by faan17 with SMTP id n17so310004faa.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 10:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=8OPMMje8a6K8RhPve6bKv8VSuwjE7eA9jRqY07oExAQ=;
        b=ci8C6M5C/OvU4Tw17DatB0f+GaiVhA7wUHJBulF66qqr2VIc4xqvEumieI2GMigEJt
         t5aPzz9lIlQFxlKDgY7CWbBA+kR3TpAP4oQet7aFSnAKSNgGFzDdhlyp8FoTQdg2I81S
         LaA+Lc5dKikLK8SWxpb4zIn29q71OFb+sVaPs=
Received: by 10.223.76.66 with SMTP id b2mr49935654fak.15.1320692015264;
        Mon, 07 Nov 2011 10:53:35 -0800 (PST)
Received: from localhost.localdomain (abwr239.neoplus.adsl.tpnet.pl. [83.8.241.239])
        by mx.google.com with ESMTPS id n25sm32297575fah.15.2011.11.07.10.53.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 10:53:34 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pA7Ir7sg015647;
	Mon, 7 Nov 2011 19:53:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pA7IqvIK015643;
	Mon, 7 Nov 2011 19:52:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CABrM6wkzV58WLnHkZ88y=MQVWjD8dwYMtG9HTto8t8QXBEW-hA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185013>

Peng Yu <pengyu.ut@gmail.com> writes:

> Hi,
>=20
> http://schacon.github.com/git/user-manual.html
>=20
> The manual is in html. I'm not able to find a pdf version. Running
> make in git/Documentation doesn't generate a pdf document
> automatically. Could anybody generated the pdf document and post it t=
o
> the git project website? Thanks!

"make pdf" would generate PDF version of (some of) documentation.

--=20
Jakub Nar=EAbski
