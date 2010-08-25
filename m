From: Scott Chacon <schacon@gmail.com>
Subject: Does anyone use git-notes?
Date: Wed, 25 Aug 2010 11:15:31 -0700
Message-ID: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 25 20:15:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoKVi-0006ic-79
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 20:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab0HYSPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 14:15:35 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44316 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab0HYSPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 14:15:33 -0400
Received: by eyg5 with SMTP id 5so523645eyg.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=X/hJvQpMSV6FOg55WbflXLg3yJRlqTkuUC106fvSrwY=;
        b=s6wpzKLePleBea54mCbHz5BOwEXbThqN3ssUGnsKNPOS27n1JKdmf8nlh5KV/YdPml
         IzR7ymCwMoWtM4xqGux4t9CD5c8HVqBN4ES3LJs6B2p+WkCs4BttSZTkuQHBnzEpnry8
         LbFEYFN/ukMDcpX8XE9fiwFFz0oKxoxoigVTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=k1ryJqU/8F1u4QNrZmv2DxW917gbHyevq+b/ro6gOVj1VE7Sd9kVvIOo78jefDBwyf
         uwlKvXBJYwmQyqnO+H7XCa23C1CbIHE2aKoyB8RPr3OoavcQbxxd8ggdqOaMSqrws/pj
         DphjPJDq3akEVDH5dkoNxsYhp6JG6bUR1wnxg=
Received: by 10.213.25.74 with SMTP id y10mr7123892ebb.3.1282760132374; Wed,
 25 Aug 2010 11:15:32 -0700 (PDT)
Received: by 10.14.124.202 with HTTP; Wed, 25 Aug 2010 11:15:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154455>

I would like to write a post on how to use them, but I'm a bit
confused as to how people actually use them on a day to day basis.  I
appears to me in trying to work out a flow for them that the lack of
an ability to merge them makes them very difficult to use for anything
practical.  Can someone share with me how they use them and what the
cycle is?

Thanks,
Scott
