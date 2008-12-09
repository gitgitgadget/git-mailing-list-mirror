From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: get upstream branch
Date: Mon, 8 Dec 2008 20:52:03 -0800
Message-ID: <3ab397d0812082052j6a45d05dr1c863aa260826f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 05:53:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9ubE-0004T6-Ux
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 05:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbYLIEwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 23:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbYLIEwH
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 23:52:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:53064 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbYLIEwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 23:52:05 -0500
Received: by ug-out-1314.google.com with SMTP id 39so956291ugf.37
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 20:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=UjaWkvM2U/f72tNyQMWmKv05wA9FPrDAXbi2Ro1lxZ0=;
        b=oQ8eeo+31nNYQL5xXJEivnnYTUvwaBuPduQ0GTIjh7EBYMADjrAL2QNHITFSfO4NHo
         UaHu4Gb6DNyacrXc3UJBXU+4DP/SzU0fkzOCkWLSuE8sIpU97GkcHmfPHBNkPBgID+A+
         LaGeIs6N+ZZc/FnOGK9okFJYliwSQ37d0BB84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=KBztHYVAhGxrw1ltF31a4hndEIjCEPAn/nZmfH2iDWkc6NbL6ybMW4+LEl8pR3dtX9
         KkuilK86iHqn28Qtuvd0dqjlZts8kBXO8zuMH2ONRwdZPVEUIqmbS5avOM7g8TRwCdnL
         n5sFfznfdqKJoZSeaZRuoox4XQNm4i2yDKInY=
Received: by 10.67.40.6 with SMTP id s6mr2956055ugj.10.1228798323511;
        Mon, 08 Dec 2008 20:52:03 -0800 (PST)
Received: by 10.66.220.9 with HTTP; Mon, 8 Dec 2008 20:52:03 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102596>

Hi,

Does anyone know how to programmatically get the upstream/parent
branch of a branch?  I'm trying to write a gui, but looking at gitk's
tcl code isn't helping me much.

Thanks,

Whiteside
