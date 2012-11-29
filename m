From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull l10n updates for 1.8.1 round 1
Date: Thu, 29 Nov 2012 09:19:06 +0800
Message-ID: <CANYiYbHfhBXbLEEKdpJkhp+wY9-AJ1JkjfO62W3c+dm8qpk7_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 02:19:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdsmj-0002Qb-Hg
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 02:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540Ab2K2BTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 20:19:09 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47829 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932510Ab2K2BTI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 20:19:08 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so11260130iea.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 17:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=0pWo8FlqZzklfn6T2ZR3F8DhZOG2ZTy18Wqy5KykkXI=;
        b=RLCjCa7FNPT+ZIxnYN5fOi4yzh0zod+D2eKKiR9sdulyBHOvOUN69T1lELYlKxkwSc
         bkCP4/7gggj5c2xTMzqvzmFT/fcbOTe8r1kT8jniTN76Q+XFCaRJ2sJves8aXr0QKhiS
         9sP4mwSlUfshfdrcsg8a+1dGRi9ycr1emRlI7et0LEdgns8x0gRHAOuqo8k/LQy5Gj3/
         iCHqJBDFR7+EGJpHXI+8dsLj6QTVcHAkxmYYVimn+M+VtEr5zOEBghuc0odZReXdj2Mo
         d+qf9dKOe7XDFzIMCNpOscGzvzX8RT70VYPo/ONh/0ICxh4piLwzD/92KqT1lyuNeTeY
         zF2g==
Received: by 10.50.108.145 with SMTP id hk17mr21440096igb.51.1354151946366;
 Wed, 28 Nov 2012 17:19:06 -0800 (PST)
Received: by 10.50.186.135 with HTTP; Wed, 28 Nov 2012 17:19:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210805>

Hi, Junio

The following changes since commit 2d242fb3fc19fc9ba046accdd9210be8b9913f64:

  Update draft release notes for 1.8.1 (2012-11-21 13:32:58 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po.git master

for you to fetch changes up to 647d5183b8dc36b38d19c7a3f388108f245b11d3:

  l10n: Update Swedish translation (1975t0f0u) (2012-11-23 08:59:11 +0100)

----------------------------------------------------------------
Jiang Xin (1):
      l10n: Update git.pot (14 new, 3 removed messages)

Peter Krefting (1):
      l10n: Update Swedish translation (1975t0f0u)

Tran Ngoc Quan (1):
      l10n: vi.po: update to git-v1.7.12-437-g1084f

 po/git.pot | 1224 ++++++++++++++++++++++++----------------------
 po/sv.po   | 1246 +++++++++++++++++++++++++----------------------
 po/vi.po   | 1597 ++++++++++++++++++++++++++++++------------------------------
 3 files changed, 2097 insertions(+), 1970 deletions(-)

--
Jiang Xin
