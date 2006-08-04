From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/5] Some further gitweb patches
Date: Sat, 5 Aug 2006 00:36:06 +0200
Message-ID: <200608050036.06490.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 05 00:35:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G98GS-00069d-J1
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 00:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161541AbWHDWf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 18:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161542AbWHDWf3
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 18:35:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:57539 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161541AbWHDWf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 18:35:28 -0400
Received: by nf-out-0910.google.com with SMTP id k26so43582nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 15:35:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qsl0WVPN8DBfDsarfGqE7yesTcaROwqdiI+0Q03HoAXvyZ5wAH0+Cya6/F7MWBRXhR6gtr2oiqo4Vvsc8VgPnysevelp6rezfb8x0wgPE8HkenBPE8a7N5lCKbeUTYxnHDLZdNrQmNf4GR1NSSaSGkJG/G62i4FT39cWtbE835Y=
Received: by 10.49.10.3 with SMTP id n3mr6032730nfi;
        Fri, 04 Aug 2006 15:35:27 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id p72sm2938268nfc.2006.08.04.15.35.27;
        Fri, 04 Aug 2006 15:35:27 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24854>

Based on 'next' branch, v1.4.2-rc3-g1c4b267

This is also kind of cleanup series of patches, although it introduces 
minor improvements (patches 1 and 5).

This series does not include latest Luben Tuikov series...
-- 
Jakub Narebski
Poland
