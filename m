From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: git status options feature suggestion
Date: Thu, 9 Oct 2008 01:34:41 -0400
Message-ID: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 07:35:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnoBo-00031D-1b
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 07:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbYJIFen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 01:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbYJIFen
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 01:34:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:64361 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbYJIFem (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 01:34:42 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4629338rvb.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 22:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=qh+cEwPjuve8j6/UIip6H49ADaQwuCvMYRK8XGLH6tE=;
        b=ELvfWjVHTIxdQ8PFvxFbvwnJ8tsPQ2jK4GcYlOnNm/bXuwVDfHtetdjS/JzqJZZVqF
         nW0V9sv3X71QQ0CEboRqKaiqWxj/1tnZ4UvfTyE9ah0cgb/17dFPMWZ3srSsHeJJ265a
         Gnh6AXOLMORIfgoL0t0QgqCluZZzkHmcLBhuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=kN0tkYUljk90g9xh2j8d3r4wNg610dgYIzNrm97VBbuF/0lhn8VgB70g6OZWmNgODm
         e0kYVbJh1hdQDlN7qsnBZGTy2YPbLTqhpqnmUxEtCMhpox8REQ/sLhugtdlk9BxNnH7K
         E6WOHTcFahl1LzAM+sPJ6r7mCtldYt9btx5ho=
Received: by 10.140.141.16 with SMTP id o16mr5781196rvd.209.1223530481942;
        Wed, 08 Oct 2008 22:34:41 -0700 (PDT)
Received: by 10.141.145.7 with HTTP; Wed, 8 Oct 2008 22:34:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97820>

I was just doing a git status for a large add and all I really wanted
to see was the untracked files maybe git status could have options
like --new --untracked --modified to only show those.

I'm not on the list.

--
Caleb Cushing
