From: Patrick Altman <paltman@gmail.com>
Subject: Git Library?
Date: Mon, 28 Apr 2008 13:55:35 -0500
Message-ID: <5FCF765E-F3FF-438C-B4C1-FFB3262831A0@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 20:56:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYWe-00079T-9O
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 20:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935562AbYD1Szl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 14:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935413AbYD1Szk
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:55:40 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:54724 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935348AbYD1Szj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 14:55:39 -0400
Received: by py-out-1112.google.com with SMTP id u52so7984248pyb.10
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=jppeG9tq8tHDx1aIXnpSL7G+EoQYrBuXUWdFKkEY80M=;
        b=ZQ3abB/2v/HyjFA6lRStz6w61qd3ACZrvzVN9tOPJlUDgVCx2eNbP9nCoONQ4DH6UZSsyzfqIfnWGLMrhYX6tft6EixeYRBNZuJ6aLPtFX4OG4XOvRTWe2GA6nNUMjt1of3KCiy+IZ2cvulIvCU+w5bEEtbcvE6ucImou/0CadY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=YeoV/ddahwxkuiUUEZX/a4kGeR9q65iZGmjJ0MbpOicmIW3lnhSqvHM9f9yYsawN/YohS5E976kaPV9+Ph9KnPe2y0dG/xY5RGhCixzDoUcFfALCTspT38f4EBCEmf8bkoRBK85fg+cLs4MjgU+cLBPFRG7D4mpsBZhFMTZQLHc=
Received: by 10.35.8.13 with SMTP id l13mr13730205pyi.35.1209408938863;
        Mon, 28 Apr 2008 11:55:38 -0700 (PDT)
Received: from PatrickMac.SME ( [71.4.241.34])
        by mx.google.com with ESMTPS id p77sm7990961pyb.16.2008.04.28.11.55.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Apr 2008 11:55:37 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80585>

I want to write a Mac OSX UI for git.

Is there a documented/undocumented API for interacting with git in  
process?  Or would I be better off "shelling out" to the git command  
line?

Thanks,
Patrick Altman


---
Patrick Altman
(615) 300-2930
