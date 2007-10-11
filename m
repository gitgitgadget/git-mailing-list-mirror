From: "Thomas Harning Jr." <harningt@gmail.com>
Subject: Suggestion for mailing lists... split [PATCH]-es into own list
Date: Thu, 11 Oct 2007 11:57:38 -0400
Message-ID: <e47324780710110857s472bf099u3e350d17a2c29f78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 17:58:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig0QM-00010N-Td
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 17:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113AbXJKP5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 11:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754924AbXJKP5l
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 11:57:41 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:54620 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261AbXJKP5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 11:57:40 -0400
Received: by nz-out-0506.google.com with SMTP id s18so468986nze
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=2tfix8qe0nZqElmJjyNpDaSCdk1vyvAkGdacKVfDN8w=;
        b=BdZl5jofK8t781jula39rLX2hJb3EQXOdp3pQc/9LYuuhD/udk9bRZV66BFPa1oMfH2AEcSkuimKbVoPNtWzlg1eT0owrKm7H2fJysU+drc43gapBOZn/+KCADdifCSX7wGnWGcBG+3AEpuvqi/Hj47tFiTBm5ycdbdbBy0ndoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JMojsCpBqxpKbTSqSl8LNpTkyglUuCYntLW9+WonqGwzhXwZWU0oQgWfYrRfleanH1f4Uk0gHEpCfX95V89bRbK+cDyuvCP0dYR7DSdWmvv10GAViP3RwE5YeQaWmalsv/x6old2asBybtNcXkBdASISi3/MKmpkyjQ9Olyiets=
Received: by 10.142.242.8 with SMTP id p8mr652807wfh.1192118258213;
        Thu, 11 Oct 2007 08:57:38 -0700 (PDT)
Received: by 10.142.213.4 with HTTP; Thu, 11 Oct 2007 08:57:38 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60610>

I use gmail as my mail client and it doesn't grok 'PATCH' filters
(primarily the case of the word).

Are there any of you using Gmail that has managed to get around this issue....?

Perhaps we should have a separate mailing list for patches vs discussion.

-- 
Thomas Harning Jr.
