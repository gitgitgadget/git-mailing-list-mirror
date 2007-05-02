From: Peter <petervanbohning@gmail.com>
Subject: FAQ Q: another version control system?
Date: Wed, 2 May 2007 03:13:49 -0400
Message-ID: <9e7886190705020013k5721480aj767c1c8643fc8d23@mail.gmail.com>
References: <9e7886190705020012n72070874nae5a74b6d1387e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 09:13:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj92B-0002W4-5w
	for gcvg-git@gmane.org; Wed, 02 May 2007 09:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbXEBHNv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 03:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754889AbXEBHNv
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 03:13:51 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:46907 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbXEBHNu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 03:13:50 -0400
Received: by an-out-0708.google.com with SMTP id b33so36256ana
        for <git@vger.kernel.org>; Wed, 02 May 2007 00:13:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XFHyzjJR7wUluqt5/D3DlmtMuoS+KIA2piRrhB/yhslRy+Pj6plZcYJP2MHAynR7m3OmL5asm4BkefqDP34TGqBuX2PbYWYIKGDULIj4HSS735q/2jqkStJM5dwHXqDhDWxUO8+/fKFvLpzz1U41WPocEEpJHeJIRrskqVL/OaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=p2uPVM8mjpaynGN+Y7yG6o4nTUlIZBZLfI5LU1mohRYf6l3yogOzDUeF/ltHgqhTa9DeplNCiImtm1Hb6sDzvKLvNn/e30Dqd1Te6lVmS+IrTX/r4ojyNf2JidpuduVm3ZXAAZLi5a0B9xhZuZOuTZQEI2kaDZosnFqpmQSsu9s=
Received: by 10.100.39.17 with SMTP id m17mr264848anm.1178090030257;
        Wed, 02 May 2007 00:13:50 -0700 (PDT)
Received: by 10.100.135.15 with HTTP; Wed, 2 May 2007 00:13:49 -0700 (PDT)
In-Reply-To: <9e7886190705020012n72070874nae5a74b6d1387e3@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 13b50dd0fcb315c1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46004>

Do we really need another version control system?  As I understand it,
this is like a distributed, central-server-less, CVS, sorry, SVN
server.

But why isn't such a feature set added into SVN?  Why do I have to
download another version control system just so that I can "git"
libxcb and X11 so that I can compile gtk so that I can compile xchat
so that I can go onto the IRC server for madwifi so that I can ask
someone there why their wifi drivers don't create a /dev/wifi0 on my
system so that I can get my wireless working????

Aaaaah.
