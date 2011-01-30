From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Status of dumb http transport?
Date: Sun, 30 Jan 2011 07:57:21 -0700
Message-ID: <AANLkTimTXOVcaRCW04GtHiJWGNBnFVE8Vg+tyqo5Bk4+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 30 15:57:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjYis-000570-NN
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 15:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab1A3O5p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 09:57:45 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60940 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab1A3O5o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 09:57:44 -0500
Received: by bwz15 with SMTP id 15so4567631bwz.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 06:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=A8jTByNLBEnJbUGaW1neSQyGnDKjb+2yxBsw5DYTFZE=;
        b=Fj81G2jhARofRoYjVCe+0SwIW0HRiSErukWxShJ13EkBsOCggTRhSzXR6+jiweguPe
         KiPp7/QihNyzwmBsfZdlxJHCEZ0phxJWc8g5/KJYAWK+YZxKU2vmMGDHwzvhnTvvhK1k
         wANxwViHz8MpZeXJmT9enF7li9n4FtRJ9NNac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=h9uBWBrIgF7u46NvXIMEDSSSgPxKztA6FmiIrmLb2BWjYr+4VyeieF2D/ZoGpi5xK7
         Pbc3DpueDdg5KvwsxtAs88X6zbTdytHsdfWxvdlItMgIm7OoUk9APNfS2kHbSQBS2Zlj
         h7cRMIqSNqdnM9qUC+DZcxQ+w8CFL/73IUhiI=
Received: by 10.204.54.69 with SMTP id p5mr4371973bkg.82.1296399461769; Sun,
 30 Jan 2011 06:57:41 -0800 (PST)
Received: by 10.204.101.69 with HTTP; Sun, 30 Jan 2011 06:57:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165683>

--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
