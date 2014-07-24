From: Sheldon Els <sheldon@easyfundraising.org.uk>
Subject: git feature-branch
Date: Thu, 24 Jul 2014 23:15:58 +0100
Message-ID: <CAJnDmGJ16NRV7kUuwE7Cr6Pc202yq8YuXdUB-5=aXRQWCDfK2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 00:16:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XARJH-0003kR-LZ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 00:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759677AbaGXWQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 18:16:19 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:48927 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759665AbaGXWQT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 18:16:19 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so6000469vcb.23
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=8pPi29dkiOpZlmWROV4Sir2/bRvyO6OuyMkDboWmOwk=;
        b=pKOid+/SYyhkgBcXLn8Wla7U/MI7DXkfBO4z6OfZPeN88/fpihSVCCaEwF1xISnUCT
         MkFKFYcSUP7zRDSHN3hVTNnU16X1Lvvdk8XKZfFO3SkQnf9jP0D+bvqrLK+ViDgpp4yN
         KLONtC15nRLm5umch6xO5tQ8DFz2WlOkrI271L+CvcUQAlFl7vyB+qc7DEIc8jEXzk6y
         hWHFSmKjD6k6R7GK2P2EmD6wFopJOLnq/1f8Ge0LrqAcvwZ+0Uh7/oE1QVJCLn48oE0Q
         yG50bwobLlCOo+hRhoAifHCSgXpOogame0m4dVunPFnyqDuZZ98XJcJdM7rlpLyIxFp8
         7veQ==
X-Received: by 10.221.26.71 with SMTP id rl7mr16543418vcb.69.1406240178423;
 Thu, 24 Jul 2014 15:16:18 -0700 (PDT)
Received: by 10.58.212.71 with HTTP; Thu, 24 Jul 2014 15:15:58 -0700 (PDT)
X-Google-Sender-Auth: jWhptBaiInng3ZPdN5rE4B1uLQs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254189>

Hi

A small tool I wrote that is useful for some workflows. I thought it'd
be worth sharing. https://github.com/sheldon/git-feature-branch/

Sheldon
