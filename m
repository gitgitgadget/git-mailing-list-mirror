From: dexen deVries <dexen.devries@gmail.com>
Subject: Feature requset: listing of current stash in git gui
Date: Mon, 21 Nov 2011 11:00:52 +0100
Message-ID: <201111211100.52367.dexen.devries@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 11:01:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSQgU-0003Ig-Qf
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 11:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113Ab1KUKBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Nov 2011 05:01:00 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53892 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab1KUKA7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2011 05:00:59 -0500
Received: by eye27 with SMTP id 27so5126851eye.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 02:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:x-face:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=adC4MKQJJ29gpbaglShr/Nl0kEBg3d/rEMgP3IXXDGs=;
        b=CieGTE/fwnduMCKIqnJbYAmEaduWef73DqHqx63Lsjav59caGAqmHePpqp541uj8DX
         38FW5zAZDH4RNnL35rsmNLrv38nb/q8P9wx8AzZA8S3IaTpF9Rev52/AWPaY+z2Hwd5N
         HIK4yhMOUDLjTrVPP1kDnfGAUCiPxKgKSTO/s=
Received: by 10.14.18.94 with SMTP id k70mr881626eek.203.1321869658539;
        Mon, 21 Nov 2011 02:00:58 -0800 (PST)
Received: from coil.localnet ([89.228.8.130])
        by mx.google.com with ESMTPS id f36sm29721915eef.4.2011.11.21.02.00.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 02:00:57 -0800 (PST)
User-Agent: KMail/1.13.6 (Linux/3.2.0-rc1-l41; KDE/4.5.5; x86_64; ; )
X-Face: 1TH%]0KlR_DQ/V9+m_"neC|Yj3$MU@B/vVI\}^j`G/[9JKe=5`p[$l|z^\MRO%<
 =?utf-8?q?k=3A9xXL=5B=0A=09=5F!jEZo8=24=5B=5Dyo=7B7O-=5Dt=5F?=@Qj`v5H@L[YyU<#j7(H)P\{pMs))9$@Vww1"
 =?utf-8?q?ni-=7B+=7B5olk=3DXY=26G=0A=09?=,}|UHQMC08506\0=+p|75ucH!S!1UcXoC1vgpN_{lOMt_54_N5;)ngh6=D^uZN,
 =?utf-8?q?=7DZI9-k9=0A=09?="v<!}`jpCUMM,//`>H6w{K<geM^bS]jwD8'lAEX9>F[ScIHig1.r%65;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185739>

Hi,


please consider listing modifications stored in git's stash somewhere i=
n git=20
gui window. Perhaps above the `Staged Changes' subframe. Format of the =
listing=20
similar to output of `git stash list'. Available operations would be Po=
p,=20
Apply, Save and Drop.


Regards,
--=20
dexen deVries

[[[=E2=86=93][=E2=86=92]]]

``As my friend Jacob Gabrielson once put it, advocating Object-Oriented=
=20
Programming is like advocating Pants-Oriented Clothing.''
 -- Steve Yegge, in
http://steve-yegge.blogspot.com/2006/03/execution-in-kingdom-of-nouns.h=
tml
