From: Moez Bouhlel <bmoez.j@gmail.com>
Subject: git ignores /~/.config/git/
Date: Wed, 14 Jan 2015 19:33:07 +0000
Message-ID: <20150114193307.GA2592@lejenome.me>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 19:33:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBSku-0000Ni-4O
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 19:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbbANSdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 13:33:15 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58216 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbbANSdN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 13:33:13 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so30099395wiv.5
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 10:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=Nh9XWOvtNFbOcW3vzYlanbqRk18URJ+zOrJSSfHob/k=;
        b=MF5lXSwAHB1EGK4nh1sadbth4MaC56u9V3DIJcuy1W5w4ez51dZqr4wrrSsQpmlKtY
         wGySY3YK1d1pt9WilbjpJNfRFF/GBt+KH9zFeVDGEnJCMgLs5Q2GPibsTXO9dRYNNCo2
         kkoyoMCX7YTq3Z2d+43fm8Ey2lQ72MQyRg3EFrJue19ZY2u3dAD6hDePceiQBD4WkP5B
         hp2dANcc74nKWH3dPDY8oee5n5/8/mZ1ZzMfpf7i9CBXrXaYvBai+UaShmviDlq6p2Vh
         UhXdyCZ8fXBevyP0MNqtHTKRoSJOWMQDiWO1jyBxrUwLrDrzyE51EO6nqUp/oYTpjDoO
         6JCg==
X-Received: by 10.194.80.193 with SMTP id t1mr10133139wjx.8.1421260391241;
        Wed, 14 Jan 2015 10:33:11 -0800 (PST)
Received: from localhost ([197.1.33.164])
        by mx.google.com with ESMTPSA id f1sm31134016wjw.30.2015.01.14.10.33.09
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jan 2015 10:33:10 -0800 (PST)
X-Google-Original-From: Moez Bouhlel <lejenome@lejenome.me>
Content-Disposition: inline
X-Info: Keep It Simple, Stupid.
X-Operating-System: GNU/Linux, kernel 3.18.2-2-ARCH
X-Message-Flag: WARNING!! Outlook sucks
User-Agent: Every email client sucks, this one just sucks less.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262405>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

git exludes /~/.config/git/ from the matching list.

~ is the name of a dir on the root of git working tree and not my user home dir.

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUtsRsAAoJEITYVyFzZZydDlAP/2saegwg6KYLCn8+hG9GGHPy
kvxZRx1k979VOfr66vUTLydQ5pbnSuP0JiGDPaxdn3/j/HGlOmEM7VmiSIVNe9al
GH5/+8sxmPHh4M2idi7fyROmMecCgp0Bbi+hM5X+3uC5c4rqiT7brKitro0GixwG
TKjGyu3c8xqCWRHkQx70aYN0OcLjE17MVDOHy5wognFRpqz5LQjGttOH/Tidwqr+
187+ySYCC4me60FjDaTRp4CSNF2vcjEmPbh2+2kMzZN8CziTftvDOLwucno78rH2
cZMSLXabVKOuXjZ2rNXnGXpCV0j9zfdWtz7bCAGnCqyYXuwHn7JfJ1MCUw4usCCv
4wDJK6Wj8aSNpJR6+cmsK6MVPhTvaEraF9TdXTo6I/wK467r5GhbPwzLTNDTnILl
6em0vs9/kCL2o4dCDBcpZxZd+62ad5yeYv0kNhK/OS8pOGnFrQQg+AmmhG5k46Bb
chxxQX1OtyASXDCe/+GPHyjvzNlsg5QammL+Hb3i3/QMivu753QbBvzggIBAE2/T
CYvJ1yktQku5I/pD9rSDzguQIwE7QoZW1URpnKyTcqD9V363yXB2+6uqklPpyRxd
Ab7sw87fBkNnvLHfztxhGqhBP+c+qErjP0C/gwEZNhZInnLNWThdzE+Qf5c/UkxF
xFjtfyK+Ghc2uVVMw30G
=NTXd
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
