From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Git in nutshell Inbox
Date: Wed, 10 Jul 2013 12:29:44 +0200
Message-ID: <20130710102944.GA7714@paksenarrion.iveqy.com>
References: <CABpATRsi-Akyv_d4xHsa0AdOdw4_P5VBpoWgx=ViWpA2Q0itPw@mail.gmail.com>
 <vpq4nc3g5l5.fsf@anie.imag.fr>
 <CABpATRt1wffDN7tC3fQpqLcHgf1M6NdhANjx+jxLhN2oa2xEZQ@mail.gmail.com>
 <20130709170239.GC7038@paksenarrion.iveqy.com>
 <CABpATRsG=n1MzpPLc2u_gOmOM9G8Ym=O0j9bTuwwkUS6F6f1mQ@mail.gmail.com>
 <20130709173857.GF7038@paksenarrion.iveqy.com>
 <51DC76E7.2080003@gmail.com>
 <CABpATRsr=50r_xWTB1bf82mYTUkU9tGrz-YedsA9wrzMUPB0Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Muhammad Bashir Al-Noimi <mbnoimi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 12:29:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwrdv-0005Yq-7S
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 12:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab3GJK27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jul 2013 06:28:59 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:63079 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab3GJK26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 06:28:58 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so5633280lab.4
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 03:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C8Z8U2RTmIQ2WWR5vBT27+RwJkQSPRSIOckmGgIY+GQ=;
        b=jvDNFfj6BjUQrk+E9IJfnXNqyJXytyGcTONFwWuNJyg06ap/M8TrJU79r5lSULYCoA
         FmKwHLxwlj1WffDxnk/GIgf4iAyEGAmx9jNRu54T50FFkoTfcunfRF2Vd3lILXUdS8ku
         of35BLYHyCSTRBWuVlDQVMRGMT1/SY8XAOsFAiAiPq+JX1OZKmZTUZWaotRrWZb2pHWy
         VCbC/r+836DIB1A+8ylnBXtJ87w+QFLix4vmuvc+JmHGfOBqY5GhaQ3UWqpBTN7HOBmm
         inY1xfffi0MjYhOSQQ2YWs7gJzuclBfF5a6Ya6TkrmNQH7lclcDp+iRjjQiaf8rtpnd5
         QDGA==
X-Received: by 10.112.144.35 with SMTP id sj3mr14807760lbb.4.1373452137208;
        Wed, 10 Jul 2013 03:28:57 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id k10sm10473336lbl.10.2013.07.10.03.28.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jul 2013 03:28:56 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Uwrea-0002GX-Cw; Wed, 10 Jul 2013 12:29:44 +0200
Content-Disposition: inline
In-Reply-To: <CABpATRsr=50r_xWTB1bf82mYTUkU9tGrz-YedsA9wrzMUPB0Jg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230034>

On Wed, Jul 10, 2013 at 12:10:55PM +0200, Muhammad Bashir Al-Noimi wrot=
e:
> On Tue, Jul 9, 2013 at 10:47 PM, Muhammad Bashir Al-Noimi
> <mbnoimi@gmail.com> wrote:
> > Now I've to make some tests because the new version is completely d=
ifferent
> > than the old one so I'll send a feedback soon.
>=20
>=20
> Thanks guys, the recent git-cola fabulous so I don't need to use the
> terminal anymore for git.

Glad you found something that works for you.

>=20
> As I mentioned above, I came from bzr background so git not completel=
y
> strange to me I just want to learn more about some commands so may yo=
u
> please guide me to a quick reference (as simple as possible)
>=20

git help
gives you a list of a few usefull commands.

if you search after "git cheat sheat" you will get a lot of hits,
however I don't know any that would be better than anyone else.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
