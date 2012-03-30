From: Adam Monsen <haircut@gmail.com>
Subject: Re: [PATCH v2] git-commit.txt: clarify -t requires editing message
Date: Thu, 29 Mar 2012 22:43:06 -0700
Message-ID: <4F7547EA.9050609@gmail.com>
References: <CAF_oF=xGHdbkYw-ytvcZvJnqZ_jdckUCBiuUDzkqGDk=66+yMQ@mail.gmail.com> <1333062296-27823-1-git-send-email-haircut@gmail.com> <7vboneq1vs.fsf@alter.siamese.dyndns.org> <4F75236C.4050703@gmail.com> <7vr4waoics.fsf@alter.siamese.dyndns.org> <4F753C3F.7010805@gmail.com> <7vehsaoev5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD3749E485318D06F6CB8B814"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Ivan Heffner <iheffner@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 07:43:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDUcf-00059z-TH
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 07:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692Ab2C3FnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 01:43:12 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52060 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2C3FnK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 01:43:10 -0400
Received: by qcqw6 with SMTP id w6so158722qcq.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 22:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=Kg7+LMc+9YuETnepBg+ZuzbDo7HW1VWfW/C3St8HW/I=;
        b=Z2J/Y2nd8HQxJAPtkb924tefBxgsL/RiV8/E7LVhV6jxI3CKd30AYDe9fLnx3O906w
         wcFgVxYBFrc49uxuuUiGYwpLCWtoZxPa6hJa5OJPWU+XIw8CXH4MgYb7HurzThFPWWP+
         +bBCDrGGoa29P5Rl68dZsOOa4GWbT23EPmh5ofKI/KJYdbwXPTT8Emj7TPKOF4LIND2S
         AKVDdDx1g77LZIjqMRoCYZTmvKBLeu4/xVtBc/xGb0VGRmX5WFOvlesy2oZjv150wJJ7
         SL/1LyTYyVTM5qjEoCBexPM15HKM8O/P3OChfjMUyGvDVkh2XaF/qYQV0bZ9jmEg9PPN
         s37A==
Received: by 10.229.106.87 with SMTP id w23mr345474qco.19.1333086189734;
        Thu, 29 Mar 2012 22:43:09 -0700 (PDT)
Received: from [192.168.13.92] (c-67-183-137-177.hsd1.wa.comcast.net. [67.183.137.177])
        by mx.google.com with ESMTPS id df8sm16591397qab.6.2012.03.29.22.43.07
        (version=SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 22:43:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120310 Thunderbird/11.0
In-Reply-To: <7vehsaoev5.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194329>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3749E485318D06F6CB8B814
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> I think that is something that needs fixing the broken code to behave
> less confusingly, not documenting its wrong behaviour.

Excellent! I concur.

I wish I wanted to do this enough to make time to work on it. Ivan, how
are your C chops? :)


--------------enigD3749E485318D06F6CB8B814
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPdUfqAAoJEJtdmT+DbynA3VAH/jA+8tJ29SF/TI6yq+hZdxIP
hRjZyDkt9Ps58i4widx+p9xBVHjOX1XB08nS9QtPn4Igf4qiAdjP8OGrS+LG+Osn
zlW/436qyCgCdpReGQBXg9scILhNoP8hpTVlV2rtNc6zJYGOLL7q1U2CPMZP2fcV
fvBNcJcXKv1KDmA44zy0hY4bb/AsJUCE5tpLr2HfivLUwuLUtGLDwh7ccLPh5wHW
ifFRG9IbOR9LvpGUt7bSbvSIaNGBfjiC+VWGsSGwzzfaxzl+ZnKFsMCFcIb8I+Ip
NCrwJ4Th7dPo6EPYMYeLvj/ULU/rCuGKKNQvgyTZO17eADolfKQOxTOadyawKTA=
=lPyC
-----END PGP SIGNATURE-----

--------------enigD3749E485318D06F6CB8B814--
