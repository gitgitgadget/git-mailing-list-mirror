From: "=?utf-8?q?K=C4=81rlis_Repsons?=" <karlis.repsons@gmail.com>
Subject: Repository authenticity question
Date: Sat, 13 Jun 2009 15:26:58 +0000
Message-ID: <200906131527.03450.Karlis.Repsons@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2765576.ECVdFLd70q";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 17:28:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFV9J-0007ek-G6
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 17:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761072AbZFMP1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 11:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760859AbZFMP1G
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 11:27:06 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:59781 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758341AbZFMP1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 11:27:05 -0400
Received: by bwz9 with SMTP id 9so2577191bwz.37
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=uHhaHotMu5D1u6xsygQ+X4IQB11w+uc0zcqqY4aIUh8=;
        b=KL/T3Hj0/5vDJf5MEbA6Kv4q5nB/+DQ0us5uLaAJ9BRXU2Zc4ygneKBi5ewI2a1OLz
         Brm90YjhpQ2ZTr8OBU1rYb+H44Uw33TJnkRbxWU1XoDlEVgEah5Kd7Mc88zokiB32lHj
         rcW0GLb5aYOuT8VGYcW2gKEOI/r6UTiq+TnE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=CdeETXKj3K5DCqC8o/edGEEQcKXtCW0DJvg3f0tEGh/lylkPMw7hUXB/YrDlHJGxCe
         3u/ZkFkW3eSdsYtHJutDf9Op0Eu57TnCCy+LXmuRSTDQ4dX+Fix5winiNwwuI+PnkHH7
         Mo4iAhmCEXjuY/kJ7NL7zFCdYvox8PHXbzmGo=
Received: by 10.204.31.82 with SMTP id x18mr4886456bkc.5.1244906826133;
        Sat, 13 Jun 2009 08:27:06 -0700 (PDT)
Received: from ?192.168.7.93? ([85.15.210.9])
        by mx.google.com with ESMTPS id 25sm2465723bwz.34.2009.06.13.08.27.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 08:27:05 -0700 (PDT)
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121503>

--nextPart2765576.ECVdFLd70q
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
It would be good to know what did Linus meant, when he said "and they will=
=20
fail" about people, who would try changing some git projects' history (that=
=20
is, the content, that is added already)? If I loose my repository completel=
y,=20
can I still know, that those contributions there are the same after I pull=
=20
and how? What contents can be deleted, while still retaining consistency?

Regards,
K=C4=81rlis

--nextPart2765576.ECVdFLd70q
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkozxUcACgkQHuSu329e3GHTTgCfc4u3OwvjNtuIFd7VMCfR3x/I
PMAAni8UJM2/0eOR0D8l13tHuVx0p2YW
=G6XJ
-----END PGP SIGNATURE-----

--nextPart2765576.ECVdFLd70q--
