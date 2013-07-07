From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: git subtree push-all and pull-all
Date: Sun, 7 Jul 2013 14:54:30 +0200
Message-ID: <20130707125430.GA23197@paksenarrion.iveqy.com>
References: <CALemSr4Z+p7v_wQn7EOFTVHjtMYgxqGSBZf3zU5pn-eW_SEG5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gareth Collins <gareth.o.collins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 14:54:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvoTt-0004f6-Ax
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 14:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab3GGMyB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jul 2013 08:54:01 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:60905 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab3GGMyA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 08:54:00 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so3038954lab.41
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sUnCHqWhM9gn5I086UhebkiL466XlzzN11R/vr1jBG4=;
        b=mm7M8GonAKx7jz/VkvLaEHyOAGV+yL/hJ6xZZMjzCdJTer36pzq7ZuTEZGWoOBmEYx
         iOD58YIqCzLMKuHSD3HKe3Fj9yoVK4qGsvkLIkxtBHmo4mkZMP2TGpejSO/kAfODlXxh
         zK4OP7lByeeffUlZ65/vdjShT1L6fjY9/MNeszCNowUJ/Hj5A/ckmx4nLVAa9KzmGO7P
         ApiaRMjG6i7N+DznrPo5nAkNBXWH9NvBXFHzbWScF68rXZbYL0see2R/TZYWWjzetj0K
         sYjm3CdHGK+Cp7r/0dv9sK8pDb1NXK5LxsqA0GzODFjHlTAFytXNhWQHgiUq/I07wVJh
         OZrA==
X-Received: by 10.152.3.74 with SMTP id a10mr8548538laa.74.1373201638303;
        Sun, 07 Jul 2013 05:53:58 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id et10sm5800871lbc.6.2013.07.07.05.53.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 05:53:57 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UvoU2-0000pv-Jj; Sun, 07 Jul 2013 14:54:30 +0200
Content-Disposition: inline
In-Reply-To: <CALemSr4Z+p7v_wQn7EOFTVHjtMYgxqGSBZf3zU5pn-eW_SEG5A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229772>

On Wed, Jul 03, 2013 at 03:56:36PM -0400, Gareth Collins wrote:
> Hello,
>=20
> I see over the last year (on the web and in this mailing list) there
> was some activity to extend subtree with a .gittrees file and
> push-all/pull-all commands.
>=20
> Perhaps I missed it, but looking through the latest git code on the
> github mirror I can't find any reference to the .gittrees file or
> these commands.
>=20
> Does anyone know the status of this feature? Was it decided that this
> was a bad idea and the feature has been rejected? Or is this a featur=
e
> still "cooking"...which will likely make it into git mainline at some
> point?
>=20
> I ask because I would like to use something like this to be able to
> keep a combined repository and separate project repositories in sync.
> Of course, if it was decided that this feature is fundamentally a bad
> idea then I will do something different.
>=20
> Any pointers would be a big help.
>=20
> thanks in advance,
> Gareth Collins

Still no answer to this? I suggest that you CC the persons discussing
this the last time.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
