From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: book version
Date: Thu, 3 Oct 2013 22:21:40 +0200
Message-ID: <20131003202140.GE21756@paksenarrion.iveqy.com>
References: <524DCED9.3070002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: DynV <dynvec@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 03 22:13:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRpHD-0007FQ-G0
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 22:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab3JCUNV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Oct 2013 16:13:21 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:36045 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754973Ab3JCUNT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Oct 2013 16:13:19 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so2437822lab.18
        for <git@vger.kernel.org>; Thu, 03 Oct 2013 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RUb+fpenfnT9uYLwjcuQveeuOU5PfoKk7fP0hc60kC8=;
        b=H9Qym5T9PREl4GG4KgSb3Nevcnq3l2P54fsNMdZLEtUTC/lyHXpuwAotP4uwW1l29a
         1DlD6rA7i9Ly8Ly9DDvpg/d1Mji7j4zaNDiq5uTsv14zX27PbDG7zALiCfTT0zwNEQht
         WXzchseq6NePPujcyQwXMiI25Vq+c1ZXMFnmBtJK1/2bfoxso5S2GyRbyaB+6cHas0mq
         KvxGDJyDLrkPJQX6IN3T/fn1iWGFewIInS4q4Legpvqte0x884AD47KBXQDtxP549qD0
         RrPs2JS+VZuIiw0B3eGSgmaF+1nS2w7tvdOkEVVRBpDKRL7uTchhVj+jxSwDjUh9qXjn
         WNRA==
X-Received: by 10.112.64.36 with SMTP id l4mr8228467lbs.15.1380831197674;
        Thu, 03 Oct 2013 13:13:17 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id oc1sm6334868lbb.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 03 Oct 2013 13:13:17 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VRpP2-0006cp-SR; Thu, 03 Oct 2013 22:21:40 +0200
Content-Disposition: inline
In-Reply-To: <524DCED9.3070002@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235693>

On Thu, Oct 03, 2013 at 04:08:57PM -0400, DynV wrote:
> Hello,
>=20
> I haven't subscribed to the mail-list as the beginning of Community
> <http://git-scm.com/community> hint it's not necessary ; please
> inform me if I need to be in order to get a reply.
>=20
> I have an old PDF version of Pro Git. In the file, there doesn't
> seem to be a version. Both the local (downloaded) and the on-line
> file names are the same. I'd rather not download the same thing
> twice. I would have hoped there would have been either a version or
> a check-sum so I'd be sure I have the most up-to-date book.
>=20
> The following are the check-sums of my local book
> md5 	301c91ac7084bea424e753dec694d9ca
> sha1 	139d593611ed366700abfb291bd90e262e40afe3
>=20
>=20
> Thanks
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I looks like you've the latest version. Details:

iveqy@kolya:~$ wget https://github.s3.amazonaws.com/media/progit.en.pdf
--2013-10-03 22:11:58--
https://github.s3.amazonaws.com/media/progit.en.pdf
Sl=E5r upp github.s3.amazonaws.com (github.s3.amazonaws.com)...
205.251.242.248
Ansluter till github.s3.amazonaws.com
(github.s3.amazonaws.com)|205.251.242.248|:443... ansluten.
HTTP-beg=E4ran skickad, v=E4ntar p=E5 svar... 200 OK
L=E4ngd: 5630471 (5,4M) [application/pdf]
Sparar till: "progit.en.pdf"

100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>]
5 630 471    144K/s   p=E5 44s    =20

2013-10-03 22:12:48 (124 KB/s) - "progit.en.pdf" sparades
[5630471/5630471]

iveqy@kolya:~$ md5sum progit.en.pdf=20
301c91ac7084bea424e753dec694d9ca  progit.en.pdf
iveqy@kolya:~$ sha1sum progit.en.pdf=20
139d593611ed366700abfb291bd90e262e40afe3  progit.en.pdf
iveqy@kolya:~$=20


--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
