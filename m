From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Cogito bug on Debian
Date: Fri, 21 Apr 2006 11:17:30 +1200
Message-ID: <46a038f90604201617i79f283a9m8ff6a9e0462d8357@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Apr 21 01:17:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWiP1-0006J1-66
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 01:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWDTXRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 19:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWDTXRb
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 19:17:31 -0400
Received: from wproxy.gmail.com ([64.233.184.229]:53279 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932108AbWDTXRb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 19:17:31 -0400
Received: by wproxy.gmail.com with SMTP id i2so101618wra
        for <git@vger.kernel.org>; Thu, 20 Apr 2006 16:17:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fM2d+XwaJmjRo8XQ+8Z0Cs57lJyl4X6ZIL+SzWh7f/WOiCxd+LOeI+BKkW7MoLxP1I4E/Ciyyfk5oqXLmtgiz7xtjHqZiS+18xFKhMitGOQjjSlYHtFFrwS7gvLdX9+j9luqp8fJRABdXFrSz6/jXZkWdE3cNvSdF2aILLgHj/s=
Received: by 10.54.106.17 with SMTP id e17mr1139022wrc;
        Thu, 20 Apr 2006 16:17:30 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Thu, 20 Apr 2006 16:17:30 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>,
	"Petr Baudis" <pasky@suse.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19008>

This was spotted circulating on Catalyst's IRC channel. Apparently,
the bug "causes non-serious data loss".

     http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=330031

cheers,


martin
