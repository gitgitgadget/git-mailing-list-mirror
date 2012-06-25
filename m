From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: security flaw with smart http
Date: Mon, 25 Jun 2012 13:24:27 +0200
Message-ID: <CAGK7Mr7_a0V=Tzp9FtTjARsvSn2YOa0_GbydTrsQzxg_MJf=uA@mail.gmail.com>
References: <87fw9ns0cp.fsf@kanis.fr> <CAJo=hJvCC8_oFFMyc5Fkweg6A6cSV6z+UxeCkvnU34KQfYx91w@mail.gmail.com>
 <7vmx3vp2co.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Pearce <spearce@spearce.org>,
	Ivan Kanis <ivan.kanis@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 13:25:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj7Pj-0000Cv-Kw
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 13:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab2FYLY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 07:24:59 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:51709 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572Ab2FYLY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 07:24:58 -0400
Received: by gglu4 with SMTP id u4so2663407ggl.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 04:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Kjpbd4shuQAvyb3zbWukbE428qW3hLX5ArcoJVrb/4k=;
        b=YDjRgJn0NmpzOgdv6CI1kldLXx74usECFjSXC5cdIHyiTXBk+ATaAkBuFgqlMla6RO
         qRPzt6Xw7YygS9VpHXKmZVHyida7XVYGakdEUHJWMw8XmhhyBZwBlVhXzwtIPDherRi7
         du6YSLnvEAR0+blzmX03O0VQk0cQ7dtuPmHVWDGocm/PL/+DP1wlcQKNj/5k3sRI22Hz
         pL7CCLEgoEzCKCpTx2Xu4+jwuM1os8IN/La2sJqA3TQMt4WohyRbdTX0yRFSPhmAbfaO
         0vgigduL+XYx8Nnk7uQuf9VBBBIXnHK0py8d1c7Rz5ff1YRluCeMUtQHcfSEDdi4qHun
         7WQw==
Received: by 10.50.213.71 with SMTP id nq7mr7713009igc.12.1340623497543; Mon,
 25 Jun 2012 04:24:57 -0700 (PDT)
Received: by 10.50.99.10 with HTTP; Mon, 25 Jun 2012 04:24:27 -0700 (PDT)
In-Reply-To: <7vmx3vp2co.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200567>

> I do not recall ever releasing 1.0.7.4, nor having smart http
> support before v1.6.6, by the way.

It sounds very likely that he meant 1.7.4 no?

Philippe
