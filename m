From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0] Some gitweb patches
Date: Sat, 29 Jul 2006 22:39:04 +0200
Message-ID: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 29 22:39:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6vaZ-0005aP-59
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 22:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWG2UjH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 16:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWG2UjH
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 16:39:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:32906 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932226AbWG2UjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 16:39:05 -0400
Received: by ug-out-1314.google.com with SMTP id m3so205414ugc
        for <git@vger.kernel.org>; Sat, 29 Jul 2006 13:39:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R2U6MxGAvu2aOZ0Vdv5zh0JHNviQx9yZn39iGXp8f28FNxBGQjKO2ZwkG7g2L7a+S0kFSmnWmEQSCMDot2ekXG4vkK1G/bFsFcBU8MnUiqkN6L29ito/OjrRZ5/qaFief0nUG/0MTVug0lT5C0IK5bGgqaA+8Gt4nuYtSGOq0Vw=
Received: by 10.67.100.12 with SMTP id c12mr980489ugm;
        Sat, 29 Jul 2006 13:39:04 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id u1sm1831224uge.2006.07.29.13.39.03;
        Sat, 29 Jul 2006 13:39:04 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24432>

This series of patches, based on 'next' branch (v1.4.2-rc2-g688a750 or 
688a75071490101dbc660e3304aafb7a13e28807) is the beginning of gitweb 
cleanup. It would hopefully introduce no new features.

Open-ended series...

-- 
Jakub Narebski
Poland
