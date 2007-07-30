From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Merging into a current branch
Date: Mon, 30 Jul 2007 15:10:36 +0930
Message-ID: <93c3eada0707292240qe92aa57s5c5152e078693a53@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 07:41:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFO0D-0000WX-WC
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 07:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbXG3Fki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 01:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761301AbXG3Fki
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 01:40:38 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:41942 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765553AbXG3Fkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 01:40:37 -0400
Received: by py-out-1112.google.com with SMTP id d32so2574650pye
        for <git@vger.kernel.org>; Sun, 29 Jul 2007 22:40:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MkEjtza7vrj+PtN2WgZ/+RHo/qS2OWvTAdYufbBfs8KUXqywAhKW19/gocsM19pwd0vmKpnQdeA/hK9a6dcr/Qb5HaOru+DwehzS5KZX/HOIpRJJRr3xmoMklER3sXhmF9bH8yNXfiU7srpui41q5chGriKv+VF+/lY56nZxnkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nLx8RTF06qM6kqY52Bun+x5GBO6dCeovyDo8uAukSa+B8vd3KfGgMbZ1zGHTfyo4+d3XY17gOGvbBeK3SCWDKIdQd1EHmcprxKWhCdT+688dZrQ4bRQAk29QNiTi81CBPCaBjyow728nLRpLsikacQNcU6Do+rAZCRGBYSxxRnI=
Received: by 10.65.241.20 with SMTP id t20mr7991967qbr.1185774036207;
        Sun, 29 Jul 2007 22:40:36 -0700 (PDT)
Received: by 10.65.73.18 with HTTP; Sun, 29 Jul 2007 22:40:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54189>

Dear gits,

Is there any reason why

git fetch origin branchX:branchX

fails if I am on branchX?   All I want to do is fast forward it.

Cheers,
Geoff.
