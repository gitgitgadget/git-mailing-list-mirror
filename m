From: "Pat Maddox" <pergesu@gmail.com>
Subject: Updating submodules
Date: Sat, 5 Apr 2008 15:46:40 -0700
Message-ID: <810a540e0804051546o250bd3e7mf7a20d8f1cc6dcfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 00:47:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiHAg-0001OD-0U
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 00:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbYDEWqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 18:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbYDEWqm
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 18:46:42 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:54795 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbYDEWql (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 18:46:41 -0400
Received: by wa-out-1112.google.com with SMTP id v27so625762wah.23
        for <git@vger.kernel.org>; Sat, 05 Apr 2008 15:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=urxCsW8GCw6CjsSK3xKcQ+2evy+mTXbz6aoTLtOcA0s=;
        b=io+q7+TcV693QPVBJJnTmccCfLpZvYcx7IJvbVU2w0JYR9hjOuKe1PRzfV6d95Par3ld9wGgRRHh7X8redkmhq3+DKw4XUW4FgI9so8wvq9UFMmaWbDPD0zudlsWxERoXFyqGHgE2s/b9mU5BPLdrCJtyz0sKzFJDeNlWKDwveI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kQNg0a2XLNCkBRWb0jPTw7UDv/0yYKXvRl4IM2Jw0MheqgFX48gZKGx+D+v1xd6wJLipGVRsBGpaJ44/p79Ndu9nvVCiKMlvMYcMBHRDzz1bDvRPvoJnLJY4makcdazmWJNXO0TVA04AorySKwD+odR0oPPdTqaKRhziivL24ps=
Received: by 10.114.166.1 with SMTP id o1mr4309709wae.5.1207435600418;
        Sat, 05 Apr 2008 15:46:40 -0700 (PDT)
Received: by 10.114.146.5 with HTTP; Sat, 5 Apr 2008 15:46:40 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78864>

Do I need to cd into each submodule dir and fetch/rebase?  git
submodule update doesn't seem to do anything, though I would assume
it's used to update the submodules...

Pat
