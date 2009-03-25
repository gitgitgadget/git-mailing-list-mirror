From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] init-db: support --import to add all files and commit 
	right after init
Date: Wed, 25 Mar 2009 15:25:44 +1100
Message-ID: <fcaeb9bf0903242125kf6281acp9f1289a1c0e3e79b@mail.gmail.com>
References: <1237946996-5287-1-git-send-email-pclouds@gmail.com> 
	<alpine.DEB.1.00.0903250450240.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 05:27:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmKiD-0006qp-Jp
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 05:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZCYE0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 00:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbZCYE0D
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 00:26:03 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:26005 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbZCYE0B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 00:26:01 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3818216wff.4
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 21:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=44zm9E14G2Uf9SJojyW2Y/tNi1qMp8A0+MrU/KRVY9Q=;
        b=AbmpM50ft1wEX52HFkS58e2uYlqPKizj1f2cOJsJGScHYFiQ9ao4SDxpWoxgP14aHh
         hVjXBRPXMLTx1W7q4oBBy1guzSuMtGmlWtP0bgE2QD4LvXWCRWNU2BXjTBC2g+KG/Dhv
         9PjIrjfxFp+0D+WMIVevZ8zwrfYrzb5GdsS4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ij3EkZCRzxD1sClGJahRS+0YcVmzKUqDW/eSddYY8xYTKEcbT2c5FXLpVWphofO1Kk
         X0BuzbtW/KE4HM7Ho8kcf2DB9lspVworw3wNE6Bl7ipNtg3sjYzoIqy6rsItl67XzF3p
         0sPoBoadnaRz2b60askNCLJVkbcvDt8+hrT6E=
In-Reply-To: <alpine.DEB.1.00.0903250450240.10279@pacific.mpi-cbg.de>
Received: by 10.142.214.11 with SMTP id m11mr3733081wfg.57.1237955159191; Tue, 
	24 Mar 2009 21:25:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114560>

2009/3/25 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> But could you please say "init" in the subject instead of "init-db"? =
=C2=A0The
> latter is just a historical wart we have to carry around.

OK. No problem.
--=20
Duy
