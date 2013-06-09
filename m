From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] Document .git/modules
Date: Sun, 9 Jun 2013 13:13:05 +0200
Message-ID: <20130609111305.GA3514@paksenarrion.iveqy.com>
References: <1370774269-3258-1-git-send-email-iveqy@iveqy.com>
 <CAPig+cTHFcvWyoQMConxRTgEz4pq4_3Y-abFp8xAPjsdHniQ8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 13:10:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UldW3-0002wk-NG
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 13:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030Ab3FILK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 07:10:27 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:46096 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab3FILK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 07:10:27 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so3844905lab.21
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AJC0E4J8CmY0uigkRDSr4ONDyJ/Y8ITBeLw8n1ApPlo=;
        b=Ups2qQTnJ51m5FAvuBCXbVclV3fSaZZe65VyFjwmNh60+mJUix3I827tvrWKVwQwBI
         L3hYaCRu0Vx17Zjb4l794ombiiBTTTE8Bruc4Vc7f1dRXhMdKnN6dqrPNa+0+hnMdlsa
         TBRW9i+sTdwGEZvA7gSjcgh77Q2vDgvtAmQY94u5lUld6vwk5aocefPY/UGZj6ty+InD
         xaQkULRa6sv20yNJrtaek9zmdOIh27hbXGTBE3pUlM87U4JjGRMtU2xkO66TxaugXNJx
         +VMlU3EfmMDHDJoP7OGkx0b8nvavHrQffDo5ej20pCKMTG8GGpsznQskPri4cBU3pNSj
         tpRA==
X-Received: by 10.112.140.231 with SMTP id rj7mr4584478lbb.16.1370776225492;
        Sun, 09 Jun 2013 04:10:25 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id x5sm3854027lbx.8.2013.06.09.04.10.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 04:10:24 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UldYX-0001Di-63; Sun, 09 Jun 2013 13:13:05 +0200
Content-Disposition: inline
In-Reply-To: <CAPig+cTHFcvWyoQMConxRTgEz4pq4_3Y-abFp8xAPjsdHniQ8Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226954>

On Sun, Jun 09, 2013 at 06:59:17AM -0400, Eric Sunshine wrote:
> On Sun, Jun 9, 2013 at 6:37 AM, Fredrik Gustafsson <iveqy@iveqy.com> =
wrote:
> > A note in the begging of this document describe the behavior alread=
y.
>=20
> s/begging/beginning/
> s/describe/describes/
>=20
> > This patch just add where to find the repositories.
>=20
> s/add/adds/
>=20
> > Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>

Thanks! Should be fixed in the next patch (which I failed to mark as v2=
,
but that's a reply to your email)

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
