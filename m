From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH] Remove dead link
Date: Fri, 23 Aug 2013 21:30:14 +0200
Organization: http://mina86.com/
Message-ID: <xa1tvc2wxl15.fsf@mina86.com>
References: <884d025e9da6f309d33dffdd1ed3731defa514ba.1377267683.git.mina86@mina86.com> <xmqq1u5kp9pq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Jon Loeliger <jdl@jdl.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 21:30:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCx43-0000Cu-CG
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 21:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170Ab3HWTaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 15:30:23 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:60469 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab3HWTaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 15:30:22 -0400
Received: by mail-ea0-f178.google.com with SMTP id a15so465200eae.23
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:organization:references
         :user-agent:face:date:message-id:mime-version:content-type;
        bh=W/6yOBmTH5LhQcOQy679lLTA5XEqp0+peUp4rdUrCCs=;
        b=NnLII5y43ls3IiwaYtqyEeo3wBneV1srZ8k3dmcYr+eojCYG1MXpwSPlnZg2vxQiNH
         kX7FkaHA/gmA4HLAzTDmyISglEMi6icP2Bo7L4Sim4Ka5kXdutF5eCG9lsWx+5jf9bzq
         VXVCrkUyMlirnILEHaIpzoP0GzMlAEao0Sg/F9U4uRmRp/R8bOJAb0JqiqUA9Xzmh+/O
         4QJVUhBf9oaHd7Gb9CdtqwF3pYs5YugJ0d4EthZzWWo8GLqzcUnXDAqtAX2JDw9LoAvw
         hyJVhG0vv2NOlowTSaV3burY77OymxVjpUfxgNWGD8/06Oz3GOpPs0NDFNGhKepcIqKK
         D7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to
         :organization:references:user-agent:face:date:message-id
         :mime-version:content-type;
        bh=W/6yOBmTH5LhQcOQy679lLTA5XEqp0+peUp4rdUrCCs=;
        b=OTkd8Uz2JE2mj9d2EqcorMGsqEhSsKRTzO1KaEc3PXNpZ5iFhgwiNxR9j/XIiUazx1
         lIhxNh5BoOCKxqA+Sm06p9JpakIBGi5+QxwPQedDFXvQiALOC4AUTf/QgtgK4LcuAIEy
         r+yGdiW0Und61FUZjSMO9+zMZg8TeVFxZAoUz+86JayfwUpaBY2bG+G1ubaC15xfW7jZ
         hYqXPydiV7VUvxl3R+QrvdxPbv/Xyx81R/qQB97mKVQ82Hv5T2Qv/+NZQ/ZfvDI4KTFu
         1DBHE7hLqKS7YFgxdJLcQ15NUZIkyfSDHK1a3+gEPUb7v5W5yvbKAUCvmccfrTOt5fKd
         aUVg==
X-Gm-Message-State: ALoCoQlhUXiz4J5pKhvaxe/NnBmSbTeMtAeuL5SfjN2Inn4goJN5uRqHT0BBQWCsv/iYvvnUgRwAH+UbU5t6NAhcdOdtFftRQqcsy/KmDm62JkLLmBRx/8508Gzkpbnh2WhbM04+WEoMSWJzmY2p1DcRDdVvx9zZ76PA7ucFhemKfWYx1AnXBT3srnB5ZwtoLd7Co/ncqfe32vxcUc0bY+p8p3Ru9RfpUQ==
X-Received: by 10.15.75.137 with SMTP id l9mr540974eey.88.1377286220636;
        Fri, 23 Aug 2013 12:30:20 -0700 (PDT)
Received: from mpn-glaptop ([2620:0:105f:301:dc5b:ca2e:b113:6dc0])
        by mx.google.com with ESMTPSA id t6sm1637239eel.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 12:30:19 -0700 (PDT)
In-Reply-To: <xmqq1u5kp9pq.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.15.2+55~geb6e9d8 (http://notmuchmail.org) Emacs/24.3.50.1 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Hashcash: 1:20:130823:jdl@jdl.com::hoReQu9zU4l15PUL:0000000IFl
X-Hashcash: 1:20:130823:gitster@pobox.com::X9HJ3ORUlFyTPqxq:000000000000000000000000000000000000000000000DL7
X-Hashcash: 1:20:130823:git@vger.kernel.org::oo8VcOg5chFGYeps:0000000000000000000000000000000000000000002arb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232827>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23 2013, Junio C Hamano wrote:
> That is unfortunate, especially given the last line that the patch
> removes.  Has anybody asked pastebin folks why it is gone and if it
> can be resurrected?

Way Back Machine has nothing.

What was under that link?  If IRC logs, then those appear to be
available: http://pasky.or.cz/cp/%23git/2006-02-10.log

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--

--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain


--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJSF7hGAAoJECBgQBJQdR/06x0P/R9p9sVwG8GEylfB0n2UE9Tu
zcduoPJVRRtDrMnCvWvFSzgMXVxDe8gCvhbZtXQegPtXqmePRUipMmzIjfHEwGPP
2SRAI3o+4aBKkV/gNQzoaswNi/EF2Vl2sUoB2XIncvEdwWvrj/nA+qt72JnuSTNt
dvGNrDh0FXDB6tSIP/Oh3KOYXT92tUhv+o/Y4ihJsuWcbTzup7IvJDPPMEyzdBwX
Ffs+yoCB7T7cZTcYcT38o3v/vR4UUl+JXGJ2vbmbkMrcRjywfI1l9kOIVBuZx1NP
zAXIel3U3HeZ+ci86sET30LXfcj0a1V8+o3VlUmASW7g0oclEt7Vs4Qepod/5ydL
bIAeVA/YnL6+N12RNoENdIqpkyaqkRAeC2wLuRzoQfBD3pSN9tIWMoGlYl2wqHJD
dAbPLfCxXKqQZCOjNT1GkXpxK6t42agFxRokIA5Hohf7ITqi7PoVl2KhKnuBpgbY
2B+AYdvQYQob6+zizPk+yXvi74x+28z527Vi9tK1TAX3WaHifwib8LcwV3gYcusp
qSlMdisbpszYupvSG4acrMA2kcrJujzalJ/FtIfGJ5AkBUGoA41oxpuSN5iO78/e
8q5KeESelmCmDHZYLe6PgQ7sLu5u0h1KM5L2DpxacCgETn3Qz1CGeCG0nKJSIbeB
VId1l6zjDEOpp0N26nAd
=xa7B
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
