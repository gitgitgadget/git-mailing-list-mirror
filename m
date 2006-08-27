From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] gitweb: Get rid of failed experiments ;-)
Date: Sun, 27 Aug 2006 23:43:14 +0200
Message-ID: <200608272343.14653.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 27 23:45:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHSRp-0004Nu-AQ
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 23:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWH0Vpb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 17:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWH0Vpa
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 17:45:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:8973 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932291AbWH0Vp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 17:45:28 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1123457nfa
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 14:45:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZmGrVD1BIVN+HTNmjL+cO0WTQVfGu0YEteVYHLA+uJQikU0p8aXr/ceimUSNAIk1hQzvtZ91Mr+ylu7kR7jNohvI/juOH5WIcSJ1FEr3/SwYh5sGUSFwyBgx3v+FhTGFEjUvARzl46fkT7/TyWDskx37SSrOMZz9G/ykD3yZevQ=
Received: by 10.48.48.15 with SMTP id v15mr8241036nfv;
        Sun, 27 Aug 2006 14:45:26 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id q28sm3913698nfc.2006.08.27.14.45.26;
        Sun, 27 Aug 2006 14:45:26 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26116>

Remove unused subroutines or subroutines which don't work correctly from 
gitweb.

-- 
Jakub Narebski
Poland
